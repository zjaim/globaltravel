//
//  XLHomeHeaderView.m
//  globaltravel
//
//  Created by xinglei on 11/9/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLHomeHeaderView.h"
#import "AMSlideView.h"

#import "XLActivityView.h"
#import "XLActivityInfo.h"

@interface XLHomeHeaderView () <AMSlideViewDataSource, AMSlideViewDelegate> {
    AMSlideView *_activitiesView;
}

@end

@implementation XLHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addActivities];
    }
    return self;
}

- (void)addActivities {
    _activitiesView = [[AMSlideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(90))];
    _activitiesView.delegate = self;
    _activitiesView.dataSource = self;
    _activitiesView.autoScroll = YES;
    _activitiesView.currentIndex = 0;
    [self addSubview:_activitiesView];
    
    [_activitiesView reloadData];
}

- (void)setActivities:(NSArray *)activities {
    _activities = [activities copy];
    [_activitiesView reloadData];
}

#pragma mark - AMSlideViewDelegate, AMSlideViewDataSource
- (UIView *)sliderView:(AMSlideView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    view = (UIView *)[sliderView.views objectForKey:[NSString stringWithFormat: @"reuse_%ld", (long)index]];
    
    if (!view) {
        view = [[XLActivityView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        [sliderView.views setObject:view forKey:[NSString stringWithFormat: @"reuse_%ld", (long)index]];
    }
    
    XLActivityView *imageView = (XLActivityView *) view;
    imageView.activityInfo = _activities[index];
    
    return imageView;
}

- (NSInteger)numberOfItemsInSliderView:(AMSlideView *)sliderView {
    return _activities.count;
}

- (void)sliderView:(AMSlideView *)sliderView didSelectViewAtIndex:(NSInteger)index {
    
}


@end
