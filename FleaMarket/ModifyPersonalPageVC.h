//
//  ModifyPersonalPageVC.h
//  TestDemo1
//
//  Created by Hou on 3/28/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "passValueDelegate.h"

@interface ModifyPersonalPageVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain) UITableView *tableVieMP;
@property (nonatomic, retain) UIAlertController *sheetAlert;
@property (nonatomic, retain) UILabel *labelAddr;
@end
