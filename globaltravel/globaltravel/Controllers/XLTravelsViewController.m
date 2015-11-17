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
    
    NSArray *_travels;
}

@end

@implementation XLTravelsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideRefreshControl];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self hideRefreshControl];
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

- (void)addTravels {
    CGFloat navHeight = STATUSBAR_HEIGHT + NAVBAR_HEIGHT;
    
    [self addRefreshControl:@selector(loadTravels)];
    self.scrollBaseView.frame = CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight - TABBAR_HEIGHT);
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.scrollBaseView.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [UIView new];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollBaseView addSubview:_tableView];
    [self.view addSubview:self.scrollBaseView];
    
    [_tableView registerClass:[XLTravelCell class] forCellReuseIdentifier:kXLTravelCell];
}

- (void)loadTravels {
    static BOOL showRefreshControl = NO;
    if (!showRefreshControl) {
        [self showLoader];
        showRefreshControl = YES;
    }
    
    [[XLSessions sharedInstance] getTravelDataSuccess:^(NSArray *netTravels) {
        [self hideLoader];
        [self hideRefreshControl];
        _travels = [netTravels copy];
        [_tableView reloadData];
    } failed:^{
        [self hideLoader];
        [self hideRefreshControl];
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
