//
//  XLLoader.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLLoader.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *_scrollBaseView = &_scrollBaseView;
static const void *_refreshControl = &_refreshControl;

@implementation UIViewController (Loader)
@dynamic scrollBaseView;
@dynamic refreshControl;

- (UIView *)scrollBaseView {
    return objc_getAssociatedObject(self, _scrollBaseView);
}

- (void)setScrollBaseView:(UIView *)scrollBaseView {
    objc_setAssociatedObject(self, _scrollBaseView, scrollBaseView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIRefreshControl *)refreshControl {
    return objc_getAssociatedObject(self, _refreshControl);
}

- (void)setRefreshControl:(UIRefreshControl *)refreshControl {
    objc_setAssociatedObject(self, _refreshControl, refreshControl, OBJC_ASSOCIATION_ASSIGN);
}

- (void)showRefreshControl {
    if (!self.refreshControl.refreshing) {
        [self.refreshControl beginRefreshing];
    }
}

- (void)hideRefreshControl {
    if (self.refreshControl.refreshing) {
        [self.refreshControl endRefreshing];
    }
}

- (void)showLoader {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText = @"Loading...";
    hud.minSize = CGSizeMake(120.f, 120.f);
    [self.view addSubview:hud];
    [hud show:YES];
}

- (void)hideLoader {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)addRefreshControl:(SEL)selector {
    UITableViewController *vc = [UITableViewController new];
    [self addChildViewController:vc];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    vc.refreshControl = refreshControl;
    
    self.refreshControl =  vc.refreshControl;
    __weak UITableView *tableView = vc.tableView;
    tableView.tableHeaderView = [UIView new];
    tableView.tableFooterView = [UIView new];
    
    self.scrollBaseView = tableView;
}

@end

@implementation XLLoader

@end
