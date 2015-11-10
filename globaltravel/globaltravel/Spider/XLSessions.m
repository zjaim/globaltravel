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

#import "NSString+MD5.h"

@implementation NSString (Sessions)

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
    
    [self writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)getCacheFromDisk {
    NSString *fileNameMD5 = [self MD5];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [[[paths objectAtIndex:0] stringByAppendingPathComponent:HTML_CACHE] stringByAppendingPathComponent:fileNameMD5];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data && data.length > 0) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)htmlPathString {
    if (self) {
        return [NSString stringWithFormat:@"%@%@", HTML_HOME, self];
    }
    return HTML_HOME;
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

- (void)getHomeDataSuccess:(void (^)(NSArray *, NSArray *))success failed:(void (^)(void))failed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *homeString = [[XLSpider shareSpider] spideURL:HTML_HOME];
        if (homeString && homeString.length > 0) {
            [homeString cacheToDisk:HTML_CACHE];
        } else {
            homeString = [HTML_CACHE getCacheFromDisk];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (homeString && homeString.length > 0) {
                NSArray *activityItems = [homeString componentsSeparatedFromString:@"id=\"et-slider-wrapper\"" toString:@"class=\"clear\""];
                NSMutableArray *activities = [NSMutableArray array];
                [activityItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[NSString class]]) {
                        NSMutableArray *activityStrings = [[(NSString *)obj componentsSeparatedByString:@"class=\"et-slide\""] mutableCopy];
                        if (activityStrings && activityStrings.count > 1) {
                            [activityStrings removeObjectAtIndex:0];
                            [activities addObjectsFromArray:activityStrings];
                        }
                    }
                }];

                NSMutableArray *netActivities = [NSMutableArray array];
                [activities enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[NSString class]]) {
                        [netActivities addObject:[[XLActivityInfo alloc] initWithSpiderString:obj]];
                    }
                }];
                
                NSArray *marketItems = [homeString componentsSeparatedFromString:@"class=\"banner_area\"" toString:@"</table>"];
                NSMutableArray *markets = [NSMutableArray array];
                [marketItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[NSString class]]) {
                        NSMutableArray *marketSection = [NSMutableArray array];
                        NSArray *marketSectionStrings = [(NSString *)obj componentsSeparatedFromString:@"<tr" toString:@"</tr>"];
                        if (marketSectionStrings && marketSectionStrings.count > 0) {
                            [marketSectionStrings enumerateObjectsUsingBlock:^(id obj1, NSUInteger idx1, BOOL *stop1) {
                                if ([obj1 isKindOfClass:[NSString class]]) {
                                    NSMutableArray *marketStrings = [[(NSString *)obj1  componentsSeparatedByString:@"class=\"imgarea\""] mutableCopy];
                                    if (marketStrings && marketStrings.count > 1) {
                                        [marketStrings removeObjectAtIndex:0];
                                        [marketSection addObjectsFromArray:marketStrings];
                                    }
                                }
                            }];
                        }
                        if (marketSection.count > 0) {
                            [markets addObject:marketSection];
                        }
                    }
                }];
                
                NSMutableArray *netMarkets = [NSMutableArray array];
                [markets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[NSArray class]]) {
                        NSMutableArray *netMarketSection = [NSMutableArray array];
                        [(NSArray *)obj enumerateObjectsUsingBlock:^(id obj1, NSUInteger idx1, BOOL *stop1) {
                            [netMarketSection addObject:[[XLMarketInfo alloc] initWithSpiderString:obj1]];
                        }];
                        if (netMarketSection.count > 0) {
                            [netMarkets addObject:netMarketSection];
                        }
                    }
                }];
                
                success(netActivities, netMarkets);
            } else {
                failed();
            }
        });
    });
}

@end
