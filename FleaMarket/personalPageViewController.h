//
//  personalPageViewController.h
//  TestDemo1
//
//  Created by Hou on 3/4/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personalPageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)UITableView *tableView;
@end
