//
//  XLActivityInfo.h
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLActivityInfo : XLModelInfo

@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *linkURL;

- (instancetype)initWithElement:(TFHppleElement *)element;

@end
