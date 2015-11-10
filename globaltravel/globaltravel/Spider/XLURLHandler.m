//
//  XLURLHandler.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLURLHandler.h"
#import "XLWebViewController.h"
#import "XLNavigationViewController.h"

@implementation NSString (URLCommon)

- (NSString *)urlString {
    NSString *urlString = nil;
    if (self && self.length > 0) {
        if ([self hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
            urlString = self;
        } else {
            if (self && self.length > 0) {
                urlString = [[NSString stringWithFormat:@"%@", HTML_BASE] stringByAppendingPathComponent:self];
            }
        }
    }
    return urlString;
}

@end

@implementation XLURLHandler

+ (XLURLHandler *)shareHandler {
    static XLURLHandler* shareHandler = nil;
    if (!shareHandler) {
        static dispatch_once_t once = 0;
        dispatch_once(&once, ^{
            shareHandler = [[XLURLHandler alloc] init];
        });
    }
    return shareHandler;
}

- (void)handlerURL:(NSString *)urlString title:(NSString *)title {
    if (urlString && urlString.length > 0) {
        XLWebViewController *webVC = [XLWebViewController new];
        webVC.titleString = title;
        webVC.urlString = urlString;
        [[XLNavigationViewController currentNavC] pushViewController:webVC animated:YES];
    }
}

@end
