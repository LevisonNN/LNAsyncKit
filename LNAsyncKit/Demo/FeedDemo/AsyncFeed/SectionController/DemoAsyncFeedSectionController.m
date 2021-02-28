//
//  DemoAsyncFeedSectionController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoAsyncFeedSectionController.h"
#import "DemoAsyncFeedDisplayProtocol.h"

#import "DemoAsyncFeedCell.h"

#import <WebKit/WebKit.h>

@interface DemoAsyncFeedSectionController ()

@property (nonatomic, strong) NSObject<DemoAsyncFeedDisplayProtocol> *feedObj;

@end

@implementation DemoAsyncFeedSectionController

- (void)didUpdateToObject:(id)object
{
    if ([object isKindOfClass:NSObject.class]) {
        NSObject *obj = object;
        if ([obj conformsToProtocol:@protocol(DemoAsyncFeedDisplayProtocol)]) {
            self.feedObj = (NSObject<DemoAsyncFeedDisplayProtocol> *)obj;
        }
    }
}

- (NSInteger)numberOfItems
{
    return self.feedObj.demoAsyncFeedItemArray.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    id <DemoAsyncFeedItemDisplayProtocol> model;
    if (self.feedObj.demoAsyncFeedItemArray.count > index) {
        model = [self.feedObj.demoAsyncFeedItemArray objectAtIndex:index];
    }
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 36.f)/2.f, model?model.demoAsyncFeedItemLayoutObj.outputCellHeight:180.f);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    DemoAsyncFeedCell *feedItemCell = [self.collectionContext dequeueReusableCellOfClass:DemoAsyncFeedCell.class forSectionController:self atIndex:index];
    
    id <DemoAsyncFeedItemDisplayProtocol> model;
    if (self.feedObj.demoAsyncFeedItemArray.count > index) {
        model = [self.feedObj.demoAsyncFeedItemArray objectAtIndex:index];
    }
    [feedItemCell setModel:model];
    
    return feedItemCell;
}

- (CGFloat)minimumLineSpacing
{
    return 12.f;
}

- (CGFloat)minimumInteritemSpacing
{
    return 12.f;
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    NSString *targetUrl = self.feedObj.demoAsyncFeedItemArray[index].demoAsyncFeedItemJumpPath;
    if (targetUrl.length > 0) {
        UIViewController *vc = [[UIViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
        WKWebView *webView = [[WKWebView alloc] init];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:targetUrl]]];
        [vc.view addSubview:webView];
        webView.frame = vc.view.bounds;
    }
}

@end
