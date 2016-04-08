//
//  MenuButton.m
//  FleaMarket
//
//  Created by tom555cat on 16/4/8.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "MenuButton.h"

@interface MenuButton ()

@property (nonatomic, strong) UIImageView *menuImageView;

@property (nonatomic, strong) UILabel *menuNameLabel;

@end

@implementation MenuButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 菜单图片
        UIImageView *menuImageView = [[UIImageView alloc] init];
        [self addSubview:menuImageView];
        self.menuImageView = menuImageView;
        
        // 菜单文字
        UILabel *menuNameLabel = [[UILabel alloc] init];
        [self addSubview:menuNameLabel];
        self.menuNameLabel = menuNameLabel;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 菜单图片
    CGFloat menuImageViewX = 0;
    CGFloat menuImageViewY = 0;
    CGFloat menuImageViewHW = self.frame.size.width;
    self.menuImageView.frame = CGRectMake(menuImageViewX, menuImageViewY, menuImageViewHW, menuImageViewHW);
    
    // 标题图片
    CGFloat menuLabelX = 0;
    CGFloat menuLabelY = menuImageViewHW;
    CGFloat menuLabelW = self.frame.size.width;
    CGFloat menuLabelH = self.frame.size.height - menuImageViewHW;
    self.menuNameLabel.frame = CGRectMake(menuLabelX, menuLabelY, menuLabelW, menuLabelH);

    
}


- (void)setMenuName:(NSString *)menuName
{
    // 设置字体
    CGFloat fontSize = 14.0f;
    
    // 设置段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    // 格式
    NSMutableAttributedString *menuNameAttributeString = [[NSMutableAttributedString alloc] initWithString:menuName
                    attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                 NSFontAttributeName:[UIFont fontWithName:@"Verdana-Bold" size:fontSize],
                                 NSParagraphStyleAttributeName:paragraphStyle}];
    
    self.menuNameLabel.attributedText = menuNameAttributeString;
}

- (void)setMenuImage:(NSString *)menuImage
{
    self.menuImageView.image = [UIImage imageNamed:menuImage];
}

@end
