//
//  XLActivityInfo.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLActivityInfo.h"

@implementation XLActivityInfo

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.imagePath = [dict stringValueOfKey:@"img"];
    }
    return self;
}

@end
