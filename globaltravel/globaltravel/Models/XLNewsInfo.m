//
//  XLNewsInfo.m
//  globaltravel
//
//  Created by xinglei on 11/11/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLNewsInfo.h"

@interface XLNewsInfo () {
    NSMutableDictionary *_attributes;
}

@end

@implementation XLNewsInfo

- (instancetype)initWithElement:(TFHppleElement *)element {
    if (self = [super init]) {
        _attributes = [NSMutableDictionary dictionary];
        
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
        if (_title && _title.length > 0) {
            [_attributes setObject:_title forKey:@"title"];
            return;
        }
    }
    _title = nil;
    [_attributes removeObjectForKey:@"title"];
}

- (void)setSource:(NSString *)source {
    if ([source isKindOfClass:[NSString class]]) {
        _source = [source copy];
        if (_source && _source.length > 0) {
            [_attributes setObject:_source forKey:@"source"];
            return;
        }
    }
    _source = nil;
    [_attributes removeObjectForKey:@"source"];
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
    return [NSString stringWithFormat:@"%@ - Attributes:%@", NSStringFromClass([XLNewsInfo class]), _attributes];
}

@end
