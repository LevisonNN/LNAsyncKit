//
//  MainViewController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "MainViewController.h"
#import "DemoItemObject.h"
#import "DemoItemCollectionViewCell.h"

#import "DemoDefaultFeedViewController.h"
#import "DemoAsyncFeedViewController.h"

#import "DemoBilibiliCellViewController.h"

#import <AFNetworking.h>

@interface MainViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, copy) NSArray <DemoItemObject *> *modelArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self addConstraints];
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    
    DemoItemObject *defaultFeedObject = [[DemoItemObject alloc] init];
    defaultFeedObject.type = DemoItemFeedDefault;
    defaultFeedObject.title = @"默认Feed";
    
    DemoItemObject *asyncFeedObject = [[DemoItemObject alloc] init];
    asyncFeedObject.type = DemoItemFeedAsync;
    asyncFeedObject.title = @"异步Feed";
    
    DemoItemObject *biliCellObject = [[DemoItemObject alloc] init];
    biliCellObject.type = DemoItemBiliCell;
    biliCellObject.title = @"BiliCell";
    
    [mArr addObject:defaultFeedObject];
    [mArr addObject:asyncFeedObject];
    
    [mArr addObject:biliCellObject];
    
    self.modelArray = mArr.copy;
    
    [self.collectionView reloadData];

}



- (void)addSubviews
{
    [self.view addSubview:self.collectionView];
}

- (void)addConstraints
{
    self.collectionView.frame = self.view.bounds;
}

#pragma -mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    DemoItemObject *obj = self.modelArray[indexPath.row];
    switch (obj.type) {
        case DemoItemFeedAsync: {
            DemoAsyncFeedViewController *asyncFeedVC = [[DemoAsyncFeedViewController alloc] init];
            [self.navigationController pushViewController:asyncFeedVC animated:YES];
        } break;
        case DemoItemFeedDefault: {
            DemoDefaultFeedViewController *defaultFeedVC = [[DemoDefaultFeedViewController alloc] init];
            [self.navigationController pushViewController:defaultFeedVC animated:YES];
        } break;
        case DemoItemBiliCell: {
            DemoBilibiliCellViewController *biliCellVC = [[DemoBilibiliCellViewController alloc] init];
            [self.navigationController pushViewController:biliCellVC animated:YES];
        } break;
        default: {

        } break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(88.f, 44.f);
}

#pragma -mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoItemCollectionViewCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:kDemoItemCollectionViewCell forIndexPath:indexPath];
    [itemCell setObj:self.modelArray[indexPath.row]];
    return itemCell;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:DemoItemCollectionViewCell.class forCellWithReuseIdentifier:kDemoItemCollectionViewCell];
        _collectionView.contentInset = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
        
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

@end
