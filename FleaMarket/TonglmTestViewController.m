//
//  TonglmTestViewController.m
//  FleaMarket
//
//  Created by tom555cat on 16/3/27.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "TonglmTestViewController.h"
#import "SecondhandDAO.h"
#import "UserDAO.h"
#import "ModelGroup.h"
#import "VOGroup.h"

@interface TonglmTestViewController ()

@end

@implementation TonglmTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //SecondhandDAO *sdao = [SecondhandDAO sharedManager];
    //[sdao findAll];
    
    NSMutableArray *data = [ModelGroup groupWithNameOfContent:@"statuses.plist"];
    
    
    NSMutableArray *data1 = [VOGroup groupWithNameOfContent:@"Secondhand.plist"];
    NSLog(@"1111");
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
