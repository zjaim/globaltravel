//
//  XLSpider.h
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFHppleElement (Custom)

- (TFHppleElement *)objectAtIndexedSubscript:(NSUInteger)idx;
- (TFHppleElement *)objectForKeyedSubscript:(NSString *)key;

@end

@interface NSString (Spider)

- (NSString *)matchedAttribute:(NSString *)attrName;
- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString;

@end

@interface XLSpider : NSObject

+ (XLSpider *)shareSpider;

- (NSString *)spideStringWithURL:(NSString *)urlString;
- (NSData *)spideDataWithURL:(NSString *)urlString;

@end
