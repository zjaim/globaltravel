//
//  XLLoader.h
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (Loader)

@property (nonatomic, weak) UIView *scrollBaseView;
@property (nonatomic, weak) UIRefreshControl *refreshControl;

- (void)addRefreshControl:(SEL)selector;
- (void)showRefreshControl;
- (void)hideRefreshControl;

- (void)showLoader;
- (void)hideLoader;

@end

@interface XLLoader : NSObject

@end
