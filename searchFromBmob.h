//
//  searchFromBmob.h
//  FleaMarket
//
//  Created by Hou on 4/11/16.
//  Copyright © 2016 H-T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "passValueDelegate.h"

@interface searchFromBmob : NSObject

@property (nonatomic, retain)NSObject<pagePassValueDelegate> *delegate;
@property (nonatomic, strong) NSDictionary *userDic;
-(void)searchUserInfo:(NSString *)userName secret:(NSString *)passWord;
-(void)uploadFileBatchByPathBtn;
- (void)uploadFileBatchByNSDataBtn:(NSMutableArray *)mutableArrayPhoto;
@end
