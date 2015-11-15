//
//  XLSpider.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLSpider.h"

@implementation TFHppleElement (Custom)

- (TFHppleElement *)objectAtIndexedSubscript:(NSUInteger)idx {
    if (self && self.children && self.children.count > idx) {
        return self.children[idx];
    }
    return nil;
}

- (TFHppleElement *)objectForKeyedSubscript:(NSString *)key {
    __block id result = nil;
    if (key && key.length > 0) {
        if ([key hasPrefix:@"@"] && [key hasSuffix:@"@"]) {
            key = [key substringWithRange:NSMakeRange(1, key.length - 2)];
            NSArray *kv = [key componentsSeparatedByString:@"::"];
            if (self && self.children && self.children.count > 0) {
                if (kv && kv.count == 2) {
                    NSMutableArray *elements = [NSMutableArray array];
                    [self.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if ([obj isKindOfClass:[TFHppleElement class]]) {
                            TFHppleElement *element = (TFHppleElement *)obj;
                            if ([element.attributes[kv[0]] isEqualToString:kv[1]]) {
                                [elements addObject:element];
                            }
                        }
                    }];
                    if (elements.count > 1) {
                        result = elements;
                    } else if (elements.count == 1) {
                        result = elements[0];
                    }
                } else if (kv && kv.count == 1) {
                    NSMutableArray *elements = [NSMutableArray array];
                    [self.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if ([obj isKindOfClass:[TFHppleElement class]]) {
                            TFHppleElement *element = (TFHppleElement *)obj;
                            if ([element.tagName isEqualToString:kv[0]]) {
                                [elements addObject:element];
                            }
                        }
                    }];
                    if (elements.count > 1) {
                        result = elements;
                    } else if (elements.count == 1) {
                        result = elements[0];
                    }
                }
            }
        } else {
            if (self) {
                result = self.attributes[key];
            }
        }
    } else if(key && key.length == 0) {
        result = [self content];
    }
    return result;
}

@end

@implementation XLSpider

DEFINE_SINGLETON_FOR_CLASS(XLSpider)

- (NSString *)spideStringWithURL:(NSString *)urlString encoding:(NSStringEncoding)encode {
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:encode error:&error];
    if (error) {
        return nil;
    }
    if (string && string.length > 0) {
        return string;
    }
    return nil;
}

- (NSData *)spideDataWithURL:(NSString *)urlString {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if (data && data.length > 0) {
        return data;
    }
    return nil;
}

@end
