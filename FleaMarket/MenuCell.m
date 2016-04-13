//
//  MenuCell.m
//  FleaMarket
//
//  Created by tom555cat on 16/4/7.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "MenuCell.h"
#import "MenuButton.h"

@interface MenuCell()

// 整体scrollview
@property (nonatomic, weak) UIScrollView *menu;

// labelArray
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation MenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (NSArray *)menuNameArray
{
    NSArray *menuNameArray = [[NSArray alloc] initWithObjects:@"数码", @"衣服", @"鞋子", @"XX", @"YY", @"ZZ", @"KK", nil];
    return menuNameArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSLog(@"%s", __func__);
        
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        CGFloat categoryW = winSize.width/5.0f;
        CGFloat categoryH = categoryW * 1.2f;
        
        // 菜单
        UIScrollView *menu = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, winSize.width, categoryH)];
        self.menu = menu;
        self.menu.contentSize = CGSizeMake(categoryW * [[self menuNameArray] count] , 0);
        self.menu.showsHorizontalScrollIndicator = NO;
        self.menu.bounces = NO;
        [self.contentView addSubview:self.menu];
        
        // 添加标签按钮
        for (int i = 0; i < [[self menuNameArray] count]; i++) {
            CGFloat menuBtnX = i * categoryW;
            CGFloat menuBtnY = 0;
            MenuButton *menuBtn = [[MenuButton alloc] initWithFrame:CGRectMake(menuBtnX, menuBtnY, categoryW, categoryH)];
            menuBtn.menuImage = [NSString stringWithFormat:@"label%d", i];
            menuBtn.menuName = [self menuNameArray][i];
            
            // 设置标签的tag，根据tag来确定是哪一个分类
            menuBtn.tag = i;
            [menuBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.labelArray addObject:menuBtn];
            [self.menu addSubview:menuBtn];
        }
    }
    
    return self;
}

- (void)buttonClicked:(UIButton *)category
{
    //NSLog(@"button tag %ld", category.tag);
    [self.delegate chooseCategory:category.tag];
    
}


- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    
    return _labelArray;
}



@end
