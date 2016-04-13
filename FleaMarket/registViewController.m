//
//  registViewController.m
//  TestDemo1
//
//  Created by Hou on 2/23/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import "registViewController.h"
#import "logInViewController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobSMS.h>

@interface registViewController ()

@end

@implementation registViewController
float screenWidthRegist;
float screenHeightRegist;
CGRect screenFrameRegist;
UILabel *labelName;
UILabel *labelPassword1;
UITextField *textFieldPN;
UITextField *textFieldPassword;
UITextField *textFieldName;
UITextField *textFieldSM;

- (void)viewDidLoad {
    [super viewDidLoad];
    screenFrameRegist = [UIScreen mainScreen].applicationFrame;
    screenWidthRegist = screenFrameRegist.size.width;
    screenHeightRegist = screenFrameRegist.size.height;
    self.title = @"手机快速注册";
    [self drawRegist];
    
    // Do any additional setup after loading the view.
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)drawRegist
{
    //手机号
    UILabel *labelPhoneNumber = [[UILabel alloc] init];
    labelPhoneNumber.text = @"手机号";
    labelPhoneNumber.textColor = [UIColor blackColor];
    CGRect labelPN = CGRectMake(screenWidthRegist * 0.02, 64, screenWidthRegist * 0.15, screenHeightRegist * 0.10);
    labelPhoneNumber.frame = labelPN;
    [self.view addSubview:labelPhoneNumber];
    
    //pn = phone number
    textFieldPN = [[UITextField alloc] init];
    CGRect textfieldPNFrame = CGRectMake(screenWidthRegist * 0.17, 64, screenWidthRegist * (0.96 - 0.17), screenHeightRegist * 0.10);
    textFieldPN.frame = textfieldPNFrame;
    textFieldPN.delegate = self;
    [self.view addSubview: textFieldPN];
    
    UIView *viewPN = [[UIView alloc] init];
    CGRect viewPNFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * 0.11, screenWidthRegist * 0.96, screenHeightRegist * 0.003);
    viewPN.frame = viewPNFrame;
    viewPN.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:viewPN];
    
    //短信验证码
    UILabel *shortMessage = [[UILabel alloc] init];
    shortMessage.text = @"短信验证码";
    shortMessage.textColor = [UIColor blackColor];
    CGRect shortMessageFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * 0.12, screenWidthRegist * 0.3, screenHeightRegist * 0.10);
    shortMessage.frame = shortMessageFrame;
    [self.view addSubview:shortMessage];
    
    //短信验证码
    textFieldSM = [[UITextField alloc] init];
    CGRect textfieldSMFrame = CGRectMake(screenWidthRegist * 0.32, 64 + screenHeightRegist * 0.12 , screenWidthRegist * (0.96 - 0.64), screenHeightRegist * 0.10);
    textFieldSM.frame = textfieldSMFrame;
    textFieldSM.delegate = self;
    [self.view addSubview: textFieldSM];
    
    UIButton *buttonSM = [[UIButton alloc] init];
    [buttonSM setBackgroundColor:[UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0]];
    [buttonSM setTitle:@"获取验证码" forState: UIControlStateNormal];
    CGRect buttonGetSMFrame = CGRectMake(screenWidthRegist * 0.67, 64 + screenHeightRegist * 0.13, screenWidthRegist * 0.3, screenHeightRegist * 0.09);
    [buttonSM addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchDown];
    buttonSM.frame = buttonGetSMFrame;
    [buttonSM.layer setCornerRadius:8];
    [self.view addSubview:buttonSM];
    
    UIView *viewSM = [[UIView alloc] init];
    CGRect viewSMFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * (0.12 + 0.11), screenWidthRegist * 0.96, screenHeightRegist * 0.003);
    viewSM.frame = viewSMFrame;
    viewSM.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:viewSM];
    
    //昵称
    labelName = [[UILabel alloc] init];
    labelName.text = @"昵称";
    labelName.textColor = [UIColor blackColor];
    CGRect labelNameFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * 0.24, screenWidthRegist * 0.15, screenHeightRegist * 0.10);
    labelName.frame = labelNameFrame;
    [self.view addSubview:labelName];
    
    textFieldName = [[UITextField alloc] init];
    CGRect textFieldNameFrame = CGRectMake(screenWidthRegist * 0.17, 64 + screenHeightRegist * 0.24, screenWidthRegist * (0.96 - 0.17), screenHeightRegist * 0.10);
    textFieldName.frame = textFieldNameFrame;
    textFieldName.text = @"15个字符以内";
    textFieldName.clearsOnBeginEditing = YES;
    textFieldName.textColor = [UIColor grayColor];
    textFieldName.delegate = self;
    [self.view addSubview: textFieldName];
    
    UIView *viewName = [[UIView alloc] init];
    CGRect viewNameFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * 0.35, screenWidthRegist * 0.96, screenHeightRegist * 0.003);
    viewName.frame = viewNameFrame;
    viewName.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:viewName];
    
    //密码
    labelPassword1 = [[UILabel alloc] init];
    labelPassword1.text = @"密码";
    labelPassword1.textColor = [UIColor blackColor];
    CGRect labelPasswordFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * 0.36, screenWidthRegist * 0.15, screenHeightRegist * 0.10);
    labelPassword1.frame = labelPasswordFrame;
    [self.view addSubview:labelPassword1];
    
    //pn = phone number
    textFieldPassword = [[UITextField alloc] init];
    CGRect textFieldPassWordFrame = CGRectMake(screenWidthRegist * 0.17, 64 + screenHeightRegist * 0.36, screenWidthRegist * (0.96 - 0.17), screenHeightRegist * 0.10);
    textFieldPassword.frame = textFieldPassWordFrame;
    textFieldPassword.text = @"5-20位数字与字母";
    textFieldPassword.clearsOnBeginEditing = YES;
    textFieldPassword.textColor = [UIColor grayColor];
    textFieldPassword.delegate = self;
    [self.view addSubview: textFieldPassword];
    
    UIView *viewPassword = [[UIView alloc] init];
    CGRect viewPasswordFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * 0.47, screenWidthRegist * 0.96, screenHeightRegist * 0.003);
    viewPassword.frame = viewPasswordFrame;
    viewPassword.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:viewPassword];
    
    UILabel *labelClick = [[UILabel alloc] init];
    labelClick.text = @"点击完成即同意";
    labelClick.textColor = [UIColor blackColor];
    labelClick.font = [UIFont systemFontOfSize:12];
    CGRect labelclickFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * 0.48, screenWidthRegist * 0.24, screenHeightRegist * 0.10);
    labelClick.frame = labelclickFrame;
    [self.view addSubview:labelClick];
    
    UIButton *buttonLabel = [[UIButton alloc] init];
    CGRect buttonLabelFrame = CGRectMake(screenWidthRegist * 0.26, 64 + screenHeightRegist * 0.48, screenWidthRegist * 0.44, screenHeightRegist * 0.10);
    [buttonLabel setTitle:@"《书香人家用户注册协议》" forState:UIControlStateNormal];
    [buttonLabel setTitleColor:[UIColor colorWithRed:235/255.0 green:147/255.0 blue:33/255 alpha:1.0] forState:UIControlStateNormal];
    buttonLabel.frame = buttonLabelFrame;
    buttonLabel.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:buttonLabel];
    
    UIButton *buttonFinishRegist = [[UIButton alloc] init];
    CGRect buttonFRFrame = CGRectMake(screenWidthRegist * 0.02, 64 + screenHeightRegist * 0.60, screenWidthRegist * 0.96, screenHeightRegist * 0.10);
    buttonFinishRegist.frame = buttonFRFrame;
    [buttonFinishRegist setTitle:@"完成注册，进入我爱旅游网" forState:UIControlStateNormal];
    buttonFinishRegist.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [buttonFinishRegist addTarget:self action:@selector(buttonRegistClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:buttonFinishRegist];
    
    UILabel *label = [[UILabel alloc] init];
    CGRect labelFrame = CGRectMake(screenWidthRegist * 0.04, 64 + screenHeightRegist * 0.80, screenWidthRegist * 0.96, screenHeightRegist * 0.10);
    label.frame = labelFrame;
    label.text = @"注：暂不支持海外手机号注册，建议第三方登录";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview: label];
}

//获取验证码
-(void)getVerifyCode:(UIButton *)sender
{
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:textFieldPN.text
                                           andTemplate:@"verifySM"
                                           resultBlock:nil];
}
-(void)buttonRegistClicked:(UIButton *)sender
{
    NSDictionary *dicToBmob = @{@"phoneNumber":textFieldPN.text, @"verifyCode": textFieldSM.text, @"userName":textFieldName.text, @"passWord": textFieldPassword.text};
    BmobObject *bmobObj = [[BmobObject alloc] initWithClassName:@"userInfo"];
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:textFieldPN.text andSMSCode:textFieldSM.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful)
        {
            [bmobObj saveAllWithDictionary:dicToBmob];
            [bmobObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if(isSuccessful)
                {
                    NSLog(@"上传成功");
                    [self performSelector:@selector(registSuccess:) withObject:nil afterDelay:0];
                }
                else
                {
                    UIAlertController *alertCon = [[UIAlertController alloc] init];
                    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"数据上传失败，请重新上传" style:UIAlertActionStyleDefault handler:nil];
                    [alertCon addAction:alertAction];
                }
            }];
            
        }
        else
        {
            UIAlertController *alertCon = [[UIAlertController alloc] init];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"数据上传失败，请重新上传" style:UIAlertActionStyleDefault handler:nil];
            [alertCon addAction:alertAction];
            [self presentationController ];
        }
    }];

}
// 注册成功跳转到登录页面
-(void)registSuccess:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    logInViewController *logIn = [[logInViewController alloc] init];
    [self.navigationController pushViewController:logIn animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
