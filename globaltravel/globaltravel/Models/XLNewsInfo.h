//
//  XLNewsInfo.h
//  globaltravel
//
//  Created by xinglei on 11/11/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLNewsInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *linkURL;

- (instancetype)initWithElement:(TFHppleElement *)element;

@end
