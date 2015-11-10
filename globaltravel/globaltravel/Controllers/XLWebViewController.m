//
//  XLWebViewController.m
//  globaltravel
//
//  Created by xinglei on 11/10/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLWebViewController.h"
#import "AMNoticeView.h"

@interface XLWebViewController () <UIWebViewDelegate> {
    UIWebView *_webView;
    UIView *_coverView;
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
    _webView.scalesPageToFit = NO;
    _webView.delegate = self;
    
    [_webView setBackgroundColor:[UIColor clearColor]];
    [_webView setOpaque:NO];

    _webView.scrollView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.contentInset = UIEdgeInsetsMake(-67, -30, 5, -30);
    _webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:_urlString];
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    
    [self.view addSubview:_webView];
    
    _coverView = [[UIView alloc] initWithFrame:_webView.frame];
    _coverView.backgroundColor = [UIColor whiteColor];
    _coverView.hidden = NO;
    [self.view addSubview:_coverView];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    _coverView.hidden = NO;
    [self showLoader];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"config" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
    [webView stringByEvaluatingJavaScriptFromString:@"increaseMaxZoomFactor()"];
    [webView stringByEvaluatingJavaScriptFromString:@"hideElemets()"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _coverView.hidden = YES;
        [self hideLoader];
    });
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[[AMNoticeView alloc] initWithMessage:@"此功能尚未开启"] showWithDuration:3.0f];
        return NO;
    }
    return YES;
}

@end
