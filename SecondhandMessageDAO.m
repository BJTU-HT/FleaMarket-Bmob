//
//  SecondhandMessageDAO.m
//  FleaMarket
//
//  Created by tom555cat on 16/4/12.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandMessageDAO.h"
#import "SecondhandMessageVOGroup.h"
#import "SecondhandMessageVO.h"


@implementation SecondhandMessageDAO

static SecondhandMessageDAO *sharedManager = nil;

+ (SecondhandMessageDAO *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)findSecondhandMessage:(NSString *)productID
{
    
    // 查询二手商品评论
    NSMutableArray *listData = [SecondhandMessageVOGroup groupWithNameOfContent:@"SecondhandMessage.plist"];
    
    // 根据商品ID过滤评论
    NSMutableArray *listDataForProductID = [[NSMutableArray alloc] init];
    for (SecondhandMessageVO *messageVO in listData) {
        NSString *pID = messageVO.productID;
        if ([pID isEqualToString:productID]) {
            [listDataForProductID addObject:messageVO];
        }
    }
    
    [self.delegate findSecondhandMessageFinished:listData];
    
}



@end
