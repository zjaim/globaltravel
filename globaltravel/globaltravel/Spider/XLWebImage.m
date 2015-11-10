//
//  XLWebImage.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (WebImage)

- (void)xl_setImageWithURL:(NSString *)imageURL {
    NSString *urlString = nil;
    if (imageURL && imageURL.length > 0) {
        if ([imageURL hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
            urlString = imageURL;
        } else {
            urlString = [[NSString stringWithFormat:@"%@", HTML_BASE] stringByAppendingPathComponent:imageURL];
        }
    }
    if (urlString && urlString.length > 0) {
        NSURL *url = [NSURL URLWithString:urlString];
        if (url) {
            [self sd_setImageWithURL:url];
        }
    }
}

@end

@implementation XLWebImage

@end
