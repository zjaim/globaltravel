//
//  XLTravelInfo.m
//  globaltravel
//
//  Created by xinglei on 11/9/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLTravelInfo.h"

@implementation XLTravelInfo

- (instancetype)initWithElement:(TFHppleElement *)element {
    if (self = [super init]) {
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
    } else {
        _publishDate = nil;
    }
}

- (void)setImagePath:(NSString *)imagePath {
    if ([imagePath isKindOfClass:[NSString class]]) {
        _imagePath = [imagePath copy];
    } else {
        _imagePath = nil;
    }
}

- (void)setTitle:(NSString *)title {
    if ([title isKindOfClass:[NSString class]]) {
        _title = [title copy];
    } else {
        _title = nil;
    }
}

- (void)setContent:(NSString *)content {
    if ([content isKindOfClass:[NSString class]]) {
        _content = [content copy];
    } else {
        _content = nil;
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
