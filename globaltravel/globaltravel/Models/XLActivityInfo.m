//
//  XLActivityInfo.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLActivityInfo.h"

@interface XLActivityInfo () {
    NSMutableDictionary *_attributes;
}

@end

@implementation XLActivityInfo

- (instancetype)initWithElement:(TFHppleElement *)element {
    if (self = [super init]) {
        _attributes = [NSMutableDictionary dictionary];
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
        if (_imagePath && _imagePath.length > 0) {
            [_attributes setObject:_imagePath forKey:@"imagePath"];
            return;
        }
    }
    _imagePath = nil;
    [_attributes removeObjectForKey:@"imagePath"];
}

- (void)setLinkURL:(NSString *)linkURL {
    if ([linkURL isKindOfClass:[NSString class]]) {
        _linkURL = [linkURL copy];
        if (_linkURL && _linkURL.length > 0) {
            [_attributes setObject:_linkURL forKey:@"linkURL"];
            return;
        }
    }
    _linkURL = nil;
    [_attributes removeObjectForKey:@"linkURL"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - Attributes:%@", NSStringFromClass([XLActivityInfo class]), _attributes];
}

@end
