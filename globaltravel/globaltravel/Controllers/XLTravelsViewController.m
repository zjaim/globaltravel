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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight - TABBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [UIView new];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[XLTravelCell class] forCellReuseIdentifier:kXLTravelCell];
}

- (void)loadTravels {
    [self showLoader];
    [[XLSessions shareSessions] getTravelDataSuccess:^(NSArray *netTravels) {
        [self hideLoader];
        _travels = [netTravels copy];
        [_tableView reloadData];
    } failed:^{
        [self hideLoader];
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
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak XLTravelInfo *travelInfo = _travels[indexPath.row];
    [[XLURLHandler shareHandler] handlerURL:[travelInfo.linkURL urlString] title:travelInfo.title];
}

@end
