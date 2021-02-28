//
//  DemoItemCollectionViewCell.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoItemCollectionViewCell.h"

NSString *const kDemoItemCollectionViewCell = @"kDemoItemCollectionViewCell";

@interface DemoItemCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DemoItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self addConstraints];
        self.contentView.backgroundColor = [UIColor colorWithRed:(rand()%255)/255.f green:(rand()%255)/255.f blue:(rand()%255)/255.f alpha:(rand()%255)/255.f];
        self.contentView.layer.cornerRadius = 4.f;
    }
    return self;
}

- (void)setObj:(DemoItemObject *)obj
{
    _obj = obj;
    self.titleLabel.text = obj.title;
}

- (void)addSubviews
{
    [self.contentView addSubview:self.titleLabel];
}

- (void)addConstraints
{
    self.titleLabel.frame = self.contentView.bounds;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end

