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

#define kColumnNumber 2
#define kMargenHorizontal 10
#define kGapHorizontal 10

NSString *const kXLHomeHeaderView = @"XLHomeHeaderView";
NSString *const kXLMarketCell = @"XLMarketCell";

@interface XLHomeViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    
    UICollectionView *_marketView;
    NSMutableArray *_markets;
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
    [self addHeaderView];
    
    [self loadMarkets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addHeaderView {
    [_marketView registerClass:[XLHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kXLHomeHeaderView];
}

- (void)addMarkets {
    CGFloat navHeight = STATUSBAR_HEIGHT + NAVBAR_HEIGHT;
    
    UICollectionViewFlowLayout *cvLayout = [[UICollectionViewFlowLayout alloc] init];
    cvLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _marketView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight - TABBAR_HEIGHT) collectionViewLayout:cvLayout];
    _marketView.backgroundColor = [UIColor whiteColor];
    _marketView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    _marketView.delegate = self;
    _marketView.dataSource = self;
    [self.view addSubview:_marketView];
    
    [_marketView registerClass:[XLMarketCell class] forCellWithReuseIdentifier:kXLMarketCell];
}

- (void)loadMarkets {
    if (!_markets) {
        _markets = [NSMutableArray array];
    }
    [_markets removeAllObjects];
    NSArray *localDatas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Markets" ofType:@"plist"]];
    for (id obj in localDatas) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [_markets addObject:[[XLMarketInfo alloc] initWithDictionary:obj]];
        }
    }
    [_marketView reloadData];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.item == 0 && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XLHomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kXLHomeHeaderView forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (_markets.count > 0) ? _markets.count : 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, ScreenScale(90) + 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XLMarketCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXLMarketCell forIndexPath:indexPath];
    cell.marketInfo = _markets[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
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
    
}

@end
