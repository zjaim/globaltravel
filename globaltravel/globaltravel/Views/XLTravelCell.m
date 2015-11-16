//
//  XLTravelCell.m
//  globaltravel
//
//  Created by xinglei on 11/9/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLTravelCell.h"
#import "XLTravelInfo.h"

@interface XLTravelCell () {
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_dateLabel;
    UILabel *_contentLabel;
}

@end

@implementation XLTravelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat height = kTravelCellImageHeight - 20;
        CGFloat width = 134 * height / 100 + 20;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, width - 20, height)];
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width, SCREEN_WIDTH > 320 ? 15 : 10, SCREEN_WIDTH - width - 10, SCREEN_WIDTH > 320 ? 35 : 30)];
        _titleLabel.font = SCREEN_WIDTH > 320 ? BOLD_FONT(14) : BOLD_FONT(12);
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(width, _titleLabel.bottom, SCREEN_WIDTH - width - 10, SCREEN_WIDTH > 320 ? 50 : 40)];
        _contentLabel.font = SCREEN_WIDTH > 320 ? FONT(13) : FONT(11);
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(width, _contentLabel.bottom, SCREEN_WIDTH - width - 10, kTravelCellImageHeight - 1 - _contentLabel.bottom)];
        _dateLabel.font = FONT(10);
        _dateLabel.backgroundColor = [UIColor whiteColor];
        _dateLabel.textColor = RGBACOLOR(8, 105, 190, 1);
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.alpha = 0.7;
        [self addSubview:_dateLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kTravelCellImageHeight - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = RGBACOLOR(222, 222, 222, 1);
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setTravelInfo:(XLTravelInfo *)travelInfo {
    _travelInfo = travelInfo;
    
    if (_travelInfo) {
        [_imageView xl_setImageWithURL:_travelInfo.imagePath];
        _titleLabel.text = _travelInfo.title;
        _dateLabel.text = [NSString stringWithFormat:@"%@", _travelInfo.publishDate];
        _contentLabel.text = _travelInfo.content;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
