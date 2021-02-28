//
//  LNAsyncRenderCache.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncRenderCache.h"
#import "LNAsyncMemoryInfo.h"

/*
 * For reference:
 * iphone 6:
 * 4 * screenHeight ~= 15MB
 * 8 * screenHeight ~= 30MB
 * 12 * screenHeight ~= 45MB
 * 16 * screenHeight ~= 60MB
 **/

@interface LNAsyncRenderCache () <NSCacheDelegate>

@property (nonatomic, strong) NSCache *cache;

@end

@implementation LNAsyncRenderCache


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addNotifications];
    }
    return self;
}

+ (instancetype)shareInstance
{
    static LNAsyncRenderCache* shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareInstance == nil) {
             shareInstance = [[LNAsyncRenderCache alloc] init];
        }
    });
    return shareInstance;
}


- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)clear
{
    [self.cache removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [self clear];
}

- (void)saveRenderImage:(UIImage *)image forKey:(NSString *)key
{
    if (image) {
        CGFloat imageCost = (image.size.height * [UIScreen mainScreen].scale) * (image.size.width * [UIScreen mainScreen].scale);
        [self.cache setObject:image forKey:key cost:imageCost];
    }
}

- (UIImage *)renderImageForKey:(NSString *)key
{
    if (key) {
        return [self.cache objectForKey:key];
    }
    return nil;
}

//Must make sure cache size BIGGER than displayRange!!
- (NSCache *)cache
{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        NSInteger pxCountOnline =  [UIScreen mainScreen].scale * [UIScreen mainScreen].bounds.size.width;
        NSInteger maxHeightScale = 12.f;
        switch ([LNAsyncMemoryInfo shareInstance].memorySpaceType) {
            case LNAsyncMemorySpaceTiny:
            {
                //512MB
                maxHeightScale = 6.f; //22.5MB (5%)
            } break;
            case LNAsyncMemorySpaceSmall:
            {
                //1GB
                maxHeightScale = 12.f; //45MB (5%)
            } break;
            case LNAsyncMemorySpaceMiddle:
            {
                //2 ~ 3 GB
                maxHeightScale = 24.f; //90MB (3.33% ~ 5%)
            } break;
            case LNAsyncMemorySpaceLarge:
            {
                //4GB +
                maxHeightScale = 36.f; // 135MB (2.5%)
            } break;
            default: {
                maxHeightScale = 12.f;
            } break;
        }
        CGFloat cacheHeight = [UIScreen mainScreen].scale * [UIScreen mainScreen].bounds.size.height * 12.f;
        _cache.totalCostLimit = pxCountOnline * cacheHeight;
        _cache.delegate = self;
    }
    return _cache;
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    
}

@end

