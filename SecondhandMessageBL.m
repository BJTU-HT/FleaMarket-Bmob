//
//  SecondhandMessageBL.m
//  FleaMarket
//
//  Created by tom555cat on 16/4/13.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandMessageBL.h"

@implementation SecondhandMessageBL

- (void)findSecondhandMessage:(NSString *)productID
{
    SecondhandMessageDAO *secondhandMessageDAO = [SecondhandMessageDAO sharedManager];
    secondhandMessageDAO.delegate = self;
    [secondhandMessageDAO findSecondhandMessage:productID];
}

#pragma --mark --------------SecondhandMessageDAODelegate委托方法------------------
- (void)findSecondhandMessageFinished:(NSMutableArray *)list
{
    [self.delegate findSecondhandMessageFinished:list];
}

- (void)findSecondhandMessageFailed:(NSError *)error
{
    [self.delegate findSecondhandMessageFailed:error];
}

@end
