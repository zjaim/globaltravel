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
    }
}

@end
