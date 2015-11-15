//
//  XLActivityInfo.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLActivityInfo.h"

@implementation XLActivityInfo

- (instancetype)initWithElement:(TFHppleElement *)element {
    if (self = [super init]) {
        id img = element[@"@a@"][@"@img@"][@"src"];
        self.imagePath = img;

        id link = element[@"@a@"][@"href"];
        self.linkURL = link;
    }
    return self;
}

- (void)setImagePath:(NSString *)imagePath {
    if ([imagePath isKindOfClass:[NSString class]]) {
        _imagePath = [imagePath copy];
    } else {
        _imagePath = nil;
    }
}

- (void)setLinkURL:(NSString *)linkURL {
    if ([linkURL isKindOfClass:[NSString class]]) {
        _linkURL = [linkURL copy];
    } else {
        _linkURL = nil;
    }
}

@end
