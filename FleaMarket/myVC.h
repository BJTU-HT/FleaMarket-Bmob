//
//  myVC.h
//  FleaMarket
//
//  Created by Hou on 4/7/16.
//  Copyright © 2016 H-T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myVC : UIViewController<UITableViewDelegate, UITableViewDelegate>
{
    UITableView *myTableView;
}
@property (nonatomic,assign) NSInteger logInStatus;// logIn 1, logOut 0
@end
