//
//  XLCommon.h
//  globaltravel
//
//  Created by xinglei on 11/15/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGBACOLOR(r,g,b,a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width

#define STATUSBAR_HEIGHT      [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT         44
#define TABBAR_HEIGHT         49

#define FONT(s)               [UIFont systemFontOfSize:s]
#define BOLD_FONT(s)          [UIFont boldSystemFontOfSize:s]

#define ScreenScale(s)        (SCREEN_WIDTH / 320.f * s)

// gcd singleton
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedInstance;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedInstance { \
    static className *shared##className = nil; \
    if (!shared##className) { \
        static dispatch_once_t onceToken = 0; \
        dispatch_once(&onceToken, ^{ \
            shared##className = [[self alloc] init]; \
        }); \
    } \
    return shared##className; \
}

void dispatch_sync_in_main_queue(dispatch_block_t block);
void dispatch_async_in_main_queue(dispatch_block_t block);

@interface NSArray (Common)

- (BOOL)matched:(id)obj compare:(BOOL (^)(id obj1, id obj2))compare;

@end

@interface NSDictionary (Common)

- (BOOL)matched:(id)key;

@end
