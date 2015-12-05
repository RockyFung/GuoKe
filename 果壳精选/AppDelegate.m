//
//  AppDelegate.m
//  果壳精选
//
//  Created by lanou on 15/12/1.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "AppDelegate.h"
#import "BestController.h"
#import "LeftController.h"
#import "MMDrawerController.h"
#import "CenterController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 精选视图
    CenterController *centerVc = [[CenterController alloc]init];
    UINavigationController *centerNav = [[UINavigationController alloc]initWithRootViewController:centerVc];
    
    // 左边视图
    LeftController *leftVc = [[LeftController alloc]init];
    
    // 抽屉效果
    MMDrawerController *MMDrawerViewVc = [[MMDrawerController alloc]initWithCenterViewController:centerNav leftDrawerViewController:leftVc];
    [MMDrawerViewVc setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [MMDrawerViewVc setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    // 设置左边抽屉宽度
    MMDrawerViewVc.maximumLeftDrawerWidth = 150;
    
    self.window.rootViewController = MMDrawerViewVc;

    // 初始化友盟分享
//    [UMSocialData setAppKey:@"5662812967e58e2991005b9f"];
//    [UMSocialConfig hiddenNotInstallPlatforms:nil];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
