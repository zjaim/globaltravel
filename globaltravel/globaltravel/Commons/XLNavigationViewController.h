//
//  XLNavigationViewController.h
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBar)

- (void)addBackItem;

@end

@interface XLNavigationViewController : UINavigationController

+ (UIViewController *)currentVC;
+ (UINavigationController *)currentNavC;

@end
