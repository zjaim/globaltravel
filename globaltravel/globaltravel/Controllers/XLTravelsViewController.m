//
//  XLTravelsViewController.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLTravelsViewController.h"
#import "XLTravelCell.h"
#import "XLTravelInfo.h"

NSString *const kXLTravelCell = @"XLTravelCell";
@interface XLTravelsViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    UIRefreshControl *_refreshControl;
    
    NSArray *_travels;
}

@end

@implementation XLTravelsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideRefresh];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self hideRefresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTravels];
    [self loadTravels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showRefresh {
    if (!_refreshControl.refreshing) {
        [_refreshControl beginRefreshing];
    }
}

- (void)hideRefresh {
    if (_refreshControl.refreshing) {
        [_refreshControl endRefreshing];
    }
}

- (void)addTravels {
    CGFloat navHeight = STATUSBAR_HEIGHT + NAVBAR_HEIGHT;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight - TABBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [UIView new];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:@selector(loadTravels) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    
    [_tableView registerClass:[XLTravelCell class] forCellReuseIdentifier:kXLTravelCell];
}

- (void)loadTravels {
    static BOOL showRefreshControl = NO;
    if (showRefreshControl) {
        [self showLoader];
        showRefreshControl = YES;
    }
    
    [[XLSessions sharedInstance] getTravelDataSuccess:^(NSArray *netTravels) {
        [self hideLoader];
        [self hideRefresh];
        _travels = [netTravels copy];
        [_tableView reloadData];
    } failed:^{
        [self hideLoader];
        [self hideRefresh];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_travels.count > 0) ? _travels.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLTravelCell *cell = [tableView dequeueReusableCellWithIdentifier:kXLTravelCell forIndexPath:indexPath];
    cell.travelInfo = _travels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTravelCellImageHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak XLTravelInfo *travelInfo = _travels[indexPath.row];
    [[XLURLHandler sharedInstance] handlerURL:[travelInfo.linkURL urlString] title:travelInfo.title];
}

@end
