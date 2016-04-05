//
//  SecondhandViewController.m
//  FleaMarket
//
//  Created by tom555cat on 16/3/28.
//  Copyright © 2016年 H-T. All rights reserved.
//

#import "SecondhandViewController.h"
#import "SecondhandCell.h"
#import "SecondhandBL.h"
#import "SecondhandBLDelegate.h"
#import "SecondhandVO.h"

static NSString *IDD = @"AA";

@interface SecondhandViewController () <UITableViewDelegate, UITableViewDataSource, SecondhandBLDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *frameArray;
@property (nonatomic, weak) UITableView *tab;

@property (nonatomic, strong) SecondhandBL *bl;

@end

@implementation SecondhandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)setup
{
    CGRect newBounds = (CGRect){{0,0}, self.view.bounds.size};
    UITableView *vi = [[UITableView alloc] initWithFrame:newBounds style:UITableViewStylePlain];
    
    vi.delegate = self;
    vi.dataSource = self;
    [self.view addSubview:vi];
    [vi registerClass:[SecondhandCell class] forCellReuseIdentifier:IDD];
    //[vi registerClass:[MitchellCell class] forCellReuseIdentifier:IDD];
    self.tab = vi;
    
    // 创建BL
    self.bl = [SecondhandBL new];
    self.bl.delegate = self;
    [self.bl findAllSecondhand];
}

#pragma mark --------------------tableViewDelegate--------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
    MitchellCell *cell = [tableView dequeueReusableCellWithIdentifier:IDD];
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    cell.frameModel = [_frameArray objectAtIndex:indexPath.row];
    return cell;
     */
    
    
    SecondhandCell *cell = [tableView dequeueReusableCellWithIdentifier:IDD];
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    cell.frameModel = [_frameArray objectAtIndex:indexPath.row];
    return cell;
    
    /*
     SecondhandVO *secondhand = self.dataArray[indexPath.row];
     cell.textLabel.text = secondhand.userName;
     cell.detailTextLabel.text = secondhand.productName;
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondhandFrameModel *frameModel = self.frameArray[indexPath.row];
    return frameModel.cellHeight;
    /*
    MitchellFrameModel *mo = [_frameArray objectAtIndex:indexPath.row];
    return mo.cellHeight;
     */
}

#pragma mark --------------------SecondhandBLDelegate----------------------

- (void)findAllSecondhandFinished:(NSMutableArray *)list
{
    _dataArray = list;
    _frameArray = [SecondhandFrameModel frameModelWithArray:_dataArray];
    
    
    //_dataArray = [ModelGroup groupWithNameOfContent:@"statuses.plist"];
    //_frameArray = [MitchellFrameModel frameModelWithArray:_dataArray];
    [self.tab reloadData];
}

@end
