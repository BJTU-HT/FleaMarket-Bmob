//
//  SecondhandBL.h
//  FleaMarket
//
//  Created by tom555cat on 16/3/31.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecondhandBLDelegate.h"
#import "SecondhandDAODelegate.h"
#import "SecondhandDAO.h"

@interface SecondhandBL : NSObject <SecondhandDAODelegate>

@property (weak, nonatomic) id <SecondhandBLDelegate> delegate;

- (void)createSecondhand:(SecondhandVO *)model;

- (void)removeSecondhand:(SecondhandVO *)model;

- (void)findAllSecondhand;

- (void)modifySecondhand:(SecondhandVO *)model;

@end
