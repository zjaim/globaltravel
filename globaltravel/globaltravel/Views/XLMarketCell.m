//
//  XLMarketCell.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLMarketCell.h"
#import "XLMarketInfo.h"

@interface XLMarketSectionHeaderView() {
    UILabel *_titleLabel;
}

@end

@interface XLMarketCell () {
    UIImageView *_imageView;
    
    UILabel *_titleLabel;
    UIView *_titleBgView;
    
    UILabel *_descLabel;
    UIView *_descBgView;
}

@end

@implementation XLMarketSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, self.height)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.font = SCREEN_WIDTH > 320 ? FONT(14) : FONT(13);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setMarketInfo:(XLMarketInfo *)marketInfo {
    _marketInfo = marketInfo;
    if (_marketInfo) {
        _titleLabel.text = _marketInfo.title;
    }
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
        
        _titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 30, self.height, 30)];
        _titleBgView.backgroundColor = [UIColor blackColor];
        _titleBgView.alpha = 0;
        [contentView addSubview:_titleBgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.height - 30, self.width - 10, 30)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = SCREEN_WIDTH > 320 ? FONT(12) : FONT(11);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [contentView addSubview:_titleLabel];
        
        _descBgView = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0.5, self.width - 1, self.height - 30.5)];
        _descBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        _descBgView.hidden = YES;
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, _descBgView.width - 10, _descBgView.height - 10)];
        _descLabel.font = SCREEN_WIDTH > 320 ? FONT(11) : FONT(10);
        _descLabel.numberOfLines = 0;
        _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _descLabel.textColor = [UIColor whiteColor];
        [_descBgView addSubview:_descLabel];
        
        [contentView addSubview:_descBgView];
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
            if (_marketInfo.contentShown) {
                _descBgView.hidden = NO;
            } else {
                _descBgView.hidden = YES;
            }
        } else {
            _descBgView.hidden = YES;
        }
    }
}

@end
