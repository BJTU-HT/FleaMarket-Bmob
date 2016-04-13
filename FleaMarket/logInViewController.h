//
//  logInViewController.h
//  TestDemo1
//
//  Created by Hou on 2/17/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passValueDelegate.h"

@interface logInViewController : UIViewController<UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate>


@property (nonatomic, retain) UIView *underlineView;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIView *accountLoginView;
@property (nonatomic, retain) UIView *phoneNumberLoginView;
@property (nonatomic, retain) UIButton *accountButton;
@property (nonatomic, retain) UIButton *phoneNumberButton;
@property (nonatomic, strong) NSString *currentUserName;
@end
