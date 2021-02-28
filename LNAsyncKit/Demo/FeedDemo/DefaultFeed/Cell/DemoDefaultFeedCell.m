//
//  DemoDefaultFeedCell.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoDefaultFeedCell.h"
#import <SDWebImage.h>

@interface DemoDefaultFeedCell ()

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *contextLabel;

@property (nonatomic, weak) NSObject <DemoDefaultFeedItemDisplayProtocol> *model;

@end

@implementation DemoDefaultFeedCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}

- (void)setModel:(NSObject<DemoDefaultFeedItemDisplayProtocol> *)model
{
    if (model != _model) {
        _model = model;
        [self updateUI];
    }
}

- (void)updateUI
{
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.model.demoDefaultFeedItemImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    self.dateLabel.text = self.model.demoDefaultFeedItemDate;
    self.contextLabel.text = self.model.demoDefaultFeedItemTitle;
}

- (void)addSubviews
{
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView.layer addSublayer:self.gradientLayer];
    [self.coverImageView addSubview:self.dateLabel];
    [self.contentView addSubview:self.contextLabel];
}

- (void)addConstraints
{
    CGFloat cellWidth = ([UIScreen mainScreen].bounds.size.width - 36.f)/2.f;
    CGFloat cellHeight = 180.f;
    
    self.coverImageView.frame = CGRectMake(0.f, 0.f, cellWidth, (cellHeight/4.f)*3.f);
    self.gradientLayer.frame = CGRectMake(0.f, self.coverImageView.frame.size.height - 30.f, self.coverImageView.frame.size.width, 30.f);
    
    self.dateLabel.frame =  CGRectMake(6.f, self.coverImageView.frame.size.height - 18.f, self.coverImageView.frame.size.width - 12.f, 11.f);
    
    self.contextLabel.frame = CGRectMake(6.f, self.coverImageView.frame.size.height + 4.f, cellWidth - 12.f, cellHeight/4.f - 8.f);
    
    self.contentView.layer.cornerRadius = 6.f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [UIColor colorWithRed:236.f/256.f green:238.f/256.f blue:248.f/256.f alpha:1.f];
    
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.layer.masksToBounds = YES;
    
    UIColor *randomColor = [UIColor colorWithRed:(random()%128)/256.f green:(random()%128)/256.f blue:(random()%128)/256.f alpha:1.f];
    self.gradientLayer.colors = @[(__bridge id)[randomColor colorWithAlphaComponent:0.f].CGColor,(__bridge id)[randomColor colorWithAlphaComponent:1.f].CGColor];
    self.gradientLayer.startPoint = CGPointMake(0.5f, 0.f);
    self.gradientLayer.endPoint = CGPointMake(0.5f, 1.f);
    self.gradientLayer.locations = @[@(0.f),@(1.f)];
    
    self.dateLabel.text = self.model.demoDefaultFeedItemDate;
    self.dateLabel.font = [UIFont systemFontOfSize:11.f];
    self.dateLabel.textColor = [UIColor whiteColor];
    
    self.contextLabel.text = self.model.demoDefaultFeedItemTitle;
    self.contextLabel.font = [UIFont systemFontOfSize:11.f];
    self.contextLabel.numberOfLines = 0;
    self.contextLabel.textColor = [UIColor blackColor];
    
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}

- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc] init];
    }
    return _gradientLayer;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
    }
    return _dateLabel;
}

- (UILabel *)contextLabel
{
    if (!_contextLabel) {
        _contextLabel = [[UILabel alloc] init];
    }
    return _contextLabel;
}

@end

