//
//  DemoFeedNetwork.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoFeedNetwork.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import "LNAsyncKit.h"
#import "DemoAsyncFeedDisplayLayoutObj.h"

@interface DemoFeedNetwork ()

@end

@implementation DemoFeedNetwork {
    dispatch_queue_t _transferQueue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _transferQueue = dispatch_queue_create(0, 0);
    }
    return self;
}

- (void)loadFeedDataPage:(NSInteger)page
              completion:(DemoFeedNetworkCompletionBlock)completion
{
    NSString * url = @"https://api.apiopen.top/getWangYiNews";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:@{@"page":@(page),@"count":@(20)} headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            [self transferFeedData:responseObject comletion:completion];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(NO, nil, error);
        }
    }];
}

- (void)transferFeedData:(NSDictionary *)dic comletion:(DemoFeedNetworkCompletionBlock)completion
{
    LNAsyncTransaction *transaction = [[LNAsyncTransaction alloc] init];
    
    [transaction addOperationWithBlock:^id _Nullable{
        DemoFeedModel *feedModel = [DemoFeedModel yy_modelWithDictionary:dic];
        for (DemoFeedItemModel *item in feedModel.result) {
            DemoAsyncFeedDisplayLayoutObjInput *layoutInput = [[DemoAsyncFeedDisplayLayoutObjInput alloc] init];
            layoutInput.contextString = item.title;
            layoutInput.hwScale = 0.3f + ((random()%100)/100.f)*0.5f; //1.f ~ 1.5f之间的随机高度
            DemoAsyncFeedDisplayLayoutObj *layoutObj = [[DemoAsyncFeedDisplayLayoutObj alloc] initWithInput:layoutInput];
            item.layoutObj = layoutObj;
        }
        return feedModel;
    } priority:1 queue:_transferQueue completion:^(id  _Nullable value, BOOL canceled) {
        if (completion) {
            completion(YES, value, nil);
        }
    }];
    
    [transaction commit];
}

@end

