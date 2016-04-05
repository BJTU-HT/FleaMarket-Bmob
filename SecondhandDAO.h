//
//  SecondhandDAO.h
//  FleaMarket
//
//  Created by tom555cat on 16/3/31.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecondhandVO.h"
#import "SecondhandDAODelegate.h"

@interface SecondhandDAO : NSObject

// 保存数据列表
@property (nonatomic, strong) NSMutableArray *listData;

@property (weak, nonatomic) id <SecondhandDAODelegate> delegate;

// 插入Secondhand方法
- (void)create:(SecondhandVO *)model;

// 修改Secondhand方法
- (void)modify:(SecondhandVO *)model;

// 删除Secondhand方法
- (void)remove:(SecondhandVO *)model;

// 查询所有数据方法
- (void)findAll;

+ (SecondhandDAO *)sharedManager;

@end
