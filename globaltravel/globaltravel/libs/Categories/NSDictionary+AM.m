//
// Created by fallhunter on 5/9/14.
// Copyright (c) 2014 capplay. All rights reserved.
//

#import "NSDictionary+AM.h"


@implementation NSDictionary (AM)

- (NSInteger) integerValueOfKey:(NSString *)key {
    id value = self[key];
    
    if ( [value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    return 0;
}

- (int)intValueOfKey:(NSString *)key {
    id value = self[key];

    if ( [value respondsToSelector:@selector(intValue)] ){
        return [value intValue];
    }

    return 0;
}

- (float)floatValueOfKey:(NSString *)key {
    id value = self[key];

    if ( [value respondsToSelector:@selector(floatValue)] ){
        return [value floatValue];
    }

    return 0.0f;
}

- (double)doubleValueOfKey:(NSString *)key {
    id value = self[key];
    
    if ( [value respondsToSelector:@selector(doubleValue)] ){
        return [value doubleValue];
    }
    
    return 0.0;
}

- (long long)longlongValueOfKey:(NSString *)key {
    id value = self[key];
    
    if ( [value respondsToSelector:@selector(longLongValue)] ){
        return [value longLongValue];
    }
    
    return 0;
}

- (BOOL)boolValueOfKey:(NSString *)key {
    id value = self[key];
    
    if ( [value respondsToSelector:@selector(boolValue)] ){
        return [value boolValue];
    }
    
    return NO;
}

- (NSDate *)timeStampValueOfKey:(NSString *)key {
    id value = self[key];

    if ( [value respondsToSelector:@selector(doubleValue)] ){
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }

    return nil;
}

- (NSString *) timeStampForKey:(NSString *)key
{
    id value = self[key];
    
    if ( [value respondsToSelector:@selector(doubleValue)] ){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        NSString *currentDateStr = [formatter stringFromDate:date];
        
        return currentDateStr;
    }
    
    return nil;
}

- (NSString *) timeForKey:(NSString *)key
{
    id value = self[key];
    
    if ( [value respondsToSelector:@selector(doubleValue)] ){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *currentDateStr = [formatter stringFromDate:date];
        
        return currentDateStr;
    }
    
    return nil;
}

- (NSString *)stringValueOfKey:(NSString *)key {
    id value = self[key];

    if ( [value isKindOfClass:[NSString class]] )
        return value;

    return @"";

//    if ( [value respondsToSelector:@selector(description)] ){
//        return [value description];
//    }


}

- (NSArray *)arrayOfStringOfKey:(NSString *)key {
    id value = self[key];

    if ( [value isKindOfClass:[NSArray class]] ){
        NSArray * arr = (NSArray *) value;
        
        NSMutableArray * arrs = [NSMutableArray array];
        
        for (id obj in arr) {
            if ( [obj isKindOfClass:[NSString class]] ) {
                [arrs addObject:obj];
            } else {
                [arrs addObject:@""];
            }
        }
        
        return [arrs copy];
    }

    return @[];
}

- (NSArray *)arrayValueOfKey:(NSString *)key {
    id value = self[key];

    if ( [value isKindOfClass:[NSArray class]] ){
        return value;
    }

    return @[];
}

- (NSDictionary *)dictValueOfKey:(NSString *)key {
    id value = self[key];

    if ( [value isKindOfClass:[NSDictionary class]] ){
        return value;
    }

    return nil;
}


@end