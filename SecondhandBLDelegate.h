//
//  SecondhandBLDelegate.h
//  FleaMarket
//
//  Created by tom555cat on 16/3/31.
//  Copyright © 2016年 H-T. All rights reserved.
//

#ifndef SecondhandBLDelegate_h
#define SecondhandBLDelegate_h

@protocol SecondhandBLDelegate

@optional

// 查询UITableViewController所需要的数据
- (void)findAllSecondhandFinished:(NSMutableArray *)list;
- (void)findAllSecondhandFailed:(NSError *)error;

@end


#endif /* SecondhandBLDelegate_h */
