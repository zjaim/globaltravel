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

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.imagePath = [dict stringValueOfKey:@"img"];
    }
    return self;
}

- (instancetype)initWithSpiderString:(NSString *)string {
    if (self = [super init]) {
        _attributes = [NSMutableDictionary dictionary];
        NSString *href = [string matchedAttribute:@"a href"];
        if (!href || href.length == 0) {
            href = @"";
        }
        _linkURL = [href copy];
        [_attributes setObject:_linkURL forKey:@"linkURL"];
        
        NSString *imgSrc = [string matchedAttribute:@"img src"];
        if (!imgSrc || imgSrc.length == 0) {
            imgSrc = @"";
        }
        _imagePath = imgSrc;
        [_attributes setObject:_imagePath forKey:@"imagePath"];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - Attributes:%@", NSStringFromClass([XLActivityInfo class]), _attributes];
}

@end
