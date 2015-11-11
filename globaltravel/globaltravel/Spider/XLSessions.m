//
//  XLSessions.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLSessions.h"

#import "XLActivityInfo.h"
#import "XLMarketInfo.h"
#import "XLTravelInfo.h"
#import "XLNewsInfo.h"

#import "NSString+UrlEncode.h"
#import "NSString+MD5.h"

#define HTML_HOME @"index.html"
#define HTML_TRAVEL @"travel.html"

#define NEWS_BAIDU @"http://news.baidu.com/ns?cl=2&rn=20&tn=news&word="
#define NEWS_WORDS @"北京时代环球国际旅游有限公司"

@implementation NSData (Sessions)

- (void)cacheToDisk:(NSString *)fileName {
    NSString *fileNameMD5 = [fileName MD5];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directory = [[paths objectAtIndex:0] stringByAppendingPathComponent:HTML_CACHE];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if (![fileManager fileExistsAtPath:directory isDirectory:&isDirectory]) {
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path = [directory stringByAppendingPathComponent:fileNameMD5];
    
    [self writeToFile:path atomically:YES];
}

@end

@implementation NSString (Sessions)

- (NSData *)getCacheDataFromDisk {
    NSString *fileNameMD5 = [self MD5];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [[[paths objectAtIndex:0] stringByAppendingPathComponent:HTML_CACHE] stringByAppendingPathComponent:fileNameMD5];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data && data.length > 0) {
        return data;
    }
    return nil;
}

- (NSString *)htmlPathString {
    if (self) {
        return [NSString stringWithFormat:@"%@%@", HTML_BASE, self];
    }
    return HTML_BASE;
}

- (NSString *)formatHtmlString {
    NSString *string = [self copy];
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&amp" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return string;
}

@end

@implementation XLSessions

+ (XLSessions *)shareSessions {
    static XLSessions* sharedSessions = nil;
    if (!sharedSessions) {
        static dispatch_once_t once = 0;
        dispatch_once(&once, ^{
            sharedSessions = [[XLSessions alloc] init];
        });
    }
    return sharedSessions;
}

- (void)getNewsDataSuccess:(void (^)(NSArray *))success failed:(void (^)(void))failed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataURL = [NSString stringWithFormat:@"%@%@", NEWS_BAIDU, [NEWS_WORDS urlEncode]];
        NSString *newsString = [[XLSpider shareSpider] spideStringWithURL:dataURL encoding:NSUTF8StringEncoding];
        newsString = [newsString stringByReplacingOccurrencesOfString:@"<em>" withString:@"@keyword-start@"];
        newsString = [newsString stringByReplacingOccurrencesOfString:@"</em>" withString:@"@keyword-end@"];
        NSData *newsData = nil;
        if (newsString && newsString.length > 0) {
            newsData = [newsString dataUsingEncoding:NSUTF8StringEncoding];
        }
        if (newsData && newsData.length > 0) {
            [newsData cacheToDisk:dataURL];
        } else {
            newsData = [dataURL getCacheDataFromDisk];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (newsData && newsData.length > 0) {
                TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:newsData];
                NSMutableArray *netNewses = [NSMutableArray array];
                NSArray *newses = [xpathParser searchWithXPathQuery:@"//div[@id='content_left']//div//div[@class='result']"];
                for (TFHppleElement *news in newses) {
                    [netNewses addObject:[[XLNewsInfo alloc] initWithElement:news]];
                }
                success(netNewses);
            } else {
                failed();
            }
        });
    });
    
}

- (void)getHomeDataSuccess:(void (^)(NSArray *, NSArray *))success failed:(void (^)(void))failed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataURL = [HTML_HOME htmlPathString];
        NSData *homeData = [[XLSpider shareSpider] spideDataWithURL:dataURL];
        if (homeData && homeData.length > 0) {
            [homeData cacheToDisk:dataURL];
        } else {
            homeData = [dataURL getCacheDataFromDisk];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (homeData && homeData.length > 0) {
                TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:homeData];
                NSMutableArray *netActivities = [NSMutableArray array];
                NSArray *activities = [xpathParser searchWithXPathQuery:@"//div[@class='center2']//div[@class='banner']//div[@id='et-slider-wrapper']//div[@id='et-slides']//div[@class='et-slide']"];
                for (TFHppleElement *activity in activities) {
                    [netActivities addObject:[[XLActivityInfo alloc] initWithElement:activity]];
                }
                
                NSMutableArray *netMarkets = [NSMutableArray array];
                NSArray *markets = [xpathParser searchWithXPathQuery:@"//div[@class='banner_area']//table//tr"];
                for (TFHppleElement *market in markets) {
                    NSMutableArray *netMarketSection = [NSMutableArray array];
                    if (market.children && market.children.count > 0) {
                        [market.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            XLMarketInfo *markeInfo = [[XLMarketInfo alloc] initWithElement:obj];
                            [netMarketSection addObject:markeInfo];
                            [netMarketSection addObjectsFromArray:markeInfo.brothers];
                        }];
                    }
                    [netMarkets addObject:netMarketSection];
                }
                success(netActivities, netMarkets);
            } else {
                failed();
            }
        });
    });
}

- (void)getTravelDataSuccess:(void (^)(NSArray *))success failed:(void (^)(void))failed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataURL = [HTML_TRAVEL htmlPathString];
        NSData *travelData = [[XLSpider shareSpider] spideDataWithURL:dataURL];
        if (travelData && travelData.length > 0) {
            [travelData cacheToDisk:dataURL];
        } else {
            travelData = [dataURL getCacheDataFromDisk];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *netTravels = [NSMutableArray array];
            if (travelData && travelData.length > 0) {
                TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:travelData];
                NSArray *travels = [xpathParser searchWithXPathQuery:@"//div[@class='contbg']//div[@class='right']//div[@class='list']"];
                for (TFHppleElement *travel in travels) {
                    [netTravels addObject:[[XLTravelInfo alloc] initWithElement:travel]];
                }
                success(netTravels);
            } else {
                failed();
            }
        });
    });
}

@end
