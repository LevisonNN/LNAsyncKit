//
//  DemoDefaultFeedSectionController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoDefaultFeedSectionController.h"
#import "DemoDefaultFeedDisplayProtocol.h"

#import "DemoDefaultFeedCell.h"

#import <WebKit/WebKit.h>

@interface DemoDefaultFeedSectionController ()

@property (nonatomic, strong) NSObject<DemoDefaultFeedDisplayProtocol> *feedObj;

@end

@implementation DemoDefaultFeedSectionController

- (void)didUpdateToObject:(id)object
{
    if ([object isKindOfClass:NSObject.class]) {
        NSObject *obj = object;
        if ([obj conformsToProtocol:@protocol(DemoDefaultFeedDisplayProtocol)]) {
            self.feedObj = (NSObject<DemoDefaultFeedDisplayProtocol> *)obj;
        }
    }
}

- (NSInteger)numberOfItems
{
    return self.feedObj.demoDefaultFeedItemArray.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 36.f)/2.f, 180.f);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    DemoDefaultFeedCell *feedItemCell = [self.collectionContext dequeueReusableCellOfClass:DemoDefaultFeedCell.class forSectionController:self atIndex:index];
    
    id <DemoDefaultFeedItemDisplayProtocol> model;
    if (self.feedObj.demoDefaultFeedItemArray.count > index) {
        model = [self.feedObj.demoDefaultFeedItemArray objectAtIndex:index];
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
    NSString *targetUrl = self.feedObj.demoDefaultFeedItemArray[index].demoDefaultFeedItemJumpPath;
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

