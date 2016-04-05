//
//  SecondhandBL.m
//  FleaMarket
//
//  Created by tom555cat on 16/3/31.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandBL.h"

@implementation SecondhandBL

- (void)createSecondhand:(SecondhandVO *)model
{

}

- (void)removeSecondhand:(SecondhandVO *)model
{

}

- (void)findAllSecondhand
{
    // 查询二手货信息
    SecondhandDAO *secondhandDAO = [SecondhandDAO sharedManager];
    secondhandDAO.delegate = self;
    [secondhandDAO findAll];
}

- (void)modifySecondhand:(SecondhandVO *)model
{

}

#pragma --mark ----------SecondhandDAODelegate 委托方法--------------
- (void)findAllFinished:(NSMutableArray *)list
{
    [self.delegate findAllSecondhandFinished:list];
}

- (void)findAllFailed:(NSError *)error
{
    [self.delegate findAllSecondhandFailed:error];
}


@end
