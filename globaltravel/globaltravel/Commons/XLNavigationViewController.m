//
//  XLNavigationViewController.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLNavigationViewController.h"

@interface UIViewController ()

@end

@implementation UIViewController (NavigationBar)

- (void)addBackItem {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(tappedBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)tappedBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@interface XLNavigationViewController ()

@end

@implementation XLNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    viewController.hidesBottomBarWhenPushed = NO;
}

+ (UIViewController *)currentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

+ (UINavigationController *)currentNavC {
    UINavigationController *result = nil;
    id currentVC = [self currentVC];
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        result = currentVC;
    } else if([currentVC isKindOfClass:[UITabBarController class]]) {
        id vc = [(UITabBarController *)currentVC viewControllers][[(UITabBarController *)currentVC selectedIndex]];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            result = vc;
        } else {
            result = [(UIViewController *)vc navigationController];
        }
    } else if([currentVC isKindOfClass:[UIViewController class]]) {
        result = [(UIViewController *)currentVC navigationController];
    }
    return result;
}

@end
