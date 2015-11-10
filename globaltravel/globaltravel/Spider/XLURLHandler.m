//
//  XLURLHandler.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLURLHandler.h"
#import "XLWebViewController.h"

@implementation NSString (URLCommon)

- (NSString *)urlString {
    NSString *urlString = nil;
    if (self && self.length > 0) {
        if ([self hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
            urlString = self;
        } else {
            if (self && self.length > 0) {
                urlString = [[NSString stringWithFormat:@"%@", HTML_HOME] stringByAppendingPathComponent:self];
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

- (void)handlerURL:(NSString *)urlString {
    if (urlString && urlString.length > 0) {
        XLWebViewController *webVC = [XLWebViewController new];
        webVC.urlString = urlString;
        [[self currentNavC] pushViewController:webVC animated:YES];
    }
}

- (UIViewController *)currentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

- (UINavigationController *)currentNavC {
    UINavigationController *result = nil;
    id currentVC = [self currentVC];
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        result = currentVC;
    } else if([currentVC isKindOfClass:[UITabBarController class]]) {
        id vc = [(UITabBarController *)currentVC viewControllers][[(UITabBarController *)currentVC selectedIndex]];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            result = vc;
        } else {
            result = [(UIViewController *)vc navigationController];
        }
    } else if([currentVC isKindOfClass:[UIViewController class]]) {
        result = [(UIViewController *)currentVC navigationController];
    }
    return result;
}

@end
