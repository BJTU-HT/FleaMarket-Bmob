//
//  personalPageViewController.m
//  TestDemo1
//
//  Created by Hou on 3/4/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import "personalPageViewController.h"
//#import "myViewController.h"
#import "publicMethod.h"
#import "ModifyPersonalPageVC.h"
#import "myVC.h"

#define NAV_BUTTON_X_OFFSET_PER 0.05
#define NAV_BUTTON_WIDTH_PER 0.05
#define VIEW_X_OFFSET  0
#define VIEW_Y_OFFSET 0
#define VIEW_HEIGHT_PER 0.5
#define VIEW_WIDTH_PER 1.0
#define HEAD_IMAGE_WIDTH_PER 0.12
#define HEAD_NAME_GAP_PER 0.02
#define NAME_HEIGHT_PER 0.04
#define NAME_LEVEL_X_GAP 0.02
#define NAME_CONCERN_Y_GAP 0.01
#define CONCERN_HEIGHT_PER 0.03
#define FANS_HEIGHT_PER CONCERN_HEIGHT_PER
#define VIEWLINE_WIDTH_PER 0.005
#define VIEWLINE_HEIGHT_PER FANS_HEIGHT_PER
#define VIEW_FANS_GAP_PER 0.02
#define FANS_NOTE_GAP_PER 0.02
#define REMARK_WIDTH_PER 0.5
#define FANS_REMARK_GAP 0.02
#define REMARK_HEIGHT_PER 0.03
//修改个人资料
#define BUTTON_HEIGHT 0.10
#define BUTTON_WIDTH_PER 0.4
#define BUTTON_REMARK_GAP_PER 0.05


//四个按钮， 嗡嗡，
#define PER_LABEL_GAP_PER 0.25
#define LABEL_HEIGHT_PER 0.08
#define LABEL_HEIGHT_Y_OFFSET_PER 0.5
#define VIEW_LABEL_OFFSET_PER 0

//viewLine
#define VIEWLINEBTN_Y_OFFSET_PER 0.58
#define VIEWLINEBTN_HEIGHT_PER 0.003
#define VIEWLINEBTN_X_OFFSET VIEW_LABEL_OFFSET_PER
#define VIEWLINEBTN_WIDTH_PER PER_LABEL_GAP_PER

//下边线宏定义
#define UNDERLINE_X_OFFSET 0
#define UNDERLINE_Y_OFFSET 0.582
#define UNDERLINE_HEIGHT_PER 0.001

@interface personalPageViewController ()

@end

@implementation personalPageViewController
@synthesize tableView;
CGRect screenFramePersonal; //screen size
CGRect rectStatusPersonal; //status bar size
UIView *viewLineBtn;
UIButton *buttonStatus;
UIButton *buttonTravelNote;
UIButton *buttonAnswer;
UIButton *buttonRemark;

float statusBarHeight;
float screenWidthPersonal;
float screenHeightPersonal;
float naviBarHeightPersonal;
NSUInteger priorButtonTag;

-(void)viewDidLoad {
    [super viewDidLoad];
    tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    screenFramePersonal = [UIScreen mainScreen].bounds;
    rectStatusPersonal = [[UIApplication sharedApplication] statusBarFrame];
    statusBarHeight = rectStatusPersonal.size.height;
    screenWidthPersonal = screenFramePersonal.size.width;
    screenHeightPersonal = screenFramePersonal.size.height;
    naviBarHeightPersonal = self.navigationController.navigationBar.frame.size.height;
    self.navigationController.navigationBarHidden = YES;
    [self drawView];
}

-(void)drawView
{
    publicMethod *public = [[publicMethod alloc] init];
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"pic2.jpg"];
    imageView.image = image;
    imageView.frame = CGRectMake(VIEW_X_OFFSET, VIEW_Y_OFFSET, (screenWidthPersonal * VIEW_WIDTH_PER), (screenHeightPersonal * VIEW_HEIGHT_PER));
    [self.view addSubview:imageView];
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(screenWidthPersonal * NAV_BUTTON_X_OFFSET_PER, statusBarHeight, screenWidthPersonal * NAV_BUTTON_WIDTH_PER, naviBarHeightPersonal);
    [button setImage:[UIImage imageNamed:@"ic_topbar_back_mdd@2x.png"] forState:UIControlStateNormal];
    [self.view insertSubview:button atIndex:1];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    
    //头像图片
    UIImageView *imageViewHead = [[UIImageView alloc] init];
    float head_x_offset = (screenWidthPersonal - (screenHeightPersonal * HEAD_IMAGE_WIDTH_PER))/2;
    imageViewHead.frame = CGRectMake(head_x_offset, statusBarHeight + naviBarHeightPersonal, screenHeightPersonal * HEAD_IMAGE_WIDTH_PER, screenHeightPersonal * HEAD_IMAGE_WIDTH_PER);
    UIImage *imageHead = [public circleImage:[UIImage imageNamed:@"QQ.jpg"] withParam:1];
    imageViewHead.image = imageHead;
    [self.view insertSubview:imageViewHead atIndex:1];
    
    //昵称Label
    UILabel *labelName = [[UILabel alloc] init];
    labelName.text = @"程序员媛";
    labelName.font = [UIFont systemFontOfSize:24 * 3/4]; //24 为24px 24 * 3/4 = 18pt
    float nameXOffset = (screenWidthPersonal - 18 * 4)/2;
    float nameYOffset = statusBarHeight + naviBarHeightPersonal + screenHeightPersonal * HEAD_IMAGE_WIDTH_PER + screenHeightPersonal * HEAD_NAME_GAP_PER;
    float nameWidth = 18 * 4;
    //18 * 4 代表可以容纳4个字 18pt
    labelName.frame = CGRectMake(nameXOffset, nameYOffset, nameWidth, screenHeightPersonal * NAME_HEIGHT_PER);
    labelName.textColor = [UIColor whiteColor];
    labelName.textAlignment = NSTextAlignmentCenter;
    [self.view insertSubview:labelName atIndex:1];
    
    //level
    UILabel *labelLevel = [[UILabel alloc] init];
    labelLevel.text = @"Lv2";
    labelLevel.font = [UIFont systemFontOfSize:24 * 3/4];
    float levelXOffset = nameXOffset + nameWidth + screenWidthPersonal * NAME_LEVEL_X_GAP;
    float levelYOffset = nameYOffset;
    float levelWidth = 15 * 2;
    labelLevel.frame = CGRectMake(levelXOffset, levelYOffset, levelWidth, screenHeightPersonal * NAME_HEIGHT_PER);
    labelLevel.textColor = [UIColor whiteColor];
    labelLevel.font = [UIFont systemFontOfSize:20 * 3/4];
    labelLevel.textAlignment =  NSTextAlignmentCenter;
    [self.view insertSubview:labelLevel atIndex:1];
    
    //关注
    UILabel *labelConcern = [[UILabel alloc]init];
    labelConcern.text = @"关注 1";
    labelConcern.font = [UIFont systemFontOfSize:20 * 3/4];// 20 px
    float concernWidth = 20 * 3/4 * 3;
    float concernXOffset = screenWidthPersonal/2 - concernWidth;
    float concernYOffset = levelYOffset + screenHeightPersonal * NAME_CONCERN_Y_GAP + screenHeightPersonal * NAME_HEIGHT_PER;
    labelConcern.frame = CGRectMake(concernXOffset, concernYOffset, concernWidth, screenHeightPersonal * CONCERN_HEIGHT_PER);
    labelConcern.textColor = [UIColor whiteColor];
    labelConcern.textAlignment =  NSTextAlignmentCenter;
    [self.view insertSubview:labelConcern atIndex:1];
    
    //uiview
    UIView *viewLine = [[UIView alloc] init];
    viewLine.backgroundColor = [UIColor whiteColor];
    viewLine.frame = CGRectMake(screenWidthPersonal/2, concernYOffset, screenWidthPersonal * VIEWLINE_WIDTH_PER, screenHeightPersonal * VIEWLINE_HEIGHT_PER);
    [self.view insertSubview:viewLine atIndex:1];
    
    //fans
    UILabel *labelFans = [[UILabel alloc] init];
    labelFans.text = @"粉丝 0";
    labelFans.font = [UIFont systemFontOfSize:20 * 3/4];
    float fansWidth = 20 * 3/4 * 3;
    float fansXOffset = screenWidthPersonal *1/2 + VIEW_FANS_GAP_PER * screenWidthPersonal;
    float fansYOffset = levelYOffset + screenHeightPersonal * NAME_CONCERN_Y_GAP + screenHeightPersonal * NAME_HEIGHT_PER;
    labelFans.frame = CGRectMake(fansXOffset, fansYOffset, fansWidth, screenHeightPersonal * FANS_HEIGHT_PER);
    labelFans.textColor = [UIColor whiteColor];
    labelFans.textAlignment =  NSTextAlignmentCenter;
    [self.view insertSubview:labelFans atIndex:1];
    
    //备注
    UILabel *labelRemark = [[UILabel alloc] init];
    labelRemark.text = @"天生我材必有用";
    labelRemark.font = [UIFont systemFontOfSize:20 * 3/4];
    float remarkXOffset = screenWidthPersonal/2 - (screenWidthPersonal * REMARK_WIDTH_PER)/2;
    float remarkYOffset = fansYOffset + screenHeightPersonal * FANS_HEIGHT_PER + screenHeightPersonal * FANS_REMARK_GAP;
    float remarkWidth = screenWidthPersonal * REMARK_WIDTH_PER;
    float remarkHeight = screenHeightPersonal * REMARK_HEIGHT_PER;
    labelRemark.frame = CGRectMake(remarkXOffset, remarkYOffset, remarkWidth, remarkHeight);
    labelRemark.textAlignment = NSTextAlignmentCenter;
    labelRemark.textColor = [UIColor whiteColor];
    [self.view insertSubview:labelRemark atIndex:1];
    
    //修改个人资料
    UIButton *buttonModify = [[UIButton alloc] init];
    [buttonModify setTitle:@"修改个人资料" forState:UIControlStateNormal];
    [buttonModify setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonModify.titleLabel.font = [UIFont systemFontOfSize:30 * 3/4];
    buttonModify.layer.borderWidth = 2.0;
    buttonModify.layer.cornerRadius = 10.0;
    buttonModify.layer.borderColor = [UIColor whiteColor].CGColor;
    float buttonWidth = screenWidthPersonal * BUTTON_WIDTH_PER;
    float buttonHegiht = screenWidthPersonal * BUTTON_HEIGHT;
    float buttonXOffset = screenWidthPersonal/2 - (screenWidthPersonal * BUTTON_WIDTH_PER)/2;
    float buttonYOffset = remarkYOffset + remarkHeight + screenHeightPersonal * BUTTON_REMARK_GAP_PER;
    buttonModify.frame = CGRectMake(buttonXOffset, buttonYOffset, buttonWidth, buttonHegiht);
    [buttonModify addTarget:self action:@selector(buttonModifyClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view insertSubview:buttonModify atIndex:1];
    
    viewLineBtn = [[UIView alloc] init];
    viewLineBtn.frame = CGRectMake(VIEWLINEBTN_X_OFFSET, screenHeightPersonal * VIEWLINEBTN_Y_OFFSET_PER, screenWidthPersonal * VIEWLINEBTN_WIDTH_PER, screenHeightPersonal * VIEWLINEBTN_HEIGHT_PER);
    viewLineBtn.backgroundColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
    //添加底部四个按钮，嗡嗡 游记 回答 点评，
    buttonStatus = [[UIButton alloc] init];
    buttonStatus.frame = CGRectMake(0 * screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * LABEL_HEIGHT_Y_OFFSET_PER, screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * LABEL_HEIGHT_PER);
    [buttonStatus setTitle:@"状态" forState:UIControlStateNormal];
    [buttonStatus setTitleColor:[UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0] forState:UIControlStateNormal];
    [buttonStatus addTarget:self action:@selector(buttonStatusClicked:) forControlEvents:UIControlEventTouchDown];
    
    buttonTravelNote = [[UIButton alloc] init];
    buttonTravelNote.frame = CGRectMake(1 * screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * LABEL_HEIGHT_Y_OFFSET_PER, screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * LABEL_HEIGHT_PER);
    [buttonTravelNote setTitle:@"游记" forState:UIControlStateNormal];
    [buttonTravelNote setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonTravelNote addTarget:self action:@selector(buttonTravelNoteClicked:) forControlEvents:UIControlEventTouchDown];
    
    buttonAnswer = [[UIButton alloc] init];
    buttonAnswer.frame = CGRectMake(2 * screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * LABEL_HEIGHT_Y_OFFSET_PER, screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * LABEL_HEIGHT_PER);
    [buttonAnswer setTitle:@"回答" forState:UIControlStateNormal];
    [buttonAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonAnswer addTarget:self action:@selector(buttonAnswerClicked:) forControlEvents:UIControlEventTouchDown];
    
    buttonRemark = [[UIButton alloc] init];
    buttonRemark.frame = CGRectMake(3 * screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * LABEL_HEIGHT_Y_OFFSET_PER, screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * LABEL_HEIGHT_PER);
    [buttonRemark setTitle:@"点评" forState:UIControlStateNormal];
    [buttonRemark setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonRemark addTarget:self action:@selector(buttonRemarkClicked:) forControlEvents:UIControlEventTouchDown];
    
    priorButtonTag = 0;
    [self.view insertSubview:viewLineBtn atIndex:1];
    [self.view addSubview:buttonRemark];
    [self.view addSubview:buttonAnswer];
    [self.view addSubview:buttonTravelNote];
    [self.view addSubview:buttonStatus];
    //在四个按钮下面添加边线
    UIView *underLine = [[UIView alloc] init];
    underLine.frame = CGRectMake(UNDERLINE_X_OFFSET, UNDERLINE_Y_OFFSET * screenHeightPersonal, screenWidthPersonal, screenHeightPersonal * UNDERLINE_HEIGHT_PER);
    underLine.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    [self.view insertSubview:underLine atIndex:0];
}

//2
-(void)buttonAnswerClicked:(UIButton *)sender
{
    [self changeLineLocationAndTextColor];
    priorButtonTag = 2;
    [viewLineBtn removeFromSuperview];
    viewLineBtn.frame = CGRectMake(priorButtonTag * screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * VIEWLINEBTN_Y_OFFSET_PER, screenWidthPersonal * VIEWLINEBTN_WIDTH_PER, screenHeightPersonal * VIEWLINEBTN_HEIGHT_PER);
    [buttonAnswer setTitleColor:[UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:viewLineBtn];
}
//3
-(void)buttonRemarkClicked:(UIButton *)sender
{
    [self changeLineLocationAndTextColor];
    priorButtonTag = 3;
    [viewLineBtn removeFromSuperview];
    viewLineBtn.frame = CGRectMake(priorButtonTag * screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * VIEWLINEBTN_Y_OFFSET_PER, screenWidthPersonal * VIEWLINEBTN_WIDTH_PER, screenHeightPersonal * VIEWLINEBTN_HEIGHT_PER);
    [buttonRemark setTitleColor:[UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:viewLineBtn];
    
}
//1
-(void)buttonTravelNoteClicked:(UIButton *)sender
{
    [self changeLineLocationAndTextColor];
    [buttonTravelNote setTitleColor:[UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0] forState:UIControlStateNormal];
    priorButtonTag = 1;
    [viewLineBtn removeFromSuperview];
    viewLineBtn.frame = CGRectMake(priorButtonTag * screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * VIEWLINEBTN_Y_OFFSET_PER, screenWidthPersonal * VIEWLINEBTN_WIDTH_PER, screenHeightPersonal * VIEWLINEBTN_HEIGHT_PER);
    [self.view addSubview:viewLineBtn];
}
//0
-(void)buttonStatusClicked:(UIButton *)sender
{
    [self changeLineLocationAndTextColor];
    [buttonStatus setTitleColor:[UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0] forState:UIControlStateNormal];
    priorButtonTag = 0;
    [viewLineBtn removeFromSuperview];
    viewLineBtn.frame = CGRectMake(priorButtonTag * screenWidthPersonal * PER_LABEL_GAP_PER, screenHeightPersonal * VIEWLINEBTN_Y_OFFSET_PER, screenWidthPersonal * VIEWLINEBTN_WIDTH_PER, screenHeightPersonal * VIEWLINEBTN_HEIGHT_PER);
    [self.view addSubview:viewLineBtn];
}

-(void)changeLineLocationAndTextColor
{
    switch (priorButtonTag) {
        case 0:
            [buttonStatus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 1:
            [buttonTravelNote setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 2:
            [buttonAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 3:
            [buttonRemark setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
   
}
-(void)buttonModifyClicked:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    ModifyPersonalPageVC *mpVC = [[ModifyPersonalPageVC alloc] init];
    [self.navigationController pushViewController:mpVC animated:YES];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)buttonClicked:(UIButton *)sender
{
    myVC *myViewController = [[myVC alloc] init];
    [self.navigationController pushViewController:myViewController animated:NO];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
