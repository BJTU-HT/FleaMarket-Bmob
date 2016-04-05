//
//  SecondhandDAO.m
//  FleaMarket
//
//  Created by tom555cat on 16/3/31.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "SecondhandDAO.h"
#import "VOGroup.h"

@implementation SecondhandDAO

static SecondhandDAO *sharedManager = nil;

+ (SecondhandDAO *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


- (void)create:(SecondhandVO *)model
{

}

- (void)modify:(SecondhandVO *)model
{

}

- (void)remove:(SecondhandVO *)model
{

}

- (void)findAll
{
    // 查询二手货数据, 默认返回10条数据
    NSMutableArray *listData = [VOGroup groupWithNameOfContent:@"Secondhand.plist"];
    [self.delegate findAllFinished:listData];
}



@end
