//
//  XLHomeViewController.m
//  globaltravel
//
//  Created by xinglei on 11/8/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLHomeViewController.h"

#import "XLHomeHeaderView.h"
#import "XLMarketCell.h"
#import "XLMarketInfo.h"

#define kColumnNumber 3
#define kMargenHorizontal 10
#define kGapHorizontal 10

NSString *const kXLHomeHeaderView = @"XLHomeHeaderView";
NSString *const kXLHomeHeaderViewCell = @"HomeHeaderViewCell";
NSString *const kMarketSectionHeaderView = @"MarketSectionHeaderView";
NSString *const kXLMarketCell = @"XLMarketCell";

@interface XLHomeViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    UICollectionView *_collectionView;
    
    NSArray *_activities;
    NSArray *_markets;
}

@end

@implementation XLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addMarkets];
    [self loadNetData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMarkets {
    CGFloat navHeight = STATUSBAR_HEIGHT + NAVBAR_HEIGHT;
    
    UICollectionViewFlowLayout *cvLayout = [[UICollectionViewFlowLayout alloc] init];
    cvLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight - TABBAR_HEIGHT) collectionViewLayout:cvLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[XLHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kXLHomeHeaderView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kXLHomeHeaderViewCell];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMarketSectionHeaderView];
    [_collectionView registerClass:[XLMarketCell class] forCellWithReuseIdentifier:kXLMarketCell];
}

- (void)loadNetData {
    [self showLoader];
    [[XLSessions shareSessions] getHomeDataSuccess:^(NSArray *netActivities, NSArray *netMarkets) {
        [self hideLoader];
        _activities = [netActivities copy];
        _markets = [netMarkets copy];
        [_collectionView reloadData];
    } failed:^{
        [self hideLoader];
    }];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1 + ((_markets.count > 0) ? _markets.count : 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0 && indexPath.item == 0) {
            XLHomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kXLHomeHeaderView forIndexPath:indexPath];
            headerView.activities = _activities;
            return headerView;
        }
        UICollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMarketSectionHeaderView forIndexPath:indexPath];
        sectionHeaderView.backgroundColor = [UIColor whiteColor];
        return sectionHeaderView;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    if (_markets && _markets.count > section - 1) {
        return ([_markets[section - 1] count] > 0) ? [_markets[section - 1] count] : 0;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, ScreenScale(90));
    }
    return CGSizeMake(SCREEN_WIDTH, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UICollectionViewCell *fistCell = [collectionView dequeueReusableCellWithReuseIdentifier:kXLHomeHeaderViewCell forIndexPath:indexPath];
        fistCell.backgroundColor = [UIColor whiteColor];
        return fistCell;
    }
    XLMarketCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXLMarketCell forIndexPath:indexPath];
    cell.marketInfo = _markets[indexPath.section - 1][indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeZero;
    }
    CGFloat width = (SCREEN_WIDTH - kMargenHorizontal * 2 - kGapHorizontal * (kColumnNumber - 1)) / kColumnNumber;
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kMargenHorizontal, 0, kMargenHorizontal);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kGapHorizontal;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 0) {
        __weak XLMarketInfo *marketInfo = _markets[indexPath.section - 1][indexPath.item];
        if (marketInfo.contentShown) {
            marketInfo.contentShown = NO;
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            [[XLURLHandler shareHandler] handlerURL:[marketInfo.linkURL urlString] title:marketInfo.title];
        } else {
            marketInfo.contentShown = YES;
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
        
    }
}

@end
