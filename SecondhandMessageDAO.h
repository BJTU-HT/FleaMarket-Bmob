//
//  SecondhandMessageDAO.h
//  FleaMarket
//
//  Created by tom555cat on 16/4/12.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecondhandMessageDAODelegate.h"

@interface SecondhandMessageDAO : NSObject

// 保存数据列表
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic, weak) id <SecondhandMessageDAODelegate> delegate;

// 插入评论

// 查询评论
- (void)findSecondhandMessage:(NSString *)productID;

+ (SecondhandMessageDAO *)sharedManager;

@end
