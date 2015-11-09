//
//  XLServiceInfo.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLServiceInfo.h"

@implementation XLServiceInfo

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.qqNum = [dict stringValueOfKey:@"qq"];
        self.title = [dict stringValueOfKey:@"title"];
        self.imagePath = [dict stringValueOfKey:@"img"];
    }
    return self;
}

@end
