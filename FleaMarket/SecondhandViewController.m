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
#import "SecondhandTitleView.h"
#import "SecondhandDetailViewController.h"

static NSString *IDD = @"AA";
static NSString *IDD_MENU = @"BB";

@interface SecondhandViewController () <UITableViewDelegate, UITableViewDataSource, SecondhandBLDelegate, SecondhandCategoryDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *frameArray;

@property (nonatomic, weak) UITableView *tab;

@property (nonatomic, strong) SecondhandBL *bl;

@property (nonatomic, strong) NSMutableArray *labelArray;

@property (nonatomic, strong) UIScrollView *menu;

@end

@implementation SecondhandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二手市场";
    // Do any additional setup after loading the view.
    [self setup];
}

//暂时没有找到你在哪个位置隐藏了导航栏，在此处添加导航栏显示 2016-04-10 18：54 by houym
#pragma 添加导航栏显示
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
#pragma 添加导航栏显示end 当前VC退出后隐藏导航栏

- (void)setup
{
    // 设置navigationItem
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat navigationBarH = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarH = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat titleViewW = winSize.width * 0.7f;
    CGFloat titleViewH = navigationBarH * 0.8f;
    SecondhandTitleView *secondhandTitleView = [[SecondhandTitleView alloc] initWithFrame:CGRectMake(0, 0, titleViewW, titleViewH)];
    //secondhandTitleView.backgroundColor = [UIColor greenColor];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.titleView = secondhandTitleView;
    
    
    // 创建tableview
    CGRect newBounds = (CGRect){{0,0}, self.view.bounds.size};
    UITableView *vi = [[UITableView alloc] initWithFrame:newBounds style:UITableViewStylePlain];
    
    vi.delegate = self;
    vi.dataSource = self;
    [self.view addSubview:vi];
    [vi registerClass:[SecondhandCell class] forCellReuseIdentifier:IDD];
    [vi registerClass:[MenuCell class] forCellReuseIdentifier:IDD_MENU];
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
        menuCell.delegate = self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        // 菜单section
        NSLog(@"菜单section");
    } else {
        SecondhandDetailViewController *detailVC = [[SecondhandDetailViewController alloc] init];
        detailVC.model = [_dataArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailVC animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"上拉了 %f", scrollView.contentOffset.y);
    /*
    if ((int)scrollView.contentOffset.y <= 10) {
        NSLog(@"拉到头了");
        [self.tab.tableHeaderView setHidden:NO];
    } else {
        [self.tab.tableHeaderView setHidden:YES];
    }
     */
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat labelW = self.view.frame.size.width / 5.0f;
    CGFloat labelH = labelW * 0.2f;
    return labelH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat labelW = self.view.frame.size.width / 5.0f;
    CGFloat labelH = labelW * 0.2f;  // 图文标签的高度为1.2 * labelW, 文字标签高度为0.2 * labelW
    CGFloat menuX = 0;
    CGFloat menuY = 0;
    UIScrollView *menu = [[UIScrollView alloc] initWithFrame:CGRectMake(menuX, menuY, self.view.frame.size.width, labelH)];
    menu.backgroundColor = [UIColor whiteColor];
    
    // 添加二手商品分类标签
    for (int i = 0; i < 7; i++) {
        CGFloat labelX = i * labelW;
        CGFloat labelY = 0;
        UILabel *label = [[UILabel alloc] init];
        label.text = @"xxx";
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
    //[headerView addSubview:partBar];
    
    return headerView;
}
*/


#pragma mark --------------------SecondhandBLDelegate----------------------

- (void)findAllSecondhandFinished:(NSMutableArray *)list
{
    _dataArray = list;
    _frameArray = [SecondhandFrameModel frameModelWithArray:_dataArray];
    
    [self.tab reloadData];
}

#pragma mark --------------------SecondhandCategoryDelegate----------------

// 当用户点击菜单标签时，更新tableview数据
- (void)chooseCategory:(NSInteger)category
{
    NSLog(@"用户选择了 %ld 类二手产品", category);
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
