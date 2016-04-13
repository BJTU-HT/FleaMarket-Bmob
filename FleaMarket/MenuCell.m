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

// 电脑分类
@property (nonatomic, weak) UIButton *computerCategory;
// 衣服分类
@property (nonatomic, weak) UIImageView *clothesCategory;
// XX分类
@property (nonatomic, weak) UIImageView *test1Category;
// XX分类
@property (nonatomic, weak) UIImageView *test2Category;
// XX分类
@property (nonatomic, weak) UIImageView *test3Category;
// XX分类
@property (nonatomic, weak) UIImageView *test4Category;
// XX分类
@property (nonatomic, weak) UIImageView *test5Category;

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
            //menuBtn.backgroundColor = [UIColor colorWithRed:i*10.0f/255.0f green:i*10.0f/255.0f blue:i*10.0f/255.0f alpha:1.0];
            menuBtn.menuImage = [NSString stringWithFormat:@"label%d", i];
            menuBtn.menuName = [self menuNameArray][i];
            [menuBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.labelArray addObject:menuBtn];
            [self.menu addSubview:menuBtn];
        }
        
        /*
        // 电脑分类
        MenuButton *computerCategory = [[MenuButton alloc] init];
        computerCategory.tag = 0;
        computerCategory.menuImage = @"label0";
        computerCategory.menuName = @"电脑";
        [computerCategory addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [computerCategory addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryClick:)]];
        [self.menu addSubview:computerCategory];
        self.computerCategory = computerCategory;
        
        // 衣服分类
        UIImageView *clothesCategory = [[UIImageView alloc] init];
        [clothesCategory addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryClick:)]];
        clothesCategory.image = [UIImage imageNamed:@"label1"];
        [self.menu addSubview:clothesCategory];
        clothesCategory.tag = 1;
        self.clothesCategory = clothesCategory;
        
        // test分类
        UIImageView *test1Category = [[UIImageView alloc] init];
        [test1Category addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryClick:)]];
        test1Category.image = [UIImage imageNamed:@"label2"];
        test1Category.tag = 2;
        [self.menu addSubview:test1Category];
        self.test1Category = test1Category;
        
        // test分类
        UIImageView *test2Category = [[UIImageView alloc] init];
        [test2Category addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryClick:)]];
        test2Category.image = [UIImage imageNamed:@"label3"];
        test2Category.tag = 3;
        [self.menu addSubview:test2Category];
        self.test2Category = test2Category;
        
        // test分类
        UIImageView *test3Category = [[UIImageView alloc] init];
        [test3Category addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryClick:)]];
        test3Category.image = [UIImage imageNamed:@"label4"];
        test3Category.tag = 4;
        [self.menu addSubview:test3Category];
        self.test3Category = test3Category;
        
        // test分类
        UIImageView *test4Category = [[UIImageView alloc] init];
        [test4Category addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryClick:)]];
        test4Category.image = [UIImage imageNamed:@"label5"];
        test4Category.tag = 5;
        [self.menu addSubview:test4Category];
        self.test4Category = test4Category;
        
        // test分类
        UIImageView *test5Category = [[UIImageView alloc] init];
        [test5Category addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryClick:)]];
        test5Category.image = [UIImage imageNamed:@"label6"];
        test5Category.tag = 6;
        [self.menu addSubview:test5Category];
        self.test5Category = test5Category;
        */
        
    }
    
    return self;
}

- (void)buttonClicked:(UIButton *)category
{
    NSLog(@"button clicked!!!");
}

- (void)categoryClick:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"category clicked!!!!!");
}

- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    
    return _labelArray;
}

- (void)layoutSubviews
{
     NSLog(@"%s", __func__);
    [super layoutSubviews];
    
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat categoryW = winSize.width/5.0f;
    CGFloat categoryH = categoryW * 1.2f;

    /*
    for (int i = 0; i < [[self menuNameArray] count]; i++) {
        CGFloat menuBtnX = i * categoryW;
        CGFloat menuBtnY = 0;
        MenuButton *menuBtn = [[MenuButton alloc] initWithFrame:CGRectMake(menuBtnX, menuBtnY, categoryW, categoryH)];
        menuBtn.backgroundColor = [UIColor greenColor];
        menuBtn.menuImage = @"label1";
        menuBtn.menuName = @"1111";
        [menuBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.labelArray addObject:menuBtn];
        [self.menu addSubview:menuBtn];
    }
     */
    
    /*
    _menu.frame = _frameModel.menuFrame;
    _computerCategory.frame = _frameModel.computerCategoryFrame;
    _clothesCategory.frame = _frameModel.clothesCategoryFrame;
    _test1Category.frame = _frameModel.test1CategoryFrame;
    _test2Category.frame = _frameModel.test2CategoryFrame;
    _test3Category.frame = _frameModel.test3CategoryFrame;
    _test4Category.frame = _frameModel.test4CategoryFrame;
    _test5Category.frame = _frameModel.test5CategoryFrame;
     */
    

}



@end
