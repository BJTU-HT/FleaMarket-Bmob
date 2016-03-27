//
//  TonglmTestViewController.m
//  FleaMarket
//
//  Created by tom555cat on 16/3/27.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "TonglmTestViewController.h"

@interface TonglmTestViewController ()

@end

@implementation TonglmTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 测试数据库
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"user_test"];
    [bquery getObjectInBackgroundWithId:@"ACdO0006" block:^(BmobObject *object, NSError *error) {
        if (error) {
            NSLog(@"Data from BMOB fail!");
        } else {
            if (object) {
                NSString *userName = [object objectForKey:@"user_name"];
                NSLog(@"Data from BMOB: %@", userName);
            }
        }
    }];
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
