//
//  XLLoader.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLLoader.h"
#import "MBProgressHUD.h"

@implementation UIViewController (Loader)

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

@end

@implementation XLLoader

@end
