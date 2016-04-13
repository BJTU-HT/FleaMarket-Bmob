//
//  searchFromBmob.m
//  FleaMarket
//
//  Created by Hou on 4/11/16.
//  Copyright © 2016 H-T. All rights reserved.
//

#import "searchFromBmob.h"
#import <BmobSDK/BmobQuery.h>
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>
#import "logInViewController.h"

@implementation searchFromBmob

//通过用户名查询该用户名下的所有信息 userInfo表
-(void)searchUserInfo:(NSString *)userName secret:(NSString *)passWord
{
    BmobQuery *bmobQuery = [[BmobQuery alloc] init];
    NSString *bql = @"select * from userInfo where userName = ? and passWord = ?";
    NSArray *placeholderArray = @[userName, passWord];
    [bmobQuery queryInBackgroundWithBQL:bql pvalues:placeholderArray block:^(BQLQueryResult *result, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            if (result) {
                NSLog(@"%@",result.resultsAry);
                _userDic = [[NSDictionary alloc] init];
                logInViewController *logIn = [[logInViewController alloc] init];
                self.delegate = logIn;
                if([result.resultsAry count] == 0)
                {
                    [self.delegate passDicValue:_userDic];
                }else{
                    
                    BmobObject *obj = [result.resultsAry objectAtIndex:0];
                    _userDic = (NSDictionary *)obj;
                    [self.delegate passDicValue:_userDic];
                }
            }
        }
    }];
}


//构造文件路径上传文件（图片）
-(void)uploadFileBatchByPathBtn{
        //构造上传文件路径数组
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle bundlePath];
    NSString *path1 = [path stringByAppendingPathComponent:@"pic1.jpg"];
//    NSString *path2 = [path stringByAppendingPathComponent:@"zipfile.zip"];
//    NSString *path3 = [path stringByAppendingPathComponent:@"text.txt"];
//   NSArray *array = @[path1,path2,path3];
    NSArray *array = @[path1];
    //上传文件
    [BmobProFile uploadFilesWithPaths:array resultBlock:^(NSArray *pathArray, NSArray *urlArray, NSArray *bmobFileArray,NSError *error) {
    //路径数组和url数组（url数组里面的元素为NSString）
        NSLog(@"urlArray %@ urlArray %@",pathArray,urlArray);
        for (BmobFile* bmobFile in bmobFileArray ) {
        NSLog(@"%@",bmobFile);
        }
        } progress:^(NSUInteger index, CGFloat progress) {
                    //index表示正在上传的文件其路径在数组当中的索引，progress表示该文件的上传进度
                   NSLog(@"index %lu progress %f",(unsigned long)index,progress);
                }];
    }


//构造NSData上传图片
- (void)uploadFileBatchByNSDataBtn:(NSMutableArray *)mutableArrayPhoto{
    //构造上传文件data字典数组
    NSMutableArray *mutableArrDic = [[NSMutableArray alloc] init];
    for(int i = 0; i < [mutableArrayPhoto count]; i++)
    {
        NSString *str = [NSString stringWithFormat:@"image%d.png", i];
        NSData *dataPhoto = UIImagePNGRepresentation(mutableArrayPhoto[i]);
        NSDictionary *dicPhoto = [[NSDictionary alloc] initWithObjectsAndKeys:str, @"filename", dataPhoto, @"data", nil];
        [mutableArrDic addObject:dicPhoto];
    }
    NSArray *array = (NSArray *)mutableArrDic;
    //上传文件，dataArray 数组中存放NSDictionary，NSDictionary里面的格式为@{@"filename":@"你的文件名",@"data":文件的data}
    [BmobProFile uploadFilesWithDatas:array resultBlock:^(NSArray *filenameArray, NSArray *urlArray,NSArray *bmobFileArray, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            //路径数组和url数组（url数组里面的元素为NSString）
            NSLog(@"fileArray %@ urlArray %@",filenameArray,urlArray);
            for (BmobFile* bmobFile in bmobFileArray ) {
                NSLog(@"%@",bmobFile);
            }
        }
    } progress:^(NSUInteger index, CGFloat progress) {
        //index表示正在上传的文件其路径在数组当中的索引，progress表示该文件的上传进度
        NSLog(@"index %lu progress %f",(unsigned long)index,progress);
    }];
}

@end
