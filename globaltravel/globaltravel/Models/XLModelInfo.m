//
//  XLModelInfo.m
//  globaltravel
//
//  Created by xinglei on 11/15/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLModelInfo.h"
#import <objc/runtime.h>

@interface XLModelInfo () {
    NSMutableArray *_ignores;
}

@end

@implementation XLModelInfo

- (void)setIgnores:(NSArray *)properties {
    _ignores = [properties copy];
}

- (NSString *)description {
    NSString *desc = [NSString stringWithFormat:@"<%@(%p) Properties:\n%@>", NSStringFromClass([self class]), self, [[self properties_aps] description]];
    return desc ?: @"<nil>";
}

- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        if (_ignores && _ignores.count > 0) {
            if ([_ignores matched:propertyName compare:^BOOL(id obj1, id obj2) {
                return [obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]] && [obj1 isEqualToString:obj2];
            }]) {
                continue;
            }
        }
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return props;
}

@end
