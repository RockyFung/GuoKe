//
//  CenterController.m
//  果壳精选
//
//  Created by lanou on 15/12/4.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "CenterController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "BestController.h"
#import "CollectController.h"
#import "SettingController.h"

@interface CenterController ()

@property (nonatomic, strong) BestController *bestVc;
@property (nonatomic, strong) CollectController *collectVc;
@property (nonatomic, strong) SettingController *settingVc;

@end

@implementation CenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"精 选";
    
    
    [self setupLeftButton];
    
    // 添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSelf:) name:@"changeToCollect" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSelf:) name:@"changeToBest" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSelf:) name:@"changeToSetting" object:nil];
    
    // 添加精选页面
    self.bestVc = [[BestController alloc]init];
    [self.view addSubview:_bestVc.view];
    [self addChildViewController:_bestVc];
    
    
    
}

#pragma mark - 定义左边按钮
- (void)setupLeftButton
{
    MMDrawerBarButtonItem *leftButton = [[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(leftAction) withTitle:nil];
    [leftButton setMenuButtonColor:[UIColor blackColor] forState:UIControlStateNormal]; // button颜色
    [leftButton setMenuButtonColor:[UIColor grayColor] forState:UIControlStateHighlighted]; // 点击颜色
    [self.navigationItem setLeftBarButtonItem:leftButton animated:YES];
}

// 左边按钮方法
- (void)leftAction
{
    // 左边视图出现
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


// 切换页面方法
- (void)changeSelf:(NSNotification *)notification
{
//////// 精选页面
    if([notification.name isEqualToString:@"changeToBest"]){
               NSLog(@"进入best");
        self.navigationItem.title = @"精 选";
        // 移除收藏页面
        [self removeCollectVc];
        // 移除设置页面
        [self removeSettingVc];

    }
//////// 收藏页面
    else if ([notification.name isEqualToString:@"changeToCollect"]){
                NSLog(@"进入collect");
        self.navigationItem.title = @"我的收藏";
        // 移除设置页面
        [self removeSettingVc];
      // 添加收藏页面
        [self addCollectVc];
    
    }
///////// 设置页面
    else if([notification.name isEqualToString:@"changeToSetting"]){
        NSLog(@"进入Setting");
        self.navigationItem.title = @"设 置";
        // 移除收藏页面
        [self removeCollectVc];
        // 添加设置页面
        [self addSettingVc];
        
    }
}


#pragma mark - 添加删除页面
// 添加设置页面
- (void)addSettingVc
{
    if(!self.settingVc){ // 保证添加一次
        self.settingVc = [[SettingController alloc]init];
        [self.view addSubview:_settingVc.view];
        [self addChildViewController:_settingVc];
        NSLog(@"添加设置页面");
    }

}

// 移除设置页面
- (void)removeSettingVc
{
    [self.settingVc removeFromParentViewController];
    [self.settingVc.view removeFromSuperview];
    self.settingVc = nil; // 置空

}

// 添加收藏页面
- (void)addCollectVc
{
    if(!self.collectVc){ // 保证只添加一次
        self.collectVc = [[CollectController alloc]init];
        [self.view addSubview: _collectVc.tableView];
        [self addChildViewController:_collectVc];
        NSLog(@"添加收藏页面");
    }
}

// 移除收藏页面
- (void)removeCollectVc
{
    [self.collectVc removeFromParentViewController];
    [self.collectVc.tableView removeFromSuperview];
     self.collectVc = nil; // 置空
}



@end
