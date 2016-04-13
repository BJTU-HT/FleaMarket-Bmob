//
//  setUpViewController.m
//  TestDemo1
//
//  Created by Hou on 4/11/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import "setUpViewController.h"

@interface setUpViewController ()

@end

@implementation setUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self logOut];
}

-(void)logOut
{
    UIButton *logOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 80)];
    [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:logOutBtn];
    [logOutBtn addTarget:self action:@selector(logOutBtnClicked:) forControlEvents:UIControlEventTouchDown];
}

-(void)logOutBtnClicked:(UIButton *)sender
{
    NSUserDefaults *defaultLogOut = [NSUserDefaults standardUserDefaults];
    [defaultLogOut setObject:nil forKey:@"username"];
    
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
