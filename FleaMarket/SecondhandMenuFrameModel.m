//
//  SecondhandMenuFrameModel.m
//  FleaMarket
//
//  Created by tom555cat on 16/4/7.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandMenuFrameModel.h"

@implementation SecondhandMenuFrameModel

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        CGFloat categoryW = winSize.width/5.0f;
        CGFloat categoryH = categoryW * 1.2f;
        
        // 整体菜单
        self.menuFrame = CGRectMake(0, 0, winSize.width, categoryH);
        
        // 电脑分类
        CGFloat computerX = 0;
        CGFloat computerY = 0;
        self.computerCategoryFrame = CGRectMake(computerX, computerY, categoryW, categoryH);
        
        // 衣服分类
        CGFloat clothesX = CGRectGetMaxX(self.computerCategoryFrame);
        CGFloat clothesY = 0;
        self.clothesCategoryFrame = CGRectMake(clothesX, clothesY, categoryW, categoryH);
        
        //
        CGFloat test1X = CGRectGetMaxX(self.clothesCategoryFrame);
        CGFloat test1Y = 0;
        self.test1CategoryFrame = CGRectMake(test1X, test1Y, categoryW, categoryH);
        
        //
        CGFloat test2X = CGRectGetMaxX(self.test1CategoryFrame);
        CGFloat test2Y = 0;
        self.test2CategoryFrame = CGRectMake(test2X, test2Y, categoryW, categoryH);
        
        //
        CGFloat test3X = CGRectGetMaxX(self.test2CategoryFrame);
        CGFloat test3Y = 0;
        self.test3CategoryFrame = CGRectMake(test3X, test3Y, categoryW, categoryH);
        
        //
        CGFloat test4X = CGRectGetMaxX(self.test3CategoryFrame);
        CGFloat test4Y = 0;
        self.test4CategoryFrame = CGRectMake(test4X, test4Y, categoryW, categoryH);
        
        //
        CGFloat test5X = CGRectGetMaxX(self.test4CategoryFrame);
        CGFloat test5Y = 0;
        self.test5CategoryFrame = CGRectMake(test5X, test5Y, categoryW, categoryH);
        
        _cellHeight = categoryH;
    }
    
    return _cellHeight;
}

@end
