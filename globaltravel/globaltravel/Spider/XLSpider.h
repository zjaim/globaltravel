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

/**
 * e.g. <div class='icon' src='./eg.png'><div class='sub'>text</div><a href='./eg.html'></div>
 *
 * [@"@div@"]  -->  <div class='sub'></div><a href='./eg.html'>
 * [@"@class::sub@"]  -->  <div class='sub'></div><a href='./eg.html'>
 * [@"class"] --> icon
 * [@""] --> text
 */
- (TFHppleElement *)objectForKeyedSubscript:(NSString *)key;

@end

@interface XLSpider : NSObject

DEFINE_SINGLETON_FOR_HEADER(XLSpider)

- (NSString *)spideStringWithURL:(NSString *)urlString encoding:(NSStringEncoding)encode;
- (NSData *)spideDataWithURL:(NSString *)urlString;

@end
