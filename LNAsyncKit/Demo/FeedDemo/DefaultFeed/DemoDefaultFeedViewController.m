//
//  DemoDefaultFeedViewController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoDefaultFeedViewController.h"
#import <IGListKit.h>
#import "DemoDefaultFeedSectionController.h"

#import "DemoFeedModel.h"

#import "DemoFeedNetwork.h"

#import <MJRefresh.h>

@interface DemoDefaultFeedViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) IGListAdapterUpdater *updater;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) DemoFeedNetwork *network;

//sectionControllers
@property (nonatomic, strong) DemoDefaultFeedSectionController *feedSectionController;

@property (nonatomic, strong) DemoFeedModel *feedModel;

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation DemoDefaultFeedViewController

#pragma -mark lifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self addConstraints];
    
    self.adapter.collectionView = self.collectionView;
    [self loadNextPage];
}

- (void)loadNextPage
{
    __weak DemoDefaultFeedViewController *weakSelf = self;
    [self.network loadFeedDataPage:self.currentPage completion:^(BOOL success, DemoFeedModel * _Nonnull model, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
        if (success) {
            weakSelf.currentPage ++;
            if (!weakSelf.feedModel) {
                weakSelf.feedModel = model;
            } else {
                NSMutableArray *combinedMArr = [[NSMutableArray alloc] init];
                [combinedMArr addObjectsFromArray:weakSelf.feedModel.result];
                [combinedMArr addObjectsFromArray:model.result];
                weakSelf.feedModel.result = combinedMArr.copy;
            }
            [weakSelf.adapter reloadDataWithCompletion:^(BOOL finished) {
                
            }];
        } else {
            NSLog(@"加载数据失败");
        }
    }];
}

- (void)addSubviews
{
    [self.view addSubview:self.collectionView];
}

- (void)addConstraints
{
    self.collectionView.frame = self.view.bounds;
}

#pragma -mark IGListAdapterDataSource

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter
{
    NSMutableArray *objMArr  = [[NSMutableArray alloc] init];
    if (self.feedModel) {
        [objMArr addObject:self.feedModel];
    }
    return objMArr.copy;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object
{
    return self.feedSectionController;
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter
{
    return [[UIView alloc] init];
}

#pragma -mark IGListAdapterDelegate




#pragma -mark lazyLoad
- (IGListAdapterUpdater *)updater
{
    if (!_updater) {
        _updater = [[IGListAdapterUpdater alloc] init];
    }
    return _updater;
}

- (IGListAdapter *)adapter
{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:self.updater viewController:self];
        _adapter.dataSource = self;
    }
    return _adapter;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(12.f, 12.f, 12.f, 12.f);
        __weak DemoDefaultFeedViewController *weakSelf = self;
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadNextPage];
        }];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (DemoDefaultFeedSectionController *)feedSectionController
{
    if (!_feedSectionController) {
        _feedSectionController = [[DemoDefaultFeedSectionController alloc] init];
    }
    return _feedSectionController;
}

- (DemoFeedNetwork *)network
{
    if (!_network) {
        _network = [[DemoFeedNetwork alloc] init];
    }
    return _network;
}

@end

