//
//  XLSessions.h
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTML_BASE @"http://www.bgtc.com.cn/"
#define HTML_CACHE @"html"

@interface NSData (Sessions)

- (void)cacheToDisk:(NSString *)fileName;

@end

@interface NSString (Sessions)

- (void)cacheToDisk:(NSString *)fileName;
- (NSString *)getCacheStringFromDisk;
- (NSData *)getCacheDataFromDisk;
- (NSString *)htmlPathString;
- (NSString *)formatHtmlString;

@end

@interface XLSessions : NSObject

+ (XLSessions *)shareSessions;

- (void)getHomeDataSuccess:(void (^)(NSArray *netActivities, NSArray *netMarkets))success failed:(void (^)(void))failed;

- (void)getTravelDataSuccess:(void (^)(NSArray *netTravels))success failed:(void (^)(void))failed;

@end
