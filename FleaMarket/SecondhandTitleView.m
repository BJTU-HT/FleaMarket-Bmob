//
//  SecondhandTitleView.m
//  FleaMarket
//
//  Created by tom555cat on 16/4/9.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandTitleView.h"

@interface SecondhandTitleView ()

@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation SecondhandTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 地理位置按钮
        UIButton *locationBtn = [[UIButton alloc] init];
        [locationBtn setBackgroundImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        [locationBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:locationBtn];
        self.locationBtn = locationBtn;
        
        // 搜索框
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        [self addSubview:searchBar];
        self.searchBar = searchBar;
    }
    
    return self;
}

- (void)btnClick
{
    NSLog(@"选择地址");
}

- (void)layoutSubviews
{
    CGFloat navigationBarH = 44;
    CGFloat statusBarH = 20;
    CGFloat margin = 10.0f;
    
    // 地理位置按钮
    CGFloat locationBtnX = 0;
    CGFloat locationBtnY = 0;
    CGFloat locationWH = self.frame.size.height;
    self.locationBtn.frame = CGRectMake(locationBtnX, locationBtnY, locationWH, locationWH);
    
    // 搜索bar
    CGFloat searchBarX = locationWH + margin;
    CGFloat searchBarY = 0;
    CGFloat searchBarW = self.frame.size.width - locationWH - margin;
    CGFloat searchBarH = self.frame.size.height;
    self.searchBar.frame = CGRectMake(searchBarX, searchBarY, searchBarW, searchBarH);
    
}

@end
