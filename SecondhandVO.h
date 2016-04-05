//
//  SecondhandVO.h
//  FleaMarket
//
//  Created by tom555cat on 16/3/31.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondhandVO : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userIconImage;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *productID;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic) NSInteger nowPrice;
@property (nonatomic) NSInteger originalPrice;
@property (nonatomic, strong) NSMutableArray *pictureArray;
@property (nonatomic) NSInteger skimTimes;
@property (nonatomic) NSInteger praiseTimes;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *publishTime;



// 从plist读取数据
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
