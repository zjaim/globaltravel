//
//  AMSlideView.m
//  AMCustomer
//
//  Created by wenzhu on 14/12/3.
//  Copyright (c) 2014年 capplay. All rights reserved.
//

#import "AMSlideView.h"

static const float SliderBannerChangeInterval = 5.0f;

static const double SliderAutoScrollDuration = 0.4;

@interface AMSlideView ()
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation AMSlideView {
    
}

@synthesize pageControl = pageControl;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        _views = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark View Life

- (void)setupViews {
    if (nil == _swipeView) {
        _swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _swipeView.backgroundColor = [UIColor clearColor];
        _swipeView.delegate = self;
        _swipeView.dataSource = self;
        _swipeView.wrapEnabled = YES;
        _swipeView.pagingEnabled = YES;
        [self addSubview:_swipeView];
    }
    
    if (nil == pageControl) {
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
        pageControl.bottom = self.height - 3;
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:8 / 255.0f green:105 / 255.0f blue:190 / 255.0f alpha:1.0f];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:pageControl];
    }
}

#pragma mark Properties

- (NSInteger)totalItemCount {
    return _swipeView.numberOfItems;
}

- (NSInteger)currentIndex {
    return _swipeView.currentItemIndex;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _swipeView.currentItemIndex = currentIndex;
}

- (UIView *)currentItemView {
    
    return _swipeView.currentItemView;
}


- (BOOL)wrapEnabled {
    return _swipeView.wrapEnabled;
}

- (void)setWrapEnabled:(BOOL)wrapEnabled {
    _swipeView.wrapEnabled = wrapEnabled;
}


- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    if (_autoScroll) {
        [self startAnimation];
    }
    else {
        [self stopAnimation];
    }
}


#pragma mark Animation

- (void)stopAnimation {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)startAnimation {
    if (!_timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:SliderBannerChangeInterval
                                                      target:self
                                                    selector:@selector(step)
                                                    userInfo:nil
                                                     repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }
}

- (void)step {
    if (!_swipeView.isScrolling) {
        [_swipeView scrollToItemAtIndex:_swipeView.currentItemIndex + 1 duration:SliderAutoScrollDuration];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window && self.autoScroll) {
        [self startAnimation];
    }
    else{
        [self stopAnimation];
    }
}


#pragma mark SliderView DataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInSliderView:)]) {
        return [self.dataSource numberOfItemsInSliderView:self];
    }
    return 0;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if ([self.dataSource respondsToSelector:@selector(sliderView:viewForItemAtIndex:reusingView:)]) {
        return [self.dataSource sliderView:self viewForItemAtIndex:index reusingView:view];
    }
    return nil;
}

- (void)reloadData {
    [_swipeView reloadData];
    [self reloadPageControl];
}

- (void)reloadPageControl {
    pageControl.width = self.width / 3.0f * 2;
    pageControl.centerX = self.width / 2;
    
    pageControl.numberOfPages = _swipeView.numberOfPages;
    pageControl.currentPage = 0;
    
    pageControl.bottom = self.height - 3;
    
    if (_swipeView.numberOfPages <= 1 && self.disableScrollOnlyOneImage) {
        _swipeView.scrollEnabled = NO;
    }
}


#pragma mark SwipeView Delegate

- (void)scrollToItemAtIndex:(NSInteger)index {
    [_swipeView scrollToItemAtIndex:index duration:SliderAutoScrollDuration];
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    pageControl.currentPage = swipeView.currentItemIndex;
    if ([self.delegate respondsToSelector:@selector(sliderView:didSliderToIndex:)]) {
        [self.delegate sliderView:self didSliderToIndex:swipeView.currentItemIndex];
    }
    
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(sliderView:didSelectViewAtIndex:)]) {
        [self.delegate sliderView:self didSelectViewAtIndex:index];
    }
    
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView {
    if ([self.delegate respondsToSelector:@selector(sliderViewDidScroll:)]) {
        [self.delegate sliderViewDidScroll:self];
    }
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView {
    if (self.autoScroll) {
        [self stopAnimation];
    }
    
    if ([self.delegate respondsToSelector:@selector(sliderViewWillBeginDragging:)]) {
        [self.delegate sliderViewWillBeginDragging:self];
    }
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate {
    if (self.autoScroll) {
        [self startAnimation];
    }
    if ([self.delegate respondsToSelector:@selector(sliderViewDidEndDragging:willDecelerate:)]) {
        [self.delegate sliderViewDidEndDragging:self willDecelerate:decelerate];
    }
}

- (void)swipeViewWillBeginDecelerating:(SwipeView *)swipeView {
    if ([self.delegate respondsToSelector:@selector(sliderViewWillBeginDecelerating:)]) {
        [self.delegate sliderViewWillBeginDecelerating:self];
    }
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView {
    if ([self.delegate respondsToSelector:@selector(sliderViewDidEndDecelerating:)]) {
        [self.delegate sliderViewDidEndDecelerating:self];
    }
}

- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView {
    if ([self.delegate respondsToSelector:@selector(sliderViewDidEndScrollingAnimation:)]) {
        [self.delegate sliderViewDidEndScrollingAnimation:self];
    }
}


@end