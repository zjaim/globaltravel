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


/**
 * <div class='icon' src='./eg.png'><div class='sub'>text</div><a href='./eg.html'></div>
 *
 * [@"@div@"]  -->  <div class='sub'></div><a href='./eg.html'>
 * [@"@class::sub@"]  -->  <div class='sub'></div><a href='./eg.html'>
 * [@"class"] --> icon
 * [@""] --> text
 */
- (TFHppleElement *)objectForKeyedSubscript:(NSString *)key {
    __block id result = nil;
    if (key && key.length > 0) {
        if ([key hasPrefix:@"@"] && [key hasSuffix:@"@"]) {
            key = [key substringWithRange:NSMakeRange(1, key.length - 2)];
            NSArray *kv = [key componentsSeparatedByString:@"::"];
            if (self && self.children && self.children.count > 0) {
                if (kv && kv.count == 2) {
                    [self.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if ([obj isKindOfClass:[TFHppleElement class]]) {
                            TFHppleElement *element = (TFHppleElement *)obj;
                            if ([element.attributes[kv[0]] isEqualToString:kv[1]]) {
                                result = element;
                                *stop = YES;
                            }
                        }
                    }];
                } else if (kv && kv.count == 1) {
                    [self.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if ([obj isKindOfClass:[TFHppleElement class]]) {
                            TFHppleElement *element = (TFHppleElement *)obj;
                            if ([element.tagName isEqualToString:kv[0]]) {
                                result = element;
                                *stop = YES;
                            }
                        }
                    }];
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

@implementation NSString (Spider)

- (NSString *)matchedAttribute:(NSString *)attrName {
    NSString *tempString = self;
    NSString *fromString = [NSString stringWithFormat:@"%@=\"", attrName];
    NSString *toString = @"\"";
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            return [tempString substringToIndex:range.location];
        }
    }
    return nil;
}

- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString
{
    if (!fromString || !toString || fromString.length == 0 || toString.length == 0) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        } else {
            break;
        }
    }
    return subStringsArray;
}

@end

@implementation XLSpider

+ (XLSpider *)shareSpider {
    static XLSpider* sharedSpider = nil;
    if (!sharedSpider) {
        static dispatch_once_t once = 0;
        dispatch_once(&once, ^{
            sharedSpider = [[XLSpider alloc] init];
        });
    }
    return sharedSpider;
}

- (NSString *)spideStringWithURL:(NSString *)urlString {
    NSError *error = nil;
    // CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)
    NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    }
    if (htmlString && htmlString.length > 0) {
        return [htmlString copy];
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
