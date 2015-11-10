//
//  XLTravelInfo.m
//  globaltravel
//
//  Created by xinglei on 11/9/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLTravelInfo.h"

@interface XLTravelInfo () {
    NSMutableDictionary *_attributes;
}

@end

@implementation XLTravelInfo

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        id value = dict[@"date"];
        if ([value isKindOfClass:[NSDate class]]) {
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            dateFormatter.dateFormat = @"yyyy年M月";
            self.publishDate = [dateFormatter stringFromDate:value];
        }
        self.title = [dict stringValueOfKey:@"title"];
        self.content = [dict stringValueOfKey:@"content"];
        self.imagePath = [dict stringValueOfKey:@"img"];
    }
    return self;
}

- (instancetype)initWithElement:(TFHppleElement *)element {
    if (self = [super init]) {
        _attributes = [NSMutableDictionary dictionary];
        id img = element[@"@class::listimg@"][@"@img@"][@"src"];
        self.imagePath = img;
        
        id date = element[@"@class::listtext@"][@"@h6@"][@""];
        if ([date isKindOfClass:[NSString class]] && [date length] > 0) {
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            dateFormatter.dateFormat = @"发布日期：yy-M";
            NSDate *standardDate = [dateFormatter dateFromString:date];
            dateFormatter.dateFormat = @"发布日期：yyyy年M月";
            date = [dateFormatter stringFromDate:standardDate];
        }
        self.publishDate = date;
        
        id title = element[@"@class::listtext@"][@"@h5@"][@"@a@"][@""];
        self.title = title;
        
        id content = element[@"@class::listtext@"][@""];
        self.content = content;
        
        id link = element[@"@class::listtext@"][@"@h5@"][@"@a@"][@"href"];
        self.linkURL = link;
    }
    return self;
}

- (void)setPublishDate:(NSString *)publishDate {
    if ([publishDate isKindOfClass:[NSString class]]) {
        _publishDate = [publishDate copy];
        if (_publishDate && _publishDate.length > 0) {
            [_attributes setObject:_publishDate forKey:@"publishDate"];
            return;
        }
    }
    _publishDate = nil;
    [_attributes removeObjectForKey:@"publishDate"];
}

- (void)setTitle:(NSString *)title {
    if ([title isKindOfClass:[NSString class]]) {
        _title = [title copy];
        if (_title && _title.length > 0) {
            [_attributes setObject:_title forKey:@"title"];
            return;
        }
    }
    _title = nil;
    [_attributes removeObjectForKey:@"title"];
}

- (void)setContent:(NSString *)content {
    if ([content isKindOfClass:[NSString class]]) {
        _content = [content copy];
        if (_content && _content.length > 0) {
            [_attributes setObject:_content forKey:@"content"];
            return;
        }
    }
    _content = nil;
    [_attributes removeObjectForKey:@"content"];
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
    return [NSString stringWithFormat:@"%@ - Attributes:%@", NSStringFromClass([XLTravelInfo class]), _attributes];
}

@end
