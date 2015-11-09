//
//  AMNoticeView.h
//  AMCustomer
//
//  Created by wenzhu on 14/12/10.
//  Copyright (c) 2014年 capplay. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  notice view，建议直接使用 MGJAlertUtil 中的方法来调用
 */
@interface AMNoticeView : UIView

/**
 *  初始化一个 notice view
 *
 *  @param message 消息
 *
 *  @return noticeview
 */
- (id)initWithMessage:(NSString *)message;

/**
 *  显示 noticeview，指定间隔后消失
 *
 *  @param delay   延迟消失的时间
 */
- (void)showWithDuration:(NSTimeInterval)delay;
@end

