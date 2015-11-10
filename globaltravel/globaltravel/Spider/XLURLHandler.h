//
//  XLURLHandler.h
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLCommon)

- (NSString *)urlString;

@end

@interface XLURLHandler : NSObject

+ (XLURLHandler *)shareHandler;

- (void)handlerURL:(NSString *)urlString title:(NSString *)title;

@end
