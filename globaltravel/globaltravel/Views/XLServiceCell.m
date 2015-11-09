//
//  XLServiceCell.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLServiceCell.h"
#import "XLServiceInfo.h"

@interface XLServiceCell () {
    UIImageView *_avatarImageView;
    UILabel *_titleLabel;
}

@end

@implementation XLServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 44, 44)];
        [self.contentView addSubview:_avatarImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 0, SCREEN_WIDTH - 74, 54)];
        _titleLabel.font = FONT(15);
        [self.contentView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 53.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = RGBACOLOR(222, 222, 222, 1);
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setServiceInfo:(XLServiceInfo *)serviceInfo {
    _serviceInfo = serviceInfo;
    
    if (_serviceInfo) {
        _avatarImageView.image = [UIImage imageNamed:_serviceInfo.imagePath];
        _titleLabel.text = _serviceInfo.title;
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
