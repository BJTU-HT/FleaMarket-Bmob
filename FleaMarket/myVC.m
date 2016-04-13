//
//  myVC.m
//  FleaMarket
//
//  Created by Hou on 4/7/16.
//  Copyright © 2016 H-T. All rights reserved.
//

#import "myVC.h"
#import "logInViewController.h"
#import "setUpViewController.h"
#import "publicMethod.h"
#import "personalPageViewController.h"
#import "searchFromBmob.h"

#define loginPartOccupyScreenPercent 0.15
//第一个section的header view 头像位置所需宏定义
#define loginHeadImageOffset 0.06   //头像距离左侧边框偏移
@interface myVC ()

@end

@implementation myVC

@synthesize logInStatus;
CGRect screenFrame; //屏幕尺寸
CGRect rectStatus;  //状态栏
CGRect rectNav;     //导航栏
float screenWidthForMy;
float headViewHeight;
NSMutableArray *cellMutableArray;
NSMutableArray *cellMutableArrayImage;
NSString *userNameReceiveDelegate;
NSUserDefaults *userDefaultMy;
NSString *userNameMy;

-(void)viewDidLoad {
    [super viewDidLoad];
    userDefaultMy  = [NSUserDefaults standardUserDefaults];
    //从沙箱获取用户名 为nil代表未登录，有数值则已登录
    userNameMy = [userDefaultMy objectForKey:@"username"];
    [self drawMyViewPage];
    CGRect frame1 = CGRectMake(0, navStatusBarHeightPCH, screenWidthPCH, screenHeightPCH - navStatusBarHeightPCH);
    myTableView = [[ UITableView alloc ]initWithFrame: frame1 style:UITableViewStylePlain];
    myTableView.dataSource = self ;
    myTableView.delegate = self ;
    //解决图标下方无分割线的问题
    myTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    #pragma 解决cell分割线右错15pt的问题
    if ([myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    #pragma 解决右错15pt end
    self.title = @"我的";
    [self.view addSubview: myTableView];
    [self initializeArray];
    [self addButtonToNavigationBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBarHidden = YES;
//
//}
#pragma 解决cell分割线右错15pt的问题
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma 分割线右错15pt end

-(void)addButtonToNavigationBar
{
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ic_topbar_setting_orange@2x.png"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 32, 32);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:leftBtnItem];
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"ic_topbar_message_orange@2x.png"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 32, 32);
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [leftBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}

-(void)leftBtnClicked:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    setUpViewController *setUpVC = [[setUpViewController alloc] init];
    [self.navigationController pushViewController:setUpVC animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)rightBtnClicked:(UIButton *)sender
{
    
}

-(void)passValue:(NSString *)value
{
    userNameReceiveDelegate = value;
    logInStatus = 1;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeArray
{
    cellMutableArray = [[NSMutableArray alloc] init];
    cellMutableArrayImage = [[NSMutableArray alloc] init];
    NSArray *arrayTemp = [[NSArray alloc] initWithObjects:@"我的帖子",@"我的收藏",nil];
    NSArray *arrayTemp1 = [[NSArray alloc] initWithObjects: @"我的记事本",@"我的订单", nil];
    NSArray *arrayTemp2 = [[NSArray alloc] initWithObjects:@"我的优惠券",@"我的点评", nil];
    NSArray *arrayTemp3 = [[NSArray alloc] initWithObjects:@"我的问答",@"我的活动", nil];
    NSArray *arrayTemp4 = [[NSArray alloc] initWithObjects:@"我的轨迹", @"测试接口", nil];
    
    NSArray *arrayImg = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ic_mine_wengweng@2x.png"],[UIImage imageNamed:@"ic_mine_want@2x.png"], nil];
    NSArray *arrayImg1 = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ic_mine_note@2x.png"],[UIImage imageNamed:@"ic_mine_order@2x.png"], nil];
    NSArray *arrayImg2 = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ic_mine_coupon@2x.png"],[UIImage imageNamed:@"ic_mine_comment@2x.png"], nil];
    NSArray *arrayImg3 = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ic_mine_qa@2x.png"],[UIImage imageNamed:@"ic_mine_activity@2x.png"], nil];
    NSArray *arrayImg4 = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ic_mine_tourline@2x.png"],[UIImage imageNamed:@"ic_mine_want@2x.png"], nil];
    [cellMutableArray addObject:arrayTemp];
    [cellMutableArray addObject:arrayTemp1];
    [cellMutableArray addObject:arrayTemp2];
    [cellMutableArray addObject:arrayTemp3];
    [cellMutableArray addObject:arrayTemp4];
    [cellMutableArrayImage addObject:arrayImg];
    [cellMutableArrayImage addObject:arrayImg1];
    [cellMutableArrayImage addObject:arrayImg2];
    [cellMutableArrayImage addObject:arrayImg3];
    [cellMutableArrayImage addObject:arrayImg4];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0)
    {
        headViewHeight = screenHeightPCH * loginPartOccupyScreenPercent;
        return headViewHeight;
    }
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view;
    if(section == 0)
    {
        return [self drawSection0];
    }
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //NSLog(@"创建cell中......");
    }
    
    if([cellMutableArray count] > (indexPath.section - 1))
    {
        NSArray *array = [cellMutableArray objectAtIndex:indexPath.section - 1];
        NSArray *arrayImg = [cellMutableArrayImage objectAtIndex:indexPath.section - 1];
        if([array count] > indexPath.row)
        {
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.imageView.image = [arrayImg objectAtIndex:indexPath.row];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(userNameMy == nil)
    {
        self.hidesBottomBarWhenPushed = YES;
        logInViewController *logIn = [[logInViewController alloc] init];
        [self.navigationController pushViewController:logIn animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }
    else
    {
        switch(indexPath.section){
                //我的帖子，我的收藏
            case 1:
                if(indexPath.row == 1)
                {
                }
                else
                {
                }
                break;
                //我的记事本，我的订单
            case 2:
                if(indexPath.row == 0)
                {
                }
                break;
                //我的轨迹
            case 5:
                if(indexPath.row == 0)
                {
                }
                break;
        }
    }
}



-(void)drawMyViewPage
{
    CGRect frame = CGRectMake(100, 100, 50, 30);
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button.layer setCornerRadius:8];
    button.frame = frame;
    [button addTarget:self action:@selector(buttonLogInClicked:) forControlEvents: UIControlEventTouchDown];
    [self.view  addSubview:button];
}

-(void)buttonLogInClicked:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    logInViewController *logIn = [[logInViewController alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem: backItem];
    [self.navigationController pushViewController: logIn animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}

-(UIView *)drawSection0
{
    UIView *view1 = [[UIView alloc] init];
    if(userNameMy == nil)
    {
        UIButton *buttonView = [[UIButton alloc] init];
        CGRect buttonViewFrame = CGRectMake(0, 0, screenWidthPCH, headViewHeight);
        buttonView.frame = buttonViewFrame;
        
        UIImageView *headImage = [[UIImageView alloc] init];
        publicMethod *imageCircle = [[publicMethod alloc] init];
        headImage.image = [imageCircle circleImage:[UIImage imageNamed:@"004.jpg"] withParam:1];
        CGRect headImageFrame = CGRectMake(screenWidthPCH * loginHeadImageOffset, headViewHeight * 0.25, headViewHeight * 0.5, headViewHeight * 0.5);
        view1.backgroundColor = [UIColor clearColor];
        headImage.frame = headImageFrame;
        UILabel *label = [[UILabel alloc] init];
        label.text = @"点击登录";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:24 * 3/4];
        CGRect labelFrame = CGRectMake(screenWidthPCH * 0.28, headViewHeight * 0.40, screenWidthPCH * 0.35, headViewHeight * 0.10);
        label.frame = labelFrame;
        [buttonView addTarget:self action:@selector(buttonViewClicked:) forControlEvents:UIControlEventTouchDown];
        [buttonView addSubview:label];
        [buttonView addSubview:headImage];
        [view1 addSubview:buttonView];
    }
    else
    {
        UIImageView *headImage = [[UIImageView alloc] init];
        publicMethod *imageCircle = [[publicMethod alloc] init];
        headImage.image = [imageCircle circleImage:[UIImage imageNamed:@"004.jpg"] withParam:1];
        CGRect headImageFrame = CGRectMake(screenWidthPCH * loginHeadImageOffset, headViewHeight * 0.25, headViewHeight * 0.5, headViewHeight * 0.5);
        view1.backgroundColor = [UIColor clearColor];
        headImage.frame = headImageFrame;
        UILabel *label = [[UILabel alloc] init];
        label.text = @"我爱旅游网用户";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:20 * 3/4];
        CGRect labelFrame = CGRectMake(screenWidthPCH * 0.24, headViewHeight * 0.30, screenWidthPCH * 0.35, headViewHeight * 0.10);
        label.frame = labelFrame;
        [view1 addSubview:label];
        [view1 addSubview:headImage];
        
        UILabel *labelGuanZhu = [[UILabel alloc] init];
        CGRect labelGuanZhuFrame = CGRectMake(screenWidthPCH * 0.24, headViewHeight * 0.60, screenWidthPCH * 0.15, headViewHeight * 0.05);
        labelGuanZhu.frame = labelGuanZhuFrame;
        labelGuanZhu.text = @"关注:100";
        labelGuanZhu.textColor = [UIColor lightGrayColor];
        labelGuanZhu.font = [UIFont systemFontOfSize:14];
        [view1 addSubview:labelGuanZhu];
        
        UILabel *labelFans = [[UILabel alloc] init];
        CGRect labelFansFrame = CGRectMake(screenWidthPCH * (0.24 + 0.15 + 0.05), headViewHeight * 0.60, screenWidthPCH * 0.20, headViewHeight * 0.05);
        labelFans.frame = labelFansFrame;
        labelFans.text = @"粉丝:1000";
        labelFans.textColor = [UIColor lightGrayColor];
        labelFans.font = [UIFont systemFontOfSize:14];
        [view1 addSubview:labelFans];
        
        UIButton *buttonPerson = [[UIButton alloc] init];
        CGRect buttonPersonFrame = CGRectMake(screenWidthPCH *(0.28 + 0.35 + 0.05) , headViewHeight * 0.40, screenWidthPCH * 0.25, headViewHeight * 0.05);
        buttonPerson.frame = buttonPersonFrame;
        UILabel *labelPerson = [[UILabel alloc] init];
        CGRect labelPersonFrame = CGRectMake(0, 0, screenWidthPCH * 0.20, headViewHeight * 0.05);
        labelPerson.frame = labelPersonFrame;
        labelPerson.text = @"个人主页";
        labelPerson.font = [UIFont systemFontOfSize:18 * 3/4];
        labelPerson.textColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
        [buttonPerson addSubview: labelPerson];
        
        UIImage *imageArrow = [UIImage imageNamed:@"arrow.png"];
        CGRect imageArrowFrame = CGRectMake(screenWidthPCH * 0.18, 0, screenWidthPCH * 0.07, headViewHeight * 0.10);
        
        UIImageView *imageArrowView = [[UIImageView alloc] init];
        imageArrowView.image = imageArrow;
        imageArrowView.frame = imageArrowFrame;
        [buttonPerson addSubview:imageArrowView];
        [buttonPerson addTarget:self action:@selector(personalPageClicked:) forControlEvents:UIControlEventTouchDown];
        [view1 addSubview: buttonPerson];
        
    }
    UITapGestureRecognizer *tapGestureView1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view1Clicked:)];
    [view1 addGestureRecognizer:tapGestureView1];
    return view1;
}

-(void)view1Clicked:(UITapGestureRecognizer *)recognizer
{
    self.hidesBottomBarWhenPushed = YES;
    personalPageViewController *personalPage = [[personalPageViewController alloc] init];
    [self.navigationController pushViewController:personalPage animated:NO];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] init];
    barItem.title = @"";
    self.navigationItem.backBarButtonItem = barItem;
    //    [self.navigationController.navigationBar setTintColor:[UIColor yellowColor]];
    self.navigationController.navigationBar.alpha = 0.0;
    self.hidesBottomBarWhenPushed = NO;
    
}
-(void)personalPageClicked:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    personalPageViewController *personalPage = [[personalPageViewController alloc] init];
    [self.navigationController pushViewController:personalPage animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)buttonViewClicked:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    logInViewController *logIn = [[logInViewController alloc] init];
    [self.navigationController pushViewController:logIn animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

