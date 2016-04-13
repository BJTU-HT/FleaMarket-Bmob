//
//  cityListVC.h
//  TestDemo1
//
//  Created by Hou on 3/31/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passValueDelegate.h"
#import "ModifyPersonalPageVC.h"

@interface cityListVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) UITableView *tableViewCity;
@property (nonatomic, assign) NSObject <pagePassValueDelegate> *delegate;
@property (nonatomic , retain ) NSMutableArray *dataArr;
@property (nonatomic , retain ) NSMutableArray *sortedArrForArrays;
@property (nonatomic , retain ) NSMutableArray *sectionHeadsKeys;
@end
