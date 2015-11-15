//
//  XLNewsInfo.m
//  globaltravel
//
//  Created by xinglei on 11/11/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLNewsInfo.h"

@implementation XLNewsInfo

- (instancetype)initWithElement:(TFHppleElement *)element {
    if (self = [super init]) {
        id title = element[@"@class::c-title@"][@"@a@"][@""];
        self.title = title;
        
        id source = element[@"@class::c-summary c-row@"][@"@class::c-author@"][@""];
        self.source = source;
        
        id content = element[@"@class::c-summary c-row@"][@""];
        self.content = content;
        
        id link = element[@"@class::c-summary c-row@"][@"@class::c-info@"][@"@a@"][0][@"href"];
        if (!link || [link length] == 0) {
            link = element[@"@class::c-summary c-row@"][@"@class::c-info@"][@"@a@"][@"href"];
        }
        self.linkURL = link;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if ([title isKindOfClass:[NSString class]]) {
        _title = [title copy];
    } else {
        _title = nil;
    }
}

- (void)setSource:(NSString *)source {
    if ([source isKindOfClass:[NSString class]]) {
        _source = [source copy];
    } else {
        _source = nil;
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
