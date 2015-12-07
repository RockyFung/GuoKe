//
//  MyController.m
//  果壳精选
//
//  Created by lanou on 15/12/7.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "MyController.h"
#import <BmobSDK/Bmob.h>
#import "Define.h"
#import "DIYButton.h"
#import "ChangePWController.h"
#import "JCAlertView.h"


@interface MyController ()

@property (nonatomic, strong) UIImageView *icon; // 个人头像
@property (nonatomic, strong) UILabel *userLabel; // 用户名
@property (nonatomic, strong) UIButton *quiteBtn; // 注销
@property (nonatomic, strong) UILabel *emailLabel; // 显示用户邮箱
@property (nonatomic, strong) BmobUser *user; // 用户的信息
@property (nonatomic, strong) UIButton *changePW;
@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人中心";
//    self.navigationController.navigationBar.translucent = NO;
    
    
    // 获取用户信息
    self.user = [BmobUser getCurrentUser];
    
    // 个人头像
    self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth / 3, KScreenWidth / 10, KScreenWidth / 3, KScreenWidth / 3)];
    self.icon.layer.cornerRadius = KScreenWidth / 6;
    self.icon.layer.masksToBounds = YES;
//    self.icon.backgroundColor = [UIColor blackColor];
    self.icon.image = [UIImage imageNamed:@"touxiang"];
    // 头像添加点击事件
    //    self.icon.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //    [self.icon addGestureRecognizer:tap];
    [self.view addSubview:_icon];
    
    // 用户名
    self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, KScreenWidth / 2, KScreenWidth, KScreenWidth / 12)];
    self.userLabel.text = [NSString stringWithFormat:@"%@,您好!",_user.username];
    self.userLabel.font = [UIFont systemFontOfSize:20];
    self.userLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_userLabel];
    
    // 显示邮箱
    //    if (self.user.email != nil) {
//    UILabel *youxiang = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth / 4, KScreenHeight /2.8, KScreenWidth / 1.5, KScreenWidth / 10)];
//    youxiang.text = @"邮箱:";
//    [self.view addSubview:youxiang];
    
    self.emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, KScreenHeight /2.8, KScreenWidth , KScreenWidth / 10)];
    self.emailLabel.textAlignment = NSTextAlignmentCenter;
    NSString *emailStr = [self.user objectForKey:@"email"];
    
    // 邮箱显示格式
    NSString *linkStr = [emailStr componentsSeparatedByString:@"@"].firstObject;
    if (linkStr.length > 4) {
        linkStr = [linkStr stringByReplacingOccurrencesOfString:[linkStr substringFromIndex:4] withString:@"***"];
    }
    NSString *houStr = [emailStr componentsSeparatedByString:@"@"].lastObject;
    self.emailLabel.text = [NSString stringWithFormat:@"邮箱: %@@%@",linkStr,houStr];
    [self.view addSubview:_emailLabel];
    //     }
    // 是否验证
    DIYButton *isVerfied = [DIYButton buttonWithType:UIButtonTypeCustom];
    isVerfied.frame = CGRectMake(KScreenWidth / 4, KScreenHeight / 2.3, KScreenWidth / 1.5, KScreenWidth / 15);
    if ([_user objectForKey:@"emailVerified"]) {
        isVerfied.iconImageView.image = [UIImage imageNamed:@"dui"];
        isVerfied.textLabel.text = @"邮箱已验证";
    }else{
        isVerfied.iconImageView.image = [UIImage imageNamed:@"cuo"];
        isVerfied.textLabel.text = @"未验证邮箱";
        
    }
    isVerfied.textLabel.font = [UIFont systemFontOfSize:14];
    isVerfied.textLabel.textColor = [UIColor grayColor];
    [self.view addSubview:isVerfied];
    
    // 通过邮箱重置密码
    self.changePW = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changePW.frame = CGRectMake(KScreenWidth / 4,  KScreenHeight / 2, KScreenWidth / 2, KScreenWidth / 10);
    [self.changePW setTitle:@"修改密码" forState:UIControlStateNormal];
    self.changePW.backgroundColor = [UIColor blackColor];
    [self.changePW addTarget:self action:@selector(changePW:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changePW];
    
    // 注销
    self.quiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quiteBtn.frame = CGRectMake(KScreenWidth / 4,  KScreenHeight / 1.7, KScreenWidth / 2, KScreenWidth / 10);
    [self.quiteBtn setTitle:@"注   销" forState:UIControlStateNormal];
    self.quiteBtn.backgroundColor = [UIColor redColor];
    [self.quiteBtn addTarget:self action:@selector(quiteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_quiteBtn];
    

}

// 密码找回
- (void)changePW:(UIButton *)btn
{
    ChangePWController *ChangePWVc = [[ChangePWController alloc]init];
    [self presentViewController:ChangePWVc animated:YES completion:nil];
}


// 注销执行的方法
- (void)quiteBtn:(UIButton *)btn
{
    
    // 警告框
    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"是否注销！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"已注销");
        [BmobUser logout];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
//    [JCAlertView showTwoButtonsWithTitle:@"是否注销 !" Message:nil ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:nil ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"注销" Click:^{
//        NSLog(@"已注销");
//        [BmobUser logout];
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
    
    
}

@end
