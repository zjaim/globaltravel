//
//  AMSlideView.h
//  AMCustomer
//
//  Created by wenzhu on 14/12/3.
//  Copyright (c) 2014年 capplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwipeView.h"

@protocol AMSlideViewDelegate;
@protocol AMSlideViewDataSource;


@interface AMSlideView : UIView <SwipeViewDelegate, SwipeViewDataSource>
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, readonly) SwipeView *swipeView;

@property(nonatomic, weak) id <AMSlideViewDelegate> delegate;
@property(nonatomic, weak) id <AMSlideViewDataSource> dataSource;

@property(nonatomic, copy) NSMutableDictionary *views;

/**
 * 所有页面的数量
 */
@property(nonatomic, readonly) NSInteger totalItemCount;

/**
 * 现在页面的索引
 */
@property(nonatomic, assign) NSInteger currentIndex;

/**
 * 现在页面的显示的view
 */
@property(nonatomic) UIView *currentItemView;

/**
 * 是否启用循环滚动
 */
@property(nonatomic, assign) BOOL wrapEnabled;

/**
 * 是否启用自动滚动
 */
@property(nonatomic, assign) BOOL autoScroll;


/**
 * 当只有一张图片的时候禁用滚动
 */
@property(nonatomic) BOOL disableScrollOnlyOneImage;

/**
 * 重载数据
 */
- (void)reloadData;

/**
 * 滚动到指定的项
 */
- (void)scrollToItemAtIndex:(NSInteger)index;

@end


/**
 *  SliderViewDelegate
 */
@protocol AMSlideViewDelegate <NSObject>
@optional
/**
 *  选中了 SliderView 中某个 cell
 *
 *  @param swipeView swipeView
 *  @param index      cell 的索引
 */
- (void)sliderView:(AMSlideView *)sliderView didSelectViewAtIndex:(NSInteger)index;

/**
 *  SliderView 滚动到某个 cell
 *
 *  @param swipeView swipeView
 *  @param index      cell 的索引
 */
- (void)sliderView:(AMSlideView *)sliderView didSliderToIndex:(NSInteger)index;

- (void)sliderViewDidScroll:(AMSlideView *)sliderView;

- (void)sliderViewWillBeginDragging:(AMSlideView *)sliderView;

- (void)sliderViewDidEndDragging:(AMSlideView *)sliderView willDecelerate:(BOOL)decelerate;

- (void)sliderViewWillBeginDecelerating:(AMSlideView *)sliderView;

- (void)sliderViewDidEndDecelerating:(AMSlideView *)sliderView;

- (void)sliderViewDidEndScrollingAnimation:(AMSlideView *)sliderView;

@end



/**
 *  SliderViewDataSource
 */
@protocol AMSlideViewDataSource <NSObject>

@required
/**
 *  swipeView 中的 cell 数量
 *
 *  @param swipeView swipeView
 *
 *  @return cell 数量
 */
- (NSInteger)numberOfItemsInSliderView:(AMSlideView *)sliderView;

/**
 *  某个索引的 view
 *
 *  @param swipeView swipeView
 *  @param index      index
 *
 *  @return 这个Slider要显示的view
 */
- (UIView *)sliderView:(AMSlideView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view;


@end
