//
//  XLMarketCell.h
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLMarketInfo;

@interface XLMarketSectionHeaderView : UICollectionReusableView

@property (nonatomic, strong) XLMarketInfo *marketInfo;

@end

@interface XLMarketCell : UICollectionViewCell

@property (nonatomic, strong) XLMarketInfo *marketInfo;

@end
