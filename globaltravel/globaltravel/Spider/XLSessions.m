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

@interface XLSessions ()

- (void)getDataThroughString:(NSString *)url encode:(NSStringEncoding)encode filter:(NSArray *)filter success:(void (^)(NSData *data))success failed:(void (^)(void))failed;
- (void)getData:(NSString *)url success:(void (^)(NSData *data))success failed:(void (^)(void))failed;

@end

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

DEFINE_SINGLETON_FOR_CLASS(XLSessions)

- (void)getNewsDataSuccess:(void (^)(NSArray *))success failed:(void (^)(void))failed {
    NSString *dataURL = [NSString stringWithFormat:@"%@%@", NEWS_BAIDU, [NEWS_WORDS urlEncode]];
    NSStringEncoding encode = NSUTF8StringEncoding;
    NSArray *filter = @[@"em"];
    
    [self getDataThroughString:dataURL encode:encode filter:filter success:^(NSData *data) {
        if (data && data.length > 0) {
            TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
            NSMutableArray *netNewses = [NSMutableArray array];
            NSArray *newses = [xpathParser searchWithXPathQuery:@"//div[@id='content_left']//div//div[@class='result']"];
            for (TFHppleElement *news in newses) {
                [netNewses addObject:[[XLNewsInfo alloc] initWithElement:news]];
            }
            success(netNewses);
        } else {
            failed();
        }
    } failed:failed];
}

- (void)getHomeDataSuccess:(void (^)(NSArray *, NSArray *))success failed:(void (^)(void))failed {
    NSString *dataURL = [HTML_HOME htmlPathString];
    [self getData:dataURL success:^(NSData *data) {
        if (data && data.length > 0) {
            TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
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
    } failed:failed];
}

- (void)getTravelDataSuccess:(void (^)(NSArray *))success failed:(void (^)(void))failed {
    NSString *dataURL = [HTML_TRAVEL htmlPathString];
    [self getData:dataURL success:^(NSData *data) {
        NSMutableArray *netTravels = [NSMutableArray array];
        if (data && data.length > 0) {
            TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
            NSArray *travels = [xpathParser searchWithXPathQuery:@"//div[@class='contbg']//div[@class='right']//div[@class='list']"];
            for (TFHppleElement *travel in travels) {
                [netTravels addObject:[[XLTravelInfo alloc] initWithElement:travel]];
            }
            success(netTravels);
        } else {
            failed();
        }
    } failed:failed];
}

- (void)getDataThroughString:(NSString *)url encode:(NSStringEncoding)encode filter:(NSArray *)filter success:(void (^)(NSData *))success failed:(void (^)(void))failed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = nil;
        __block NSString *string = [[XLSpider sharedInstance] spideStringWithURL:url encoding:encode];
        if (string && string.length > 0) {
            if (filter && filter.count > 0) {
                [filter enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[NSString class]]) {
                        __weak NSString *filterStr = obj;
                        string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<%@>", filterStr] withString:@""];
                        string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"</%@>", filterStr] withString:@""];
                    }
                }];
            }
        }
        if (string && string.length > 0) {
            data = [string dataUsingEncoding:encode];
        }
        if (data && data.length > 0) {
            [data cacheToDisk:url];
        } else {
            data = [url getCacheDataFromDisk];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data && data.length > 0) {
                success(data);
            } else {
                failed();
            }
        });
    });

}

- (void)getData:(NSString *)url success:(void (^)(NSData *))success failed:(void (^)(void))failed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = nil;
        data = [[XLSpider sharedInstance] spideDataWithURL:url];
        if (data && data.length > 0) {
            [data cacheToDisk:url];
        } else {
            data = [url getCacheDataFromDisk];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data && data.length > 0) {
                success(data);
            } else {
                failed();
            }
        });
    });
}

@end
