//
//  XLActivityView.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLActivityView.h"
#import "XLActivityInfo.h"

@interface XLActivityView () {
    UIImageView *_imageView;
}

@end

@implementation XLActivityView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setActivityInfo:(XLActivityInfo *)activityInfo {
    _activityInfo = activityInfo;
    
    if (_activityInfo) {
        _imageView.image = [UIImage imageNamed:_activityInfo.imagePath];
    }
}

@end
