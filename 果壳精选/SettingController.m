//
//  SettingController.m
//  果壳精选
//
//  Created by lanou on 15/12/1.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "SettingController.h"
#import "LoginController.h"
#import "UIViewController+MMDrawerController.h"
#import <BmobSDK/Bmob.h>
#import "MyController.h"
#import "UIImageView+WebCache.h"


@interface SettingController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BmobUser *user;
@property (nonatomic, assign) double size; // 缓存大小
@property (nonatomic, strong) NSString *path; // 缓存位置


@end

@implementation SettingController

- (void)viewWillAppear:(BOOL)animated
{
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    self.user = [BmobUser getCurrentUser];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - TableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    
    if(indexPath.row == 0 ){
        if(self.user){
            cell.textLabel.text = [NSString stringWithFormat:@"%@,您好! ",_user.username];
        }else{
            cell.textLabel.text = @"点击登录";
        }
        
    }else if(indexPath.row == 1 ){
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存    %@",[self fileSize]];
    }else if(indexPath.row == 2){
        NSString *version = [NSString stringWithFormat:@"版本号   %@ V",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        cell.textLabel.text = version;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 ){
        if(self.user){
            MyController *myVc = [[MyController alloc]init];
            [self.navigationController pushViewController:myVc animated:YES];
        }else{
            LoginController *loginVc = [[LoginController alloc]init];
            [self.navigationController pushViewController:loginVc animated:YES];
        }
    }else if(indexPath.row == 1){
      
        [self clearDisk];
    }
}


#pragma mark - 计算缓存大小
- (NSString *)fileSize
{
    NSString *cacheSize = nil;
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    // 缓存大小持久化
    cacheSize = [NSString stringWithFormat:@"%.2f MB", (float)size / 1000 / 1000];
    return cacheSize;
}

#pragma mark - 清除缓存
- (void)clearDisk
{
    [[SDImageCache sharedImageCache] clearDisk];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}



@end
