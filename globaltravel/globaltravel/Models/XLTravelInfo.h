//
//  XLTravelInfo.h
//  globaltravel
//
//  Created by xinglei on 11/9/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLTravelInfo : XLModelInfo

@property (nonatomic, copy) NSString *publishDate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *linkURL;

- (instancetype)initWithElement:(TFHppleElement *)element;

@end
