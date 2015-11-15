//
//  XLMarketInfo.h
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLMarketInfo : XLModelInfo

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *linkURL;
@property (nonatomic, copy, readonly) NSArray *brothers;

@property (nonatomic, assign) BOOL contentShown;

- (instancetype)initWithElement:(TFHppleElement *)element;

@end
