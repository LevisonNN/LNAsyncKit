//
//  DemoAsyncFeedViewController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoAsyncFeedViewController.h"
#import <IGListKit.h>
#import "DemoFeedNetwork.h"
#import "DemoAsyncFeedSectionController.h"

#import "DemoFeedModel.h"

#import <MJRefresh.h>

#import "LNAsyncCollectionViewPrender.h"

#import "CHTCollectionViewWaterfallLayout.h"


@interface DemoAsyncFeedViewController ()
<
IGListAdapterDataSource,
IGListAdapterDelegate,
LNAsyncCollectionViewPrenderDelegate,
CHTCollectionViewDelegateWaterfallLayout
>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) IGListAdapterUpdater *updater;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CHTCollectionViewWaterfallLayout *flowLayout;

@property (nonatomic, strong) DemoFeedNetwork *network;

//sectionControllers
@property (nonatomic, strong) DemoAsyncFeedSectionController *feedSectionController;

@property (nonatomic, strong) DemoFeedModel *feedModel;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isLoadingNextPage;

@property (nonatomic, strong) LNAsyncCollectionViewPrender *prender;

@end

@implementation DemoAsyncFeedViewController

#pragma -mark lifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self addConstraints];
    
    self.adapter.collectionView = self.collectionView;
    
    [self loadNextPage];
    
    [self.prender startObserveCollectionView];
}

- (void)dealloc
{
    [self.prender stopObserveCollectionView];
}

- (void)loadNextPage
{
    self.isLoadingNextPage = YES;
    __weak DemoAsyncFeedViewController *weakSelf = self;
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
        
        weakSelf.isLoadingNextPage = NO;
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

- (void)listAdapter:(IGListAdapter *)listAdapter willDisplayObject:(id)object atIndex:(NSInteger)index
{
    
}

- (void)listAdapter:(IGListAdapter *)listAdapter didEndDisplayingObject:(id)object atIndex:(NSInteger)index
{
    
}

#pragma -mark IGListAdapterDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.prender setNeedsUpdate];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.prender setNeedsUpdate];
}

#pragma -mark LNAsyncCollectionViewPrenderDelegate

- (void)asyncCollectionViewPrender:(LNAsyncCollectionViewPrender *)prender didUpdateRange:(LNAsyncRange *)range
{
    for (NSIndexPath *indexPath in range.preloadIndexPaths) {
        IGListSectionController *sectionController = [self.adapter sectionControllerForSection:indexPath.section];
        if (sectionController == self.feedSectionController && self.feedModel.result.count > indexPath.item) {
            DemoFeedItemModel *itemModel = [self.feedModel.result objectAtIndex:indexPath.item];
            itemModel.status = DemoFeedItemModelStatusPreload;
        }
    }
    
    for (NSIndexPath *indexPath in range.displayIndexPaths) {
        IGListSectionController *sectionController = [self.adapter sectionControllerForSection:indexPath.section];
        if (sectionController == self.feedSectionController && self.feedModel.result.count > indexPath.item) {
            DemoFeedItemModel *itemModel = [self.feedModel.result objectAtIndex:indexPath.item];
            itemModel.status = DemoFeedItemModelStatusDisplay;
        }
    }
    
    [self preloadNextPageIfNeeded];
    
}

- (void)preloadNextPageIfNeeded
{
    //距离底部1000pt，至少偏移500pt，这个条件一般根据需求来
    if (self.collectionView.contentOffset.y > MAX(500.f, (self.collectionView.contentSize.height - self.collectionView.frame.size.height - 1000.f))) {
        if (!self.isLoadingNextPage) {
            [self loadNextPage];
        }
    }
}


#pragma -mark CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IGListSectionController *sectionController = [self.adapter sectionControllerForSection:indexPath.section];
    if (sectionController == self.feedSectionController && self.feedModel.result.count > indexPath.item) {
        DemoFeedItemModel *itemModel = [self.feedModel.result objectAtIndex:indexPath.item];
        return CGSizeMake(itemModel.layoutObj.outputCellWidth, itemModel.layoutObj.outputCellHeight);
    }
    return CGSizeZero;
}

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
        _adapter.collectionViewDelegate = self;
    }
    return _adapter;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(12.f, 12.f, 12.f, 12.f);
        __weak DemoAsyncFeedViewController *weakSelf = self;
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!weakSelf.isLoadingNextPage) {
                [weakSelf loadNextPage];
            }
        }];
    }
    return _collectionView;
}

- (CHTCollectionViewWaterfallLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
        _flowLayout.delegate = self;
    }
    return _flowLayout;
}

- (DemoAsyncFeedSectionController *)feedSectionController
{
    if (!_feedSectionController) {
        _feedSectionController = [[DemoAsyncFeedSectionController alloc] init];
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

- (LNAsyncCollectionViewPrender *)prender
{
    if (!_prender) {
        _prender = [[LNAsyncCollectionViewPrender alloc] initWithCollectionView:self.collectionView];
        _prender.delegate = self;
    }
    return _prender;
}

@end
