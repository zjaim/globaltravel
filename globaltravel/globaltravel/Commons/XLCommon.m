//
//  XLCommon.m
//  globaltravel
//
//  Created by xinglei on 11/15/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLCommon.h"
#import "JRSwizzle.h"

void dispatch_sync_in_main_queue(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void dispatch_async_in_main_queue(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

@implementation NSArray (Common)

+ (void)load {
    [super load];
    [NSArray jr_swizzleMethod:@selector(description) withMethod:@selector(customDescription) error:nil];
}

- (NSString *)customDescription {
    NSMutableString *string = [NSMutableString string];
    if (self) {
        [string appendString:@"(\n"];
        NSMutableArray *itemDescs = [NSMutableArray array];
        for (id obj in self) {
            NSString *itemDesc = [obj description];
            itemDesc = [itemDesc stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
            [itemDescs addObject:[NSString stringWithFormat:@"\t%@", itemDesc]];
        }
        if (itemDescs.count > 0) {
            [string appendString:[itemDescs componentsJoinedByString:@",\n"]];
            [string appendString:@"\n"];
        }
        [string appendString:@")"];
    }
    if (string && string.length > 0) {
        return [string copy];
    }
    return @"<nil>";
}

- (BOOL)matched:(id)obj compare:(BOOL (^)(id, id))compare {
    if (self) {
        __block BOOL matched = NO;
        [self enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
            if (compare(item, obj)) {
                matched = YES;
                *stop = YES;
            }
        }];
        return matched;
    }
    return NO;
}

@end

@implementation NSDictionary (Common)

+ (void)load {
    [super load];
    [NSDictionary jr_swizzleMethod:@selector(description) withMethod:@selector(customDescription) error:nil];
}

- (NSString *)customDescription {
    NSMutableString *string = [NSMutableString string];
    if (self) {
        [string appendString:@"{\n"];
        
        NSMutableArray *itemDescs = [NSMutableArray array];
        for (id obj in self.allKeys) {
            NSString *keyDesc = [obj description];
            NSString *valueDesc = [self[obj] description];
            valueDesc = [valueDesc stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
            [itemDescs addObject:[NSString stringWithFormat:@"\t%@ = %@", keyDesc, valueDesc]];
        }
        if (itemDescs.count > 0) {
            [string appendString:[itemDescs componentsJoinedByString:@",\n"]];
            [string appendString:@"\n"];
        }
        
        [string appendString:@"}"];
    }
    if (string && string.length > 0) {
        return [string copy];
    }
    return @"<nil>";
}

- (BOOL)matched:(id)key {
    NSArray *keys = self.allKeys;
    if (keys && keys.count > 0) {
        return [keys matched:key compare:^BOOL(id obj1, id obj2) {
            return [obj1 isEqualToString:obj2];
        }];
    }
    return NO;
}

@end
