//
//  SecondhandViewController.m
//  FleaMarket
//
//  Created by tom555cat on 16/3/28.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandViewController.h"
#import "SecondhandCell.h"
#import "SecondhandBL.h"
#import "SecondhandBLDelegate.h"
#import "SecondhandVO.h"
#import "Help.h"
#import "MenuCell.h"

static NSString *IDD = @"AA";
static NSString *IDD_MENU = @"BB";

@interface SecondhandViewController () <UITableViewDelegate, UITableViewDataSource, SecondhandBLDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *frameArray;

@property (nonatomic, strong) SecondhandMenuFrameModel *menuFrame;

@property (nonatomic, weak) UITableView *tab;

@property (nonatomic, strong) SecondhandBL *bl;

@property (nonatomic, strong) NSMutableArray *labelArray;

@property (nonatomic, strong) UIScrollView *menu;

@end

@implementation SecondhandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)setup
{
    
    /*
    // 创建菜单
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    UIScrollView *menu = [[UIScrollView alloc] init];
    CGFloat labelW = winSize.width / 5.0f;
    CGFloat labelH = labelW * 1.2f;
    CGFloat navigationBarH = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarH = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat menuH = labelH + navigationBarH + statusBarH;
    menu.frame = CGRectMake(0, 0, winSize.width, menuH);
    
    // 添加二手商品分类标签
    for (int i = 0; i < 7; i++) {
        CGFloat labelX = i * labelW;
        CGFloat labelY = 0;
        UIImageView *label = [[UIImageView alloc] init];
        label.image = [UIImage imageNamed:[NSString stringWithFormat:@"label%d", i]];
        //label.text = [NSString stringWithFormat:@"label%d", i];
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [menu addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        
        // 添加点击标签事件
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        
        [self.labelArray addObject:label];
    }
    menu.contentSize = CGSizeMake(labelW * 7, 0);
    menu.showsHorizontalScrollIndicator = NO;
    menu.bounces = NO;
     
    [self.view addSubview:menu];
    
    // 分隔条
    CGFloat partBarX = 0;
    CGFloat partBarY = CGRectGetMaxY(menu.frame);
    CGFloat partBarH = HTPartBar;
    CGFloat partBarW = self.view.frame.size.width;
    UIView *partBar = [[UIView alloc] initWithFrame:CGRectMake(partBarX, partBarY, partBarW, partBarH)];
    partBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:partBar];
    */
    
    // 创建tableview
    CGRect newBounds = (CGRect){{0,0}, self.view.bounds.size};
    UITableView *vi = [[UITableView alloc] initWithFrame:newBounds style:UITableViewStylePlain];
    
    vi.delegate = self;
    vi.dataSource = self;
    [self.view addSubview:vi];
    [vi registerClass:[SecondhandCell class] forCellReuseIdentifier:IDD];
    [vi registerClass:[MenuCell class] forCellReuseIdentifier:IDD_MENU];
    //[vi registerClass:[MitchellCell class] forCellReuseIdentifier:IDD];
    self.tab = vi;
    
    // 创建BL
    self.bl = [SecondhandBL new];
    self.bl.delegate = self;
    [self.bl findAllSecondhand];
}

- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    for (UIView *view in self.labelArray) {
        view.backgroundColor = [UIColor whiteColor];
    }
    recognizer.view.backgroundColor = [UIColor yellowColor];
}

#pragma mark --------------------tableViewDelegate--------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondhandCell *cell = [tableView dequeueReusableCellWithIdentifier:IDD];
    MenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:IDD_MENU];
    
    if (indexPath.section == 0) {
        //menuCell.frameModel = self.menuFrame;
        //menuCell.backgroundColor = [UIColor greenColor];
        return menuCell;
    } else {
        cell.model = [_dataArray objectAtIndex:indexPath.row];
        cell.frameModel = [_frameArray objectAtIndex:indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        CGFloat categoryW = winSize.width/5.0f;
        CGFloat categoryH = categoryW * 1.2f;
        return categoryH;
    } else {
        SecondhandFrameModel *frameModel = self.frameArray[indexPath.row];
        return frameModel.cellHeight;
    }
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat labelW = self.view.frame.size.width / 5.0f;
    CGFloat labelH = labelW * 1.2f;
    return labelH + HTPartBar;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat labelW = self.view.frame.size.width / 5.0f;
    CGFloat labelH = labelW * 1.2f;
    CGFloat menuX = 0;
    CGFloat menuY = 0;
    UIScrollView *menu = [[UIScrollView alloc] initWithFrame:CGRectMake(menuX, menuY, self.view.frame.size.width, labelH)];
    menu.backgroundColor = [UIColor whiteColor];
    
    // 添加二手商品分类标签
    for (int i = 0; i < 7; i++) {
        CGFloat labelX = i * labelW;
        CGFloat labelY = 0;
        UIImageView *label = [[UIImageView alloc] init];
        label.image = [UIImage imageNamed:[NSString stringWithFormat:@"label%d", i]];
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [menu addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        
        // 添加点击标签事件
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        
        [self.labelArray addObject:label];
    }
    
    menu.contentSize = CGSizeMake(labelW * 7, 0);
    menu.showsHorizontalScrollIndicator = NO;
    menu.bounces = NO;
    
    // 分隔条
    CGFloat partBarX = 0;
    CGFloat partBarY = labelH;
    CGFloat partBarH = HTPartBar;
    CGFloat partBarW = self.view.frame.size.width;
    UIView *partBar = [[UIView alloc] initWithFrame:CGRectMake(partBarX, partBarY, partBarW, partBarH)];
    partBar.backgroundColor = [UIColor lightGrayColor];
    
    // header总视图
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, labelH + partBarH);
    [headerView addSubview:menu];
    [headerView addSubview:partBar];
    
    return headerView;
}
*/


#pragma mark --------------------SecondhandBLDelegate----------------------

- (void)findAllSecondhandFinished:(NSMutableArray *)list
{
    _dataArray = list;
    _frameArray = [SecondhandFrameModel frameModelWithArray:_dataArray];
    //_menuFrame = [[SecondhandMenuFrameModel alloc] init];
    
    [self.tab reloadData];
}

#pragma mark --------------------Initialize------------------------------

- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}

@end
