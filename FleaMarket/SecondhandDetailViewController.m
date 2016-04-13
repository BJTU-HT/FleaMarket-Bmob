//
//  SecondhandDetailViewController.m
//  FleaMarket
//
//  Created by tom555cat on 16/4/10.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandDetailViewController.h"
#import "Help.h"
#define KscreenWith self.view.frame.size.width
#define Kheght self.view.frame.size.height

@interface SecondhandDetailViewController () <UIScrollViewDelegate>

// 头像
@property (nonatomic, strong) UIImageView *iconImageView;
// 名字
@property (nonatomic, strong) UILabel *nameLabel;
// 性别
@property (nonatomic, strong) UIImageView *sexImageView;
// 现在价格
@property (nonatomic, strong) UILabel *nowPriceLabel;
// 原始价格
@property (nonatomic, strong) UILabel *originalPriceLabel;
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

// 左视图
@property (nonatomic, strong) UIImageView *currentImageView;
// 中视图
@property (nonatomic, strong) UIImageView *leftImageView;
// 右视图
@property (nonatomic, strong) UIImageView *rightImageView;
//
@property (nonatomic, assign) NSInteger currentImageIndex, leftImageIndex, rightImageIndex;
// PageControl
@property (nonatomic, strong) UIPageControl *pageControl;


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
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupFrame];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)setup
{
    // page control
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    
    // 头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    
    // 名字
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = HTNameFont;
    self.nameLabel = nameLabel;
    
    // 性别
    UIImageView *sexImageView = [[UIImageView alloc] init];
    self.sexImageView = sexImageView;
    
    // 发布日期
    UILabel *publishTimeLabel = [[UILabel alloc] init];
    publishTimeLabel.font = HTNameFont;
    self.publishTimeLabel = publishTimeLabel;
    
    // 学校
    UILabel *schoolLabel = [[UILabel alloc] init];
    schoolLabel.font = HTNameFont;
    self.schoolLabel = schoolLabel;
    
    // 现在价格
    UILabel *nowPriceLabel = [[UILabel alloc] init];
    nowPriceLabel.font = HTTextFont;
    self.nowPriceLabel = nowPriceLabel;
    
    // 原始价格
    UILabel *originalPriceLabel = [[UILabel alloc] init];
    originalPriceLabel.font = HTTextFontLess;
    self.originalPriceLabel = originalPriceLabel;
    
    // 描述
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.font = HTTextFont;
    self.descriptionLabel = descriptionLabel;
    
    // 地址
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.font = HTTextFont;
    self.locationLabel = locationLabel;
}

- (void)setupFrame
{
    NSLog(@"%@", self.model.userName);
    CGFloat margin = 10;
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat navigationBarH = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarH = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    // 图片轮播
    [self setUpScrollView];
    
    // 返回按钮
    CGFloat returnBtnX = margin;
    CGFloat returnBtnY = margin*2;
    CGFloat returnBtnWH = 30;
    UIButton *returnBtn = [[UIButton alloc] init];
    returnBtn.frame = CGRectMake(returnBtnX, returnBtnY, returnBtnWH, returnBtnWH);
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnToMain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    // 设置pageControl
    CGFloat spaceForOne = winSize.width / 10.0f;   // 最多上传10张图片
    CGFloat pageControlW = spaceForOne * self.model.pictureArray.count;
    CGFloat pageControlH = spaceForOne;
    CGFloat pageControlX = winSize.width / 2.0f - pageControlW / 2.0f;
    CGFloat pageControlY = navigationBarH + statusBarH + winSize.height * 0.3f * 0.7f;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    self.pageControl.numberOfPages = self.model.pictureArray.count;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];

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
    
    // 现在价格
    CGFloat nowPriceX = margin;
    CGFloat nowPriceY = CGRectGetMaxY(self.iconImageView.frame) + margin/2.0f;
    NSDictionary *nowPriceAttr = @{NSFontAttributeName : HTTextFont};
    CGSize nowPriceSize = [[NSString stringWithFormat:@"￥%ld", self.model.nowPrice] sizeWithAttributes:nowPriceAttr];
    self.nowPriceLabel.frame = (CGRect){{nowPriceX, nowPriceY}, nowPriceSize};
    [self.view addSubview:self.nowPriceLabel];
    
    // 原始价格
    NSDictionary *originalPriceAttr = @{NSFontAttributeName : HTTextFontLess};
    CGSize originalPriceSize = [[NSString stringWithFormat:@"￥%ld", self.model.originalPrice] sizeWithAttributes:originalPriceAttr];
    CGFloat originalPriceX = CGRectGetMaxX(self.nowPriceLabel.frame);
    CGFloat originalPriceY = CGRectGetMaxY(self.nowPriceLabel.frame) - originalPriceSize.height;
    self.originalPriceLabel.frame = (CGRect){{originalPriceX, originalPriceY}, originalPriceSize};
    [self.view addSubview:self.originalPriceLabel];
    
    // 描述
    CGFloat descriptionX = margin;
    CGFloat descriptionY = CGRectGetMaxY(self.nowPriceLabel.frame) + margin;
    CGFloat descriptionW = winSize.width - 2 * margin;
    self.descriptionLabel.textAlignment = NSTextAlignmentLeft;
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.frame = CGRectMake(descriptionX, descriptionY, descriptionW, 0);    // 暂时
    CGRect txtFrame = self.descriptionLabel.frame;
    self.descriptionLabel.frame = CGRectMake(descriptionX, descriptionY, descriptionW, txtFrame.size.height = [self.descriptionLabel.text boundingRectWithSize:CGSizeMake(txtFrame.size.width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.descriptionLabel.font, NSFontAttributeName, nil] context:nil].size.height);
    self.descriptionLabel.frame = CGRectMake(descriptionX, descriptionY, descriptionW, txtFrame.size.height);
    [self.view addSubview:self.descriptionLabel];
    
    // 地址
    CGFloat locationX = margin;
    CGFloat locationY = CGRectGetMaxY(self.descriptionLabel.frame) + margin / 2.0f;
    NSDictionary *locationAttr = @{NSFontAttributeName : HTTextFont};
    CGSize locationSize = [self.model.location sizeWithAttributes:locationAttr];
    self.locationLabel.frame = (CGRect){{locationX, locationY}, locationSize};
    [self.view addSubview:self.locationLabel];
    
    // 间隔
    CGFloat partX = 0;
    CGFloat partY = CGRectGetMaxY(self.locationLabel.frame) + margin;
    CGFloat partH = HTPartBar;
    UIView *partBar = [[UIView alloc] initWithFrame:CGRectMake(partX, partY, winSize.width, partH)];
    partBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:partBar];
    
    // 浏览过此商品的人
    CGFloat viewTimesLabelX = margin;
    CGFloat viewTimesLabelY = CGRectGetMaxY(partBar.frame) + margin / 2.0f;
    NSDictionary *viewTimesAttr = @{NSFontAttributeName : HTTextFont};
    CGSize viewTimesSize = [[NSString stringWithFormat:@"最近%ld人来访", self.model.skimTimes] sizeWithAttributes:viewTimesAttr];
    UILabel *skimTimesLabel = [[UILabel alloc] init];
    skimTimesLabel.font = HTTextFont;
    skimTimesLabel.frame = (CGRect){{viewTimesLabelX, viewTimesLabelY}, viewTimesSize};
    skimTimesLabel.backgroundColor = [UIColor greenColor];
    skimTimesLabel.text = [NSString stringWithFormat:@"最近%ld人来访", self.model.skimTimes];
    [self.view addSubview:skimTimesLabel];
    
    // 浏览的人
    CGFloat skimIconX = margin;
    CGFloat skimIconY = CGRectGetMaxY(skimTimesLabel.frame) + margin / 2.0f;
    CGFloat skimIconW = winSize.width - 2 * margin;
    UIView *skimIcons = [[UIView alloc] initWithFrame:CGRectMake(skimIconX, skimIconY, skimIconW, iconWH)];
    skimIcons.backgroundColor = [UIColor grayColor];
    [self.view addSubview:skimIcons];
    
    // 间隔
    CGFloat part1X = 0;
    CGFloat part1Y = CGRectGetMaxY(skimIcons.frame) + margin / 2.0f;
    CGFloat part1H = HTPartBar;
    UIView *part1Bar = [[UIView alloc] initWithFrame:CGRectMake(part1X, part1Y, winSize.width, part1H)];
    part1Bar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:part1Bar];
    
    // 留言
    CGFloat messageX = margin;
    CGFloat messageY = CGRectGetMaxY(part1Bar.frame) + margin / 2.0f;
    NSDictionary *messageAttr = @{NSFontAttributeName : HTTextFont};
    CGSize messageSize = [@"留言" sizeWithAttributes:messageAttr];
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.font = HTTextFont;
    messageLabel.text = @"留言";
    messageLabel.frame = (CGRect){{messageX, messageY}, messageSize};
    [self.view addSubview:messageLabel];

}

- (void)returnToMain
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpScrollView {
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat scrollViewH =  winSize.height * 0.3f;
    CGFloat scrollViewW = winSize.width;
    
    self.pictureImageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollViewW, scrollViewH)];
    self.pictureImageScrollView.showsHorizontalScrollIndicator = NO;
    self.pictureImageScrollView.showsVerticalScrollIndicator = NO;
    self.pictureImageScrollView.pagingEnabled = YES;
    self.pictureImageScrollView.backgroundColor = [UIColor grayColor];
    
    // 给scrollview设置偏移量
    [self.pictureImageScrollView setContentOffset:CGPointMake(KscreenWith, 0) animated:NO];
    // 给scrollview赋初值
    _currentImageIndex = 0;
    self.leftImageIndex = self.model.pictureArray.count - 1;
    self.rightImageIndex = 1;
    
    // 创建ImageView
    self.pictureImageScrollView.contentSize = CGSizeMake(3 * KscreenWith , 0);
    self.currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KscreenWith, 0, KscreenWith, scrollViewH)];
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,KscreenWith, scrollViewH)];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2 * KscreenWith, 0, KscreenWith, scrollViewH)];
    
    // 给ImageView赋值
    self.currentImageView.image = [UIImage imageNamed:self.model.pictureArray[self.currentImageIndex]];
    self.leftImageView.image = [UIImage imageNamed:self.model.pictureArray[self.leftImageIndex]];
    self.rightImageView.image = [UIImage imageNamed:self.model.pictureArray[self.rightImageIndex]];
    
    // 设置代理
    self.pictureImageScrollView.delegate = self;
    [self.pictureImageScrollView addSubview:self.currentImageView];
    [self.pictureImageScrollView addSubview:self.leftImageView];
    [self.pictureImageScrollView addSubview:self.rightImageView];
    self.pictureImageScrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.pictureImageScrollView];
}


- (void)reloadImages
{
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGPoint point = [self.pictureImageScrollView contentOffset];
    NSLog(@"point.x ----%f", point.x);
    // 求_currentImageIndex的值
    if (point.x == 2 * winSize.width) {
        
        if ((_currentImageIndex + 1)  == self.model.pictureArray.count){
            _currentImageIndex = 0;
        }else {
            _currentImageIndex = (_currentImageIndex + 1);
        }
        
    }else if (point.x == 0) {
        if (_currentImageIndex - 1 < 0) {
            _currentImageIndex = self.model.pictureArray.count - 1;
            
        }else {
            _currentImageIndex = _currentImageIndex - 1;
        }
    }
    self.pageControl.currentPage = _currentImageIndex;
    
    // 求self.letfImageIdex的值
    if (_currentImageIndex - 1 < 0) {
        self.leftImageIndex = self.model.pictureArray.count - 1;
    }else {
        self.leftImageIndex = _currentImageIndex - 1;
    }
    
    // 求self.rightImageIndex的值
    if (self.currentImageIndex + 1 == self.model.pictureArray.count) {
        self.rightImageIndex = 0;
    }else {
        self.rightImageIndex = self.currentImageIndex + 1;
    }
    self.currentImageView.image = [UIImage imageNamed:self.model.pictureArray[self.currentImageIndex]];
    self.leftImageView.image = [UIImage imageNamed:self.model.pictureArray[self.leftImageIndex]];
    self.rightImageView.image = [UIImage imageNamed:self.model.pictureArray[self.rightImageIndex]];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    [self reloadImages];
    [self.pictureImageScrollView setContentOffset:CGPointMake(winSize.width, 0) animated:NO];
}

- (void)setModel:(SecondhandVO *)model
{
    _model = model;
    
    self.iconImageView.image = [UIImage imageNamed:model.userIconImage];
    self.nameLabel.text = model.userName;
    self.sexImageView.image = [UIImage imageNamed:model.sex];
    self.publishTimeLabel.text = model.publishTime;
    self.schoolLabel.text = model.school;
    self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%ld", model.nowPrice];
    self.originalPriceLabel.text = [NSString stringWithFormat:@"￥%ld", model.originalPrice];
    self.descriptionLabel.text = model.productName;
    self.locationLabel.text = model.location;
}

@end
