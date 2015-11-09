//
//  AMNoticeView.m
//  AMCustomer
//
//  Created by wenzhu on 14/12/10.
//  Copyright (c) 2014年 capplay. All rights reserved.
//

#import "AMNoticeView.h"
#import <QuartzCore/QuartzCore.h>

#define ALERT_WIDTH 260.f
#define MARGIN 7.5f

#define MESSAGEFONT FONT(15)

@interface AMNoticeView()
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UIView *overlayView; //遮罩
@property (nonatomic,strong) UILabel *messageLable;

@property (nonatomic,strong) NSString *message;
@end
@implementation AMNoticeView

- (id)initWithMessage:(NSString*)msg{
    self = [super init];
    if (self) {
        //赋值
        self.message = msg;
        self.backgroundColor = RGBACOLOR(0,0,0,0.7);
        
        self.layer.cornerRadius = 3.f;
        self.layer.borderWidth = 0;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        
        //初始化window
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.windowLevel = UIWindowLevelStatusBar + 1;
        self.window.opaque = NO;
        
        self.layer.cornerRadius=5.0f;
        //具体内容
        CGFloat vSpan = 20.0f;
        CGFloat totalHeight = 0.f;
        totalHeight += vSpan;
        
        //内容
        if (self.message) {
            self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, totalHeight, ALERT_WIDTH*2/3 - MARGIN * 2, 0)];
            self.messageLable.numberOfLines = 0;
            self.messageLable.text = self.message;
            self.messageLable.backgroundColor = [UIColor clearColor];
            self.messageLable.textAlignment = NSTextAlignmentCenter;
            self.messageLable.textColor = [UIColor whiteColor];
            self.messageLable.font  = FONT(15);
            
//            CGSize size = [self.message sizeWithFont:MESSAGEFONT constrainedToSize:CGSizeMake(self.messageLable.bounds.size.width, 500) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            
            CGSize size = [self.message boundingRectWithSize:CGSizeMake(self.messageLable.bounds.size.width, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MESSAGEFONT, NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
            
            self.messageLable.frame = (CGRect){self.messageLable.frame.origin, self.messageLable.bounds.size.width, size.height};
            [self addSubview:self.messageLable];
        }
        totalHeight += self.messageLable.bounds.size.height + vSpan;
        self.frame = CGRectIntegral(CGRectMake((self.window.bounds.size.width - ALERT_WIDTH*2/3) / 2, (self.window.bounds.size.height - totalHeight) / 2, ALERT_WIDTH*2/3, totalHeight));
        
        [self.window addSubview:self];
    }
    return self;
    
}

- (void)show
{
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.windowLevel = UIWindowLevelStatusBar + 1;
        self.window.opaque = NO;
        [self.window addSubview:self];
    }
    self.overlayView.alpha = 0.f;
    [self.window makeKeyAndVisible];
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.overlayView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        // stub
    }];
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.17 animations:^{
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.12 animations:^{
            self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}

- (void)showWithDuration:(NSTimeInterval)delay{
    [self show];
    [self performSelector:@selector(_dismissNoticeView) withObject:nil afterDelay:delay];
}

- (void)_dismissNoticeView {
    
    [UIView animateWithDuration:0.1 animations:^{
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.layer.transform = CATransform3DIdentity;
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.window = nil;
            [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
        }];
    }];
    
}


@end