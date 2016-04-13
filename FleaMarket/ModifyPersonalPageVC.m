//
//  ModifyPersonalPageVC.m
//  TestDemo1
//
//  Created by Hou on 3/28/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import "ModifyPersonalPageVC.h"
#import "personalPageViewController.h"
#import "publicMethod.h"
#import "cityListVC.h"
//#import "MyAlertCenter.h"

//HEAD VIEW SIZE
#define VIEWHEAD_HEIGHT_PER 0.5
#define VIEWHEAD_X_OFFSET 0
#define VIEWHEAD_Y_OFFSET 0

//HEADER VIEW IMAGE
#define VIEWIMAGE_X_OFFSET_PER 0.05
#define VIEWIMAGE_Y_OFFSET_PER 0.02
#define VIEWIMAGE_GAP_PER 0.05
#define VIEWIMAGE_WIDTH_PER 0.9
#define VIEWIMAGE_HEIGHT_PER 0.46

//HEADER IMAGE
#define IMAGEHEAD_WIDTH_PER 0.15
#define IMAGEHEAD_Y_OFFSET_PER 0.10
#define LABELHEAD_Y_OFFSET 0.30
#define HEIGHT_ROW_PER 0.10

//昵称， 常住地，性别， 签名
#define NAME_X_OFFSET_PER 0.05
#define NAMELABEL_TEXT_GAP_PER 0.05
#define TEXTFIELD_WIDTH_PER 0.7

@interface ModifyPersonalPageVC ()

@end

@implementation ModifyPersonalPageVC
@synthesize tableVieMP;
@synthesize sheetAlert;
@synthesize labelAddr;

CGRect screenFrameMP;
float screenWidthMP;
float screenHeightMP;
NSString *recCityName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"设置个人资料";
    [self addButtonToNav];
    tableVieMP = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableVieMP.delegate = self;
    tableVieMP.dataSource = self;
    //去除多余的cell空格线
    [tableVieMP setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:tableVieMP];
    screenFrameMP = [UIScreen mainScreen].applicationFrame;
    screenWidthMP = screenFrameMP.size.width;
    screenHeightMP = screenFrameMP.size.height;
//    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"登陆成功"];
    //键盘弹出调整视图
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

//代理传值实现方法
-(void)passValue:(NSString *)value
{
    recCityName = value;
}

-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}

-(void)keyboardWillDisappear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    currentFrame.size.height += change;
    tableVieMP.frame = currentFrame;
}

-(void)keyboardWillAppear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    currentFrame.size.height = currentFrame.size.height - change;
    tableVieMP.frame = currentFrame;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier= [NSString stringWithFormat:@"cellForRowIdentifier%ld%ld", (long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //NSLog(@"创建cell中......");
    }
    if(indexPath.row == 0)
    {
        [cell addSubview:[self ViewForFirstRow]];;
    }
    else
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        float label_x_offset = NAME_X_OFFSET_PER * screenWidthMP;
        //标签字号设为30px 3个字的宽度
        float labelWidth = 30 * 3/4 * 3;
        float labelHeight = 30 * 3/4 * 1.5;
        float label_y_offset = ((screenHeightMP * HEIGHT_ROW_PER) - labelHeight)/2;
        label.frame = CGRectMake(label_x_offset, label_y_offset, labelWidth, labelHeight);
        switch (indexPath.row) {
            case 1:
                label.text = @"昵称";
                break;
            case 2:
                label.text = @"性别";
                break;
            case 3:
                label.text = @"常住地";
                break;
            case 4:
                label.text = @"签名";
                break;
            default:
                break;
        }
        
        //textField 字号设置为36px
        float textField_x_offset = label_x_offset + labelWidth + screenWidthMP * NAMELABEL_TEXT_GAP_PER;
        float textField_Width = screenWidthMP * TEXTFIELD_WIDTH_PER;
        float textField_Height = 36 * 3/4 * 1.5;
        float textField_y_offset = (screenHeightMP * HEIGHT_ROW_PER - textField_Height)/2;
        if(indexPath.row == 1 || indexPath.row == 4)
        {
            UITextField *textField = [[UITextField alloc] init];
            textField.delegate = self;
            textField.frame = CGRectMake(textField_x_offset, textField_y_offset, textField_Width, textField_Height);
            textField.textColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
            [cell addSubview:textField];
        }
        else if (indexPath.row == 2 || indexPath.row == 3)
        {
            UILabel *labelGender = [[UILabel alloc] init];
            //frame 和 UITextfield相同
            labelGender.frame = CGRectMake(textField_x_offset, textField_y_offset, textField_Width, textField_Height);
            labelGender.userInteractionEnabled = YES;
            UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelGenderAddrCilcked:)];
            labelGender.tag = indexPath.row;
            [labelGender addGestureRecognizer:labelTap];
            [cell addSubview:labelGender];
        }
        [cell addSubview:label];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//点击性别，常住地响应方法
-(void)labelGenderAddrCilcked:(UITapGestureRecognizer *)recognizer
{
    UILabel *label = (UILabel *)[recognizer view];
    if(label.tag == 2)
    {
        UIAlertController *alertController = [[UIAlertController alloc]init];
        UIAlertAction *actionM = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            label.text = @"男";
            label.textColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
        }];
        UIAlertAction *actionF = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            label.text = @"女";
            label.textColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
        }];
        UIAlertAction *actionSecrect = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            label.text = @"保密";
            label.textColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
        }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler: nil];
        [alertController addAction:actionF];
        [alertController addAction:actionM];
        [alertController addAction:actionSecrect];
        [alertController addAction:actionCancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(label.tag == 3)
    {
        self.hidesBottomBarWhenPushed = YES;
        cityListVC *city = [[cityListVC alloc] init];
        [self.navigationController pushViewController:city animated:NO];
        self.hidesBottomBarWhenPushed = NO;
        
        while(recCityName == nil)
        {
            NSLog(@"runLoop begin...");
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"runLoop end...");
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                label.text = @"beijing";
                label.textColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
            });
        });
    }
}

//UIActionSheet 回调方法
//- (void)UserImageClicked
//{
//    
//    // 判断是否支持相机
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        
//        self.sheetAlert = [UIAlertController alloc];
//        self.sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照", @"从相册选择", nil];
//    }
//    else {
//        self.sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
//    }
//    
//    self.sheet.tag = 255;
//    //[self.sheet showInView:self.view];
//    
//    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
//    if ([window.subviews containsObject:self.view]) {
//        [self.sheet showInView:self.view];
//    } else {
//        [self.sheet showInView:window];
//    }
//}
//
////委托函数调用
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (actionSheet.tag == 255) {
//        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        // 判断是否支持相机
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            switch (buttonIndex) {
//                case 0:
//                    return;
//                case 1: //相机
//                    sourceType = UIImagePickerControllerSourceTypeCamera;
//                    break;
//                case 2: //相册
//                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                    break;
//            }
//        }
//        else {
//            if (buttonIndex == 0) {
//                return;
//            } else {
//                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//            }
//        }
//        // 跳转到相机或相册页面
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        imagePickerController.delegate = self;
//        imagePickerController.allowsEditing = YES;
//        imagePickerController.sourceType = sourceType;
//        
//        [self presentViewController:imagePickerController animated:YES completion:^{}];
//    }
//}

//关闭键盘 UITextField代理方法 关闭键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
    {
        return screenHeightMP * VIEWHEAD_HEIGHT_PER;
    }
    else
    {
        return screenHeightMP * HEIGHT_ROW_PER;
    }
}

-(UIView *)ViewForFirstRow
{
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.frame = CGRectMake(VIEWHEAD_X_OFFSET, VIEWHEAD_Y_OFFSET, screenWidthMP, screenHeightMP * VIEWHEAD_HEIGHT_PER);
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(VIEWIMAGE_X_OFFSET_PER * screenWidthMP, VIEWIMAGE_Y_OFFSET_PER * screenHeightMP, VIEWIMAGE_WIDTH_PER * screenWidthMP, VIEWIMAGE_HEIGHT_PER * screenHeightMP);
    imageView.image = [UIImage imageNamed:@"pic1.jpg"];
    
    UIImageView *imageViewHeadImage = [[UIImageView alloc] init];
    publicMethod *publicMP = [[publicMethod alloc] init];
    imageViewHeadImage.image = [publicMP circleImage:[UIImage imageNamed:@"QQ.jpg"] withParam:1];
    float imageViewHeadXOffset = screenWidthMP/2 - (screenWidthMP * IMAGEHEAD_WIDTH_PER)/2;
    float imageViewHeadWidth = (screenWidthMP * IMAGEHEAD_WIDTH_PER);
    float imageViewHeadYOffset = screenHeightMP * IMAGEHEAD_Y_OFFSET_PER;
    float imageViewHeadHeight = imageViewHeadWidth;
    imageViewHeadImage.frame = CGRectMake(imageViewHeadXOffset, imageViewHeadYOffset, imageViewHeadWidth, imageViewHeadHeight);
    
    UIButton *buttonHeadImage = [[UIButton alloc] init];
    UIButton *buttonBackgroundImage = [[UIButton alloc] init];
    [buttonHeadImage setTitle:@"设置背景" forState:UIControlStateNormal];
    [buttonHeadImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonBackgroundImage setTitle:@"设置头像" forState:UIControlStateNormal];
    [buttonBackgroundImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonBackgroundImage addTarget:self action:@selector(buttonBackGroundImageClicked:) forControlEvents:UIControlEventTouchDown];
    [buttonHeadImage addTarget:self action:@selector(buttonHeadImageClicked:) forControlEvents:UIControlEventTouchDown];
    buttonBackgroundImage.layer.borderWidth = 2.0;
    buttonBackgroundImage.layer.cornerRadius = 15.0;
    buttonBackgroundImage.layer.borderColor = [UIColor whiteColor].CGColor;
    buttonHeadImage.layer.borderWidth = 2.0;
    buttonHeadImage.layer.cornerRadius = 15.0;
    buttonHeadImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //字号设置为30px  5 代表按照五个字设置宽度
    float setHeadWidth = (36 * 3/4 * 4);
    float setHeadXOffset = (screenWidthMP/2 - setHeadWidth)/2;
    float setHeadHeight = (36 * 3/4) * 1.5;
    float setHeadYOffset = screenHeightMP * LABELHEAD_Y_OFFSET;
    buttonHeadImage.frame = CGRectMake(setHeadXOffset, setHeadYOffset, setHeadWidth, setHeadHeight);
    
    float setBackgroundWidth = setHeadWidth;
    float setBackgroundXOffset = screenWidthMP/2 + setHeadXOffset;
    float setBackgroundHeight = setHeadHeight;
    float setBackgroundYOffset = setHeadYOffset;
    buttonBackgroundImage.frame = CGRectMake(setBackgroundXOffset, setBackgroundYOffset, setBackgroundWidth, setBackgroundHeight);

    [viewHeader insertSubview:imageView atIndex:0];
    [viewHeader insertSubview:buttonHeadImage atIndex:1];
    [viewHeader insertSubview:buttonBackgroundImage atIndex:1];
    [viewHeader insertSubview:imageViewHeadImage atIndex:1];
    return viewHeader;
}

//点击更换背景按钮
-(void)buttonBackGroundImageClicked:(UIButton *)sender
{
    
}

//点击更换头像按钮
-(void)buttonHeadImageClicked:(UIButton *)sender
{
    
}
-(void)addButtonToNav
{
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClicked:)];
    leftBarItem.tintColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked:)];
    rightBarItem.tintColor = [UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

-(void)leftButtonClicked:(UIButton *)sender
{
    personalPageViewController *perVC = [[personalPageViewController alloc] init];
    [self.navigationController pushViewController:perVC animated:NO];
    self.navigationController.navigationBarHidden = YES;
}

-(void)rightButtonClicked:(UIButton *)sender
{
    
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
