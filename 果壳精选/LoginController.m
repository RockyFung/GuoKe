//
//  LoginController.m
//  果壳精选
//
//  Created by lanou on 15/12/6.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "LoginController.h"
#import "Define.h"
#import "RegistController.h"
#import "FindPWController.h"
#import "UIViewController+MMDrawerController.h"
#import <BmobSDK/Bmob.h>
#import "JCAlertView.h"

@interface LoginController ()

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UIButton *findPW;
@property (nonatomic, strong) JCAlertView *alertView;

@end

@implementation LoginController

- (void)viewWillDisappear:(BOOL)animated
{
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat w = KScreenWidth / 12.5;
    
    // 用户名
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 15, KScreenWidth / 5 , w)];
    userLabel.text = @"用户名:";
    userLabel.textAlignment = NSTextAlignmentRight;
    userLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8 weight:KScreenWidth / 18.75];
    [self.view addSubview:userLabel];
    
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 4 , KScreenHeight / 15, KScreenWidth / 1.5, w)];
    self.userName.placeholder = @"请输入账号";
//    self.userName.backgroundColor = [UIColor grayColor];
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_userName];
    
    
    
    // 密码
    UILabel *pwLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 7, KScreenWidth / 5 , w)];
    pwLabel.text = @"密 码:";
    pwLabel.textAlignment = NSTextAlignmentRight;
    pwLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8 weight:KScreenWidth / 18.75];
    [self.view addSubview:pwLabel];
    
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 4 , KScreenHeight / 7, KScreenWidth / 1.5, w)];
    self.password.placeholder = @"请输入密码";
//    self.password.backgroundColor = [UIColor grayColor];
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.secureTextEntry = YES;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_password];
    
    
    // 登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(KScreenWidth / 4, KScreenHeight / 4, KScreenWidth / 5, w);
    self.loginBtn.backgroundColor = [UIColor grayColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    
    // 注册按钮
    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registBtn.frame = CGRectMake(KScreenWidth / 1.8, KScreenHeight / 4, KScreenWidth / 5, w);
    self.registBtn.backgroundColor = [UIColor grayColor];
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
    
    
    // 忘记密码
    self.findPW = [UIButton buttonWithType:UIButtonTypeCustom];
    self.findPW.frame = CGRectMake(0, KScreenHeight / 3, KScreenWidth, w);
    [self.findPW setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.findPW setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.findPW addTarget:self action:@selector(findPWAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_findPW];
    
    
     [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
}


#pragma mark - 按键方法
// 登录
- (void)loginAction:(UIButton *)btn
{
    // 登陆信息
    [BmobUser loginWithUsernameInBackground:self.userName.text password:self.password.text block:^(BmobUser *user, NSError *error) {
        if(error){
            // 登陆失败
            [JCAlertView showTwoButtonsWithTitle:@"登陆失败!" Message:[NSString stringWithFormat:@"%@",error] ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:nil ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"去注册" Click:^{
                // 跳到注册页面
                RegistController *registVc = [[RegistController alloc]init];
                [self presentViewController:registVc animated:YES completion:nil];
                
            }];
            
        }else{
            
            // 自定义弹出窗口
            UIToolbar *view = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth / 1.87, KScreenWidth / 3)];
            view.layer.cornerRadius = 10;
            view.layer.masksToBounds = YES;
            UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0, KScreenWidth / 9.37, KScreenWidth /1.87, KScreenWidth / 9.37)];
            label.text = @"登陆成功 !";
            label.font = [UIFont systemFontOfSize:KScreenWidth / 16 weight:KScreenWidth / 16];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            self.alertView = [[JCAlertView alloc] initWithCustomView:view dismissWhenTouchedBackground:NO];
            [self.alertView show];
            
            // 添加延时执行方法
            [self performSelector:@selector(dismissAction) withObject:nil afterDelay:1.5];
        }
        
    }];
}

// 注册
- (void)registAction:(UIButton *)btn
{
    RegistController *registVc = [[RegistController alloc]init];
    [self presentViewController:registVc animated:YES completion:nil];
}

// 密码找回
- (void)findPWAction:(UIButton *)btn
{
    FindPWController *findPWVc = [[FindPWController alloc]init];
    [self presentViewController:findPWVc animated:YES completion:nil];
}

// 延时执行方法
- (void)dismissAction
{
    [self.alertView dismissWithCompletion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
