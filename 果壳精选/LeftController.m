//
//  LeftController.m
//  果壳精选
//
//  Created by lanou on 15/12/1.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "LeftController.h"
#import "MMDrawerController.h"
#import "CollectController.h"
#import "UIViewController+MMDrawerController.h"
#import "BestController.h"
#import "Define.h"
#import "LoginController.h"
#import <BmobSDK/Bmob.h>
#import "JCAlertView.h"

@interface LeftController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth / 2.5, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"首页";
            break;
        case 1:
            cell.textLabel.text = @"我的收藏";
            break;
        case 2:
            cell.textLabel.text = @"设置";
            break;
     
        default:
            break;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
           [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil]; // 点击关闭
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeToBest" object:nil];
             [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changToBest" object:nil];
            break;
            }
        case 1:{
  
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeToCollect" object:nil];
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil]; // 点击关闭
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changToCollect" object:nil];
            break;
        }
        case 2:{
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeToSetting" object:nil];
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil]; // 点击关闭
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changToSetting" object:nil];
            break;
        }
        default:
            break;
    }
}






@end
