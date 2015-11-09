//
//  XLTravelInfo.m
//  globaltravel
//
//  Created by xinglei on 11/9/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLTravelInfo.h"

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

@end
