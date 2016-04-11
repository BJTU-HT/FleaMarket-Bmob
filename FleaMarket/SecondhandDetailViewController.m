//
//  SecondhandDetailViewController.m
//  FleaMarket
//
//  Created by tom555cat on 16/4/10.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandDetailViewController.h"
#import "Help.h"

@interface SecondhandDetailViewController ()

// 头像
@property (nonatomic, strong) UIImageView *iconImageView;
// 名字
@property (nonatomic, strong) UILabel *nameLabel;
// 性别
@property (nonatomic, strong) UIImageView *sexImageView;
// 价格
@property (nonatomic, strong) UILabel *priceLabel;
// 描述
@property (nonatomic, strong) UILabel *descriptionLabel;
// 配图
@property (nonatomic, strong) UIScrollView *pictureImageScrollView;
// 学校
@property (nonatomic, strong) UILabel *schoolLabel;
// 地址
@property (nonatomic, strong) UILabel *locationLabel;
// 发布时间
@property (nonatomic, strong) UILabel *publishTimeLabel;

@end

@implementation SecondhandDetailViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupFrame];
}

- (void)setup
{
    // 图片无限轮播
    UIScrollView *pictureImageScrollView = [[UIScrollView alloc] init];
    self.pictureImageScrollView = pictureImageScrollView;
    self.pictureImageScrollView.pagingEnabled = YES;   // 确保整页移动
    
    // 头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = HTNameFont;
    self.nameLabel = nameLabel;
    
    UIImageView *sexImageView = [[UIImageView alloc] init];
    self.sexImageView = sexImageView;
    
    UILabel *publishTimeLabel = [[UILabel alloc] init];
    publishTimeLabel.font = HTNameFont;
    self.publishTimeLabel = publishTimeLabel;
    
    UILabel *schoolLabel = [[UILabel alloc] init];
    schoolLabel.font = HTNameFont;
    self.schoolLabel = schoolLabel;
}

- (void)setupFrame
{
    NSLog(@"%@", self.model.userName);
    CGFloat topMargin = 10;
    CGFloat margin = 10;
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat navigationBarH = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarH = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    // 图片轮播
    CGFloat pictureX = 0;
    CGFloat pictureY = navigationBarH + statusBarH;
    CGFloat pictureW = winSize.width;
    CGFloat pictureH = winSize.height * 0.2f;
    self.pictureImageScrollView.frame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
    self.pictureImageScrollView.contentSize = CGSizeMake(pictureW * [self.model.pictureArray count], 0);
    self.pictureImageScrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.pictureImageScrollView];
    
    
    // 头像
    CGFloat iconX = margin;
    CGFloat iconY = margin + CGRectGetMaxY(self.pictureImageScrollView.frame);
    CGFloat iconWH = 30;
    self.iconImageView.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
    [self.view addSubview:self.iconImageView];
    
    // 姓名
    CGFloat nameY = iconY;
    CGFloat nameX = CGRectGetMaxX(self.iconImageView.frame) + margin;
    NSDictionary *nameAttrs = @{NSFontAttributeName : HTNameFont};
    CGSize nameSize = [self.model.userName sizeWithAttributes:nameAttrs];
    self.nameLabel.frame = (CGRect){{nameX, nameY}, nameSize};
    [self.view addSubview:self.nameLabel];
    
    
    // 性别
    CGFloat sexY = iconY;
    CGFloat sexX = CGRectGetMaxX(self.nameLabel.frame) + margin/2.0f;
    CGFloat sexWH = nameSize.height;
    self.sexImageView.frame = CGRectMake(sexX, sexY, sexWH, sexWH);
    [self.view addSubview:self.sexImageView];
    
    
    // 发布时间
    NSDictionary *publishAttrs = @{NSFontAttributeName : HTNameFont};
    CGSize publishSize = [self.model.publishTime sizeWithAttributes:publishAttrs];
    CGFloat publishY = CGRectGetMaxY(self.iconImageView.frame) - publishSize.height;
    CGFloat publishX = CGRectGetMaxX(self.iconImageView.frame) + margin;
    self.publishTimeLabel.frame = (CGRect){{publishX, publishY}, publishSize};
    [self.view addSubview:self.publishTimeLabel];
    
    
    // 学校
    NSDictionary *schoolAttrs = @{NSFontAttributeName : HTNameFont};
    CGSize schoolSize = [self.model.school sizeWithAttributes:schoolAttrs];
    CGFloat schoolY = iconY + iconWH/2.0f - schoolSize.height/2.0f;
    CGFloat schoolX = winSize.width - schoolSize.width - margin;
    self.schoolLabel.frame = (CGRect){{schoolX, schoolY}, schoolSize};
    [self.view addSubview:self.schoolLabel];
    
    
    

    
}

- (void)setModel:(SecondhandVO *)model
{
    _model = model;
    
    self.iconImageView.image = [UIImage imageNamed:model.userIconImage];
    self.nameLabel.text = model.userName;
    self.sexImageView.image = [UIImage imageNamed:model.sex];
    self.publishTimeLabel.text = model.publishTime;
    self.schoolLabel.text = model.school;
}

@end
