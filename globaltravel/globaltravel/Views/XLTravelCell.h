//
//  XLTravelCell.h
//  globaltravel
//
//  Created by xinglei on 11/9/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTravelCellImageHeight (SCREEN_WIDTH > 320 ? 120 : 100)

@class XLTravelInfo;

@interface XLTravelCell : UITableViewCell

@property (nonatomic, strong) XLTravelInfo *travelInfo;

@end
