//
//  XLSpider.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLSpider.h"

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

- (NSString *)spideURL:(NSString *)URLString {
    NSError *error = nil;
    NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:HTML_HOME] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    }
    if (htmlString && htmlString.length > 0) {
        return [htmlString copy];
    }
    return nil;
}

@end
