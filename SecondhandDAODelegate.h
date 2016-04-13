//
//  SecondhandDAODelegate.h
//  FleaMarket
//
//  Created by tom555cat on 16/3/31.
//  Copyright © 2016年 H-T. All rights reserved.
//

@class SecondhandVO;

@protocol SecondhandDAODelegate

@optional

-(void)findAllFinished:(NSMutableArray *)list;
-(void)findAllFailed:(NSError *)error;

@end
