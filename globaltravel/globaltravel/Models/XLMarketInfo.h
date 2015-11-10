//
//  XLMarketInfo.h
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLMarketInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *linkURL;

- (instancetype)initWithSpiderString:(NSString *)string;

@end
