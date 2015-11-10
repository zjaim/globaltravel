//
//  XLMarketInfo.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLMarketInfo.h"

@interface XLMarketInfo () {
    NSMutableDictionary *_attributes;
}

@end

@implementation XLMarketInfo

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.title = [dict stringValueOfKey:@"title"];
        self.imagePath = [dict stringValueOfKey:@"img"];
    }
    return self;
}

- (instancetype)initWithSpiderString:(NSString *)string {
    if (self = [super init]) {
        _attributes = [NSMutableDictionary dictionary];
        NSString *title = @"";
        NSArray *titles = [string componentsSeparatedFromString:@"<a" toString:@"/a>"];
        if (titles && titles.count > 0) {
            NSString *titlesString = titles[0];
            NSArray *titleTexts = [titlesString componentsSeparatedFromString:@">" toString:@"<"];
            if (titleTexts && titleTexts.count > 0) {
                title = titleTexts.lastObject;
            }
        }
        _title = [[[title formatHtmlString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] copy];
        [_attributes setObject:_title forKey:@"title"];
        
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
    return [NSString stringWithFormat:@"%@ - Attributes:%@", NSStringFromClass([XLMarketInfo class]), _attributes];
}

@end
