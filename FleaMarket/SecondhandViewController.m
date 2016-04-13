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
