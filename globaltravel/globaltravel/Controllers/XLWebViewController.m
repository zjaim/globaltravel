//
//  XLWebViewController.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLWebViewController.h"

@interface XLWebViewController () <UIWebViewDelegate> {
    UIWebView *_webView;
}

@end

@implementation XLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addBackItem];
    self.navigationItem.title = _titleString;
    
    [self addWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addWebView {
    CGFloat navHeight = STATUSBAR_HEIGHT + NAVBAR_HEIGHT;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight)];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:_urlString];
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    
    [self.view addSubview:_webView];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showLoader];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideLoader];
}

@end
