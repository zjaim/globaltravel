//
//  XLServiceViewController.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLServiceViewController.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "AMNoticeView.h"
#import "XLServiceCell.h"
#import "XLServiceInfo.h"

NSString *const kXLServiceCell = @"XLServiceCell";

@interface XLServiceViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_services;
    UITableView *_tableView;
}

@end

@implementation XLServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addServices];
    [self loadServices];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addServices {
    CGFloat navHeight = STATUSBAR_HEIGHT + NAVBAR_HEIGHT;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight - TABBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [UIView new];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[XLServiceCell class] forCellReuseIdentifier:kXLServiceCell];
}

- (void)loadServices {
    if (!_services) {
        _services = [NSMutableArray array];
    }
    [_services removeAllObjects];
    NSArray *localDatas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Services" ofType:@"plist"]];
    for (id obj in localDatas) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [_services addObject:[[XLServiceInfo alloc] initWithDictionary:obj]];
        }
    }
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_services.count > 0) ? _services.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:kXLServiceCell forIndexPath:indexPath];
    cell.serviceInfo = _services[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak XLServiceInfo *serviceInfo = _services[indexPath.row];
    if ([serviceInfo isKindOfClass:[XLServiceInfo class]]) {
        [self sendToQQWPA:serviceInfo.qqNum];
    }
}

#pragma mark - QQ WPA
- (void)sendToQQWPA:(NSString *)qqNum
{
    if (!qqNum || qqNum.length == 0) {
        return;
    }

    QQApiWPAObject *wpaObj = [QQApiWPAObject objectWithUin:qqNum];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:wpaObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    if (sent != EQQAPISENDSUCESS) {
        [[[AMNoticeView alloc] initWithMessage:@"联系客服失败"] showWithDuration:3.0f];
    }
    
}


@end
