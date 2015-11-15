//
//  XLMarketInfo.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLMarketInfo.h"

@interface XLMarketInfo () {
    NSMutableArray *_brothersMutable;
}

@end

@implementation XLMarketInfo

- (instancetype)init {
    if (self = [super init]) {
        [self setIgnores:@[@"contentShown", @"brothers"]];
    }
    return self;
}

- (instancetype)initWithElement:(TFHppleElement *)element {
    if (self = [self init]) {
        _brothersMutable = [NSMutableArray array];
        id imgArea = element[@"@class::imgarea@"];
        if ([imgArea isKindOfClass:[NSArray class]]) {
            if ([imgArea count] > 0) {
                [self configMarket:imgArea[0]];
                if ([imgArea count] > 1) {
                    [imgArea enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if (idx > 0) {
                            __strong XLMarketInfo *brotherMarketInfo = [XLMarketInfo new];
                            [brotherMarketInfo configMarket:obj];
                            [_brothersMutable addObject:brotherMarketInfo];
                        }
                    }];
                }
            }
        } else {
            [self configMarket:imgArea];
        }
    }
    return self;
}

- (void)configMarket:(TFHppleElement *)element {
    _contentShown = NO;
    
    id img = element[@"@a@"][0][@"@img@"][@"src"];
    if (!img || [img length] == 0) {
        img = element[@"@a@"][@"@img@"][@"src"];
    }
    if (!img || [img length] == 0) {
        img = element[@"@img@"][@"src"];
    }
    self.imagePath = img;
    
    id title = element[@"@div@"][@"@a@"][@""];
    if (!title || [title length] == 0) {
        title = element[@"@span@"][@"@a@"][@""];
    }
    if (!title || [title length] == 0) {
        title = element.parent[@"@class::imgarea_text@"][@"@h5@"][@"@a@"][@""];
    }
    self.title = title;
    
    id content = element.parent[@"@class::imgarea_text@"][@"@p@"][@""];
    self.content = content;
    
    id link = element[@"@a@"][@"href"];
    if (!link || [link length] == 0) {
        link = element[@"@span@"][@"@a@"][@"href"];
    }
    if (!link || [link length] == 0) {
        link = element.parent[@"@class::imgarea_text@"][@"@h5@"][@"@a@"][@"href"];
    }
    self.linkURL = link;
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

- (NSArray *)brothers {
    return [_brothersMutable copy];
}

@end
