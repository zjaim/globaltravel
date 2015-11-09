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
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        [contentView addSubview:_imageView];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.width - 30, self.width, 30)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.35;
        [contentView addSubview:bgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.width - 30, self.width - 20, 30)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = FONT(14);
        _titleLabel.minimumScaleFactor = .8f;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setMarketInfo:(XLMarketInfo *)marketInfo {
    _marketInfo = marketInfo;
    
    if (_marketInfo) {
        _imageView.image = [UIImage imageNamed:_marketInfo.imagePath];
        _titleLabel.text = _marketInfo.title;
    }
}

@end
