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
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 134, 100)];
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(154, 15, SCREEN_WIDTH - 154 - 10, 35)];
        _titleLabel.font = BOLD_FONT(14);
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(154, 100, SCREEN_WIDTH - 154 - 10, 15)];
        _dateLabel.font = FONT(10);
        _dateLabel.backgroundColor = [UIColor whiteColor];
        _dateLabel.textColor = RGBACOLOR(8, 105, 190, 1);
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.alpha = 0.7;
        [self addSubview:_dateLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(154, 50, SCREEN_WIDTH - 154 - 10, 50)];
        _contentLabel.font = FONT(13);
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 119.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = RGBACOLOR(222, 222, 222, 1);
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setTravelInfo:(XLTravelInfo *)travelInfo {
    _travelInfo = travelInfo;
    
    if (_travelInfo) {
        _imageView.image = [UIImage imageNamed:_travelInfo.imagePath];
        _titleLabel.text = _travelInfo.title;
        _dateLabel.text = [NSString stringWithFormat:@"发布日期：%@", _travelInfo.publishDate];
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
