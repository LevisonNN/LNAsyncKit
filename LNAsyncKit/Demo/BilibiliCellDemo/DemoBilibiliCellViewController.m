//
//  DemoBilibiliCellViewController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoBilibiliCellViewController.h"
#import "LNAsyncKit.h"

@interface DemoBilibiliCellViewController ()


//CoreGraphics
@property (nonatomic, strong) UIImageView *targetImageView;
@property (nonatomic, strong) UIButton *feedbackButton2;

//UIkit
@property (nonatomic, strong) UIView *cellContentView;

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) UIImageView *audienceIconImageView;
@property (nonatomic, strong) UILabel *audienceNumberLabel;
@property (nonatomic, strong) UILabel *authorNameLabel;

@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UILabel *liveTagLabel;
@property (nonatomic, strong) UILabel *liveContextLabel;

@property (nonatomic, strong) UIButton *feedbackButton;

@end

@implementation DemoBilibiliCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubviews];
    [self addConstraints];
    
    
    [self buildWithUIKit];
    
    [self buildWithLNAsyncKit];
}

- (void)addSubviews
{
    [self.view addSubview:self.cellContentView];
    [self.view addSubview:self.targetImageView];
}

- (void)addConstraints
{
    self.cellContentView.frame = CGRectMake((self.view.frame.size.width - 200.f)/2.f, 100.f, 200.f, 200.f);
    self.targetImageView.frame = CGRectMake((self.view.frame.size.width - 200.f)/2.f, 400.f, 200.f, 200.f);
}

- (void)buildWithUIKit
{
    //UIKit
    [self.cellContentView addSubview:self.coverImageView];
    [self.coverImageView.layer addSublayer:self.gradientLayer];
    [self.coverImageView addSubview:self.audienceIconImageView];
    [self.coverImageView addSubview:self.audienceNumberLabel];
    [self.coverImageView addSubview:self.authorNameLabel];
    [self.cellContentView addSubview:self.introduceLabel];
    [self.cellContentView addSubview:self.liveTagLabel];
    [self.cellContentView addSubview:self.liveContextLabel];
    [self.cellContentView addSubview:self.feedbackButton];
    
    self.coverImageView.frame = CGRectMake(0.f, 0.f, 200.f, 140.f);
    self.gradientLayer.frame = CGRectMake(0.f, 110.f, 200.f, 30.f);
    self.audienceIconImageView.frame = CGRectMake(10.f, 118.f, 14.f, 14.f);
    self.audienceNumberLabel.frame = CGRectMake(34.f, 118.f, 44.f, 14.f);
    self.authorNameLabel.frame = CGRectMake(80.f, 118.f, 110.f, 14.f);
    
    self.introduceLabel.frame = CGRectMake(10.f, 144.f , 180.f, 30.f);
    self.liveTagLabel.frame = CGRectMake(10.f, 176.f , 32.f, 16.f);
    self.liveContextLabel.frame = CGRectMake(46.f, 177.f, 100.f, 14.f);
    
    self.feedbackButton.frame = CGRectMake(174.f, 176.f, 16.f, 16.f);
    
    
    self.cellContentView.layer.cornerRadius = 5.f;
    self.cellContentView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.95f alpha:1.f];
    self.cellContentView.layer.masksToBounds = YES;
    
    self.coverImageView.image = [UIImage imageNamed:@"myself"];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.layer.masksToBounds = YES;
    
    self.gradientLayer.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.f].CGColor, (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:1.f].CGColor];
    self.gradientLayer.locations = @[@(0.f),@(1.f)];
    self.gradientLayer.startPoint = CGPointMake(0.5f, 0.f);
    self.gradientLayer.endPoint = CGPointMake(0.5f, 1.f);
    
    self.audienceIconImageView.image = [UIImage imageNamed:@"ic_bili_audience"];
    self.audienceIconImageView.layer.cornerRadius = 7.f;
    self.audienceIconImageView.layer.masksToBounds = YES;
    
    self.audienceNumberLabel.text = @"10.4万";
    self.audienceNumberLabel.textColor = [UIColor whiteColor];
    self.audienceNumberLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.authorNameLabel.text = @"Levison的直播间";
    self.authorNameLabel.font = [UIFont systemFontOfSize:12.f];
    self.authorNameLabel.textColor = [UIColor whiteColor];
    
    self.liveTagLabel.layer.cornerRadius = 3.f;
    self.liveTagLabel.layer.borderColor = [UIColor colorWithRed:239.f/255.f green:91.f/255.f blue:156.f/255.f alpha:1.f].CGColor;
    self.liveTagLabel.layer.borderWidth = 1.f;
    self.liveTagLabel.text = @"直播";
    self.liveTagLabel.font = [UIFont systemFontOfSize:12.f];
    self.liveTagLabel.textColor = [UIColor colorWithRed:239.f/255.f green:91.f/255.f blue:156.f/255.f alpha:1.f];
    self.liveTagLabel.textAlignment = NSTextAlignmentCenter;
    
    self.liveContextLabel.text = @"视频聊天";
    self.liveContextLabel.font = [UIFont systemFontOfSize:12.f];
    self.liveContextLabel.textColor = [UIColor colorWithRed:155.f/255.f green:155.f/255.f blue:155.f/255.f alpha:1.f];
    
    self.introduceLabel.textColor = [UIColor blackColor];
    self.introduceLabel.font = [UIFont systemFontOfSize:12.f];
    self.introduceLabel.text = @"和封面一样 吴彦祖COS";
    self.introduceLabel.numberOfLines = 2;
    
    [self.feedbackButton setImage:[UIImage imageNamed:@"ic_bili_more"] forState:UIControlStateNormal];
    [self.feedbackButton setImage:[UIImage imageNamed:@"ic_bili_more"] forState:UIControlStateHighlighted];
    self.feedbackButton.layer.cornerRadius = 8.f;
    self.feedbackButton.layer.masksToBounds = YES;
    
}

- (void)buildWithLNAsyncKit
{
    dispatch_queue_t renderQueue = dispatch_queue_create(0, 0);
    LNAsyncTransaction *transaction = [[LNAsyncTransaction alloc] initWithCompletionBlock:^(LNAsyncTransaction * _Nonnull completedTransaction, BOOL canceled) {
        
    }];
    __weak DemoBilibiliCellViewController *weakSelf = self;
    [transaction addOperationWithBlock:^id _Nullable{
        return [weakSelf getCellImage];
    } priority:0 queue:renderQueue completion:^(id  _Nullable value, BOOL canceled) {
        weakSelf.targetImageView.image = value;
    }];
    
    
    [transaction commit];
    
    //这个有响应事件
    [self.feedbackButton2 setImage:[UIImage imageNamed:@"ic_bili_more"] forState:UIControlStateNormal];
    [self.feedbackButton2 setImage:[UIImage imageNamed:@"ic_bili_more"] forState:UIControlStateHighlighted];
    self.feedbackButton2.layer.cornerRadius = 8.f;
    self.feedbackButton2.layer.masksToBounds = YES;
    
    [self.targetImageView addSubview:self.feedbackButton2];
    
    self.feedbackButton2.frame = CGRectMake(174.f, 176.f, 16.f, 16.f);
}

- (UIImage *)getCellImage
{
    LNAsyncElement *cellContentElement = [[LNAsyncElement alloc] init];
    cellContentElement.frame = CGRectMake(0.f, 0.f, 200.f, 200.f);
    cellContentElement.cornerRadius = 5.f;
    cellContentElement.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.95f alpha:1.f];
    
    LNAsyncImageElement *coverImageElement = [[LNAsyncImageElement alloc] init];
    coverImageElement.image = [UIImage imageNamed:@"myself"];
    coverImageElement.fillMode = LNAsyncImageScaleAspactFill;
    
    LNAsyncLinerGradientElement *gradientElement = [[LNAsyncLinerGradientElement alloc] init];
    gradientElement.direction = LNAsyncLinerGradientElementVertical;
    gradientElement.gradientColorArray = @[[[UIColor blackColor] colorWithAlphaComponent:0.f],[[UIColor blackColor] colorWithAlphaComponent:1.f]];
    gradientElement.gradientPercentPoints = @[@(0.f),@(1.f)];
    
    LNAsyncImageElement *audienceIconImageElement = [[LNAsyncImageElement alloc] init];
    audienceIconImageElement.image = [UIImage imageNamed:@"ic_bili_audience"];
    audienceIconImageElement.cornerRadius = 7.f;
    
    LNAsyncTextElement *audienceNumberElement = [[LNAsyncTextElement alloc] init];
    audienceNumberElement.text = @"10.4万";
    audienceNumberElement.attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f],
                                         NSForegroundColorAttributeName:[UIColor whiteColor]
    };
    
    LNAsyncTextElement *authorNameElement = [[LNAsyncTextElement alloc] init];
    authorNameElement.text = @"levison的直播间";
    authorNameElement.attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f],
                                     NSForegroundColorAttributeName:[UIColor whiteColor]
    };

    
    LNAsyncTextElement *liveTagElement = [[LNAsyncTextElement alloc] init];
    liveTagElement.cornerRadius = 3.f;
    liveTagElement.borderColor = [UIColor colorWithRed:239.f/255.f green:91.f/255.f blue:156.f/255.f alpha:1.f];
    liveTagElement.borderWidth = 1.f;
    liveTagElement.text = @"直播";
    liveTagElement.font = [UIFont systemFontOfSize:12.f];
    liveTagElement.textColor = [UIColor colorWithRed:239.f/255.f green:91.f/255.f blue:156.f/255.f alpha:1.f];
    liveTagElement.textAligment = NSTextAlignmentCenter;

    LNAsyncTextElement *liveContextElement = [[LNAsyncTextElement alloc] init];
    liveContextElement.text = @"视频聊天";
    liveContextElement.textAligment = NSTextAlignmentLeft;
    liveContextElement.textColor = [UIColor colorWithRed:155.f/255.f green:155.f/255.f blue:155.f/255.f alpha:1.f];
    liveContextElement.font = [UIFont systemFontOfSize:12.f];
    
    LNAsyncTextElement *introduceTextElement = [[LNAsyncTextElement alloc] init];
    introduceTextElement.font = [UIFont systemFontOfSize:12.f];
    introduceTextElement.textColor = [UIColor blackColor];
    introduceTextElement.lineBreakMode = NSLineBreakByWordWrapping;
    introduceTextElement.text = @"和封面一样 吴彦祖COS";
    
    [cellContentElement addSubElement:coverImageElement];
    [coverImageElement addSubElement:gradientElement];
    [coverImageElement addSubElement:audienceIconImageElement];
    [coverImageElement addSubElement:audienceNumberElement];
    [coverImageElement addSubElement:authorNameElement];
    [cellContentElement addSubElement:introduceTextElement];
    [cellContentElement addSubElement:liveTagElement];
    [cellContentElement addSubElement:liveContextElement];
    
    coverImageElement.frame = CGRectMake(0.f, 0.f, 200.f, 140.f);
    gradientElement.frame = CGRectMake(0.f, 110.f, 200.f, 30.f);
    audienceIconImageElement.frame = CGRectMake(10.f, 118.f, 14.f, 14.f);
    audienceNumberElement.frame = CGRectMake(34.f, 118.f, 44.f, 14.f);
    authorNameElement.frame = CGRectMake(80.f, 118.f, 110.f, 14.f);
    
    introduceTextElement.frame = CGRectMake(10.f, 144.f , 180.f, 30.f);
    liveTagElement.frame = CGRectMake(10.f, 176.f , 32.f, 16.f);
    liveContextElement.frame = CGRectMake(46.f, 177.f, 100.f, 14.f);
    
    [LNAsyncRenderer traversalElement:cellContentElement];
    
    return cellContentElement.renderResult;
}

- (UIImageView *)targetImageView
{
    if (!_targetImageView) {
        _targetImageView = [[UIImageView alloc] init];
    }
    return _targetImageView;
}

- (UIButton *)feedbackButton2
{
    if (!_feedbackButton2) {
        _feedbackButton2 = [[UIButton alloc] init];
    }
    return _feedbackButton2;
}

- (UIView *)cellContentView
{
    if (!_cellContentView) {
        _cellContentView = [[UIView alloc] init];
    }
    return _cellContentView;
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

- (UIImageView *)audienceIconImageView
{
    if (!_audienceIconImageView) {
        _audienceIconImageView = [[UIImageView alloc] init];
    }
    return _audienceIconImageView;
}

- (UILabel *)audienceNumberLabel
{
    if (!_audienceNumberLabel) {
        _audienceNumberLabel = [[UILabel alloc] init];
    }
    return _audienceNumberLabel;
}

- (UILabel *)authorNameLabel
{
    if (!_authorNameLabel) {
        _authorNameLabel = [[UILabel alloc] init];
    }
    return _authorNameLabel;
}

- (UILabel *)introduceLabel
{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc] init];
    }
    return _introduceLabel;
}

- (UILabel *)liveTagLabel
{
    if (!_liveTagLabel) {
        _liveTagLabel = [[UILabel alloc] init];
    }
    return _liveTagLabel;
}

- (UILabel *)liveContextLabel
{
    if (!_liveContextLabel) {
        _liveContextLabel = [[UILabel alloc] init];
    }
    return _liveContextLabel;
}

- (UIButton *)feedbackButton
{
    if (!_feedbackButton) {
        _feedbackButton = [[UIButton alloc] init];
    }
    return _feedbackButton;
}

@end
