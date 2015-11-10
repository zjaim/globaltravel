//
//  XLMarketCell.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLMarketCell.h"
#import "XLMarketInfo.h"

@interface XLMarketCell () {
    UIImageView *_imageView;
    
    UILabel *_titleLabel;
    UIView *_titleBgView;
    
    UILabel *_descLabel;
    UIView *_descBgView;
    
    BOOL _animating;
}

@end

@implementation XLMarketCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
        contentView.layer.borderColor = RGBACOLOR(222, 222, 222, 1).CGColor;
        contentView.layer.borderWidth = 0.5f;
        contentView.layer.masksToBounds = YES;
        contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [contentView addSubview:_imageView];
        
        _titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 20, self.height, 20)];
        _titleBgView.backgroundColor = [UIColor blackColor];
        _titleBgView.alpha = 0;
        [contentView addSubview:_titleBgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.height - 20, self.width - 20, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = FONT(12);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:_titleLabel];
        
        _descBgView = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0.5, self.width - 1, self.height - 20.5)];
        _descBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        _descBgView.hidden = YES;
        _descBgView.bottom = 0;
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _descBgView.width - 20, _descBgView.height - 20)];
        _descLabel.font = FONT(11);
        _descLabel.numberOfLines = 0;
        _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _descLabel.textColor = [UIColor whiteColor];
        [_descBgView addSubview:_descLabel];
        
        [contentView addSubview:_descBgView];
        
        _animating = NO;
    }
    return self;
}

- (void)setMarketInfo:(XLMarketInfo *)marketInfo {
    _marketInfo = marketInfo;
    
    if (_marketInfo) {
        [_imageView xl_setImageWithURL:_marketInfo.imagePath];
        _titleLabel.text = _marketInfo.title;
        if (_titleLabel.text && _titleLabel.text.length > 0) {
            _titleBgView.alpha = 0.35;
        } else {
            _titleBgView.alpha = 0;
        }
        _descLabel.text = _marketInfo.content;
        if (_descLabel.text && _descLabel.text.length > 0) {
            _descBgView.hidden = NO;
            [self startAnimate];
        } else {
            _descBgView.hidden = YES;
            [self stopAnimate];
        }
    }
}

- (void)startAnimate {
    _animating = YES;
    [self performSelector:@selector(runAnimate) withObject:nil afterDelay:10 + (arc4random() % 10)];
}

- (void)runAnimate {
    if (!_animating) {
        return;
    }
    [UIView animateWithDuration:1 animations:^{
        _descBgView.top = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:10 + (arc4random() % 10) options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone animations:^{
            _descBgView.bottom = 0;
        } completion:^(BOOL finished) {
            [self performSelector:_cmd withObject:nil afterDelay:10 + (arc4random() % 10)];
        }];
    }];
}

- (void)stopAnimate {
    _animating = NO;
}

@end
