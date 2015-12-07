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


@interface LoginController ()

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UIButton *findPW;


@end

@implementation LoginController
- (void)viewWillDisappear:(BOOL)animated
{
    // 页面即将消失的时候让页面可以滑动
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 用户名
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 15, KScreenWidth / 5 , 30)];
    userLabel.text = @"用户名:";
    userLabel.textAlignment = NSTextAlignmentRight;
    userLabel.font = [UIFont systemFontOfSize:18 weight:20];
    [self.view addSubview:userLabel];
    
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 4 , KScreenHeight / 15, KScreenWidth / 1.5, 30)];
    self.userName.placeholder = @"请输入账号";
//    self.userName.backgroundColor = [UIColor grayColor];
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_userName];
    
    
    
    // 密码
    UILabel *pwLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 7, KScreenWidth / 5 , 30)];
    pwLabel.text = @"密 码:";
    pwLabel.textAlignment = NSTextAlignmentRight;
    pwLabel.font = [UIFont systemFontOfSize:18 weight:20];
    [self.view addSubview:pwLabel];
    
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 4 , KScreenHeight / 7, KScreenWidth / 1.5, 30)];
    self.password.placeholder = @"请输入密码";
//    self.password.backgroundColor = [UIColor grayColor];
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.secureTextEntry = YES;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_password];
    
    
    // 登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(KScreenWidth / 4, KScreenHeight / 4, KScreenWidth / 5, 30);
    self.loginBtn.backgroundColor = [UIColor grayColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    
    // 注册按钮
    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registBtn.frame = CGRectMake(KScreenWidth / 1.8, KScreenHeight / 4, KScreenWidth / 5, 30);
    self.registBtn.backgroundColor = [UIColor grayColor];
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
    
    
    // 忘记密码
    self.findPW = [UIButton buttonWithType:UIButtonTypeCustom];
    self.findPW.frame = CGRectMake(0, KScreenHeight / 3, KScreenWidth, 30);
    [self.findPW setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.findPW setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.findPW addTarget:self action:@selector(findPWAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_findPW];
    
    
    
    // 关闭左右滑动功能
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

    
}


#pragma mark - 按键方法
// 登录
- (void)loginAction:(UIButton *)btn
{
    
}

// 注册
- (void)registAction:(UIButton *)btn
{
    RegistController *registVc = [[RegistController alloc]init];
    [self.navigationController pushViewController:registVc animated:YES];
}

// 密码找回
- (void)findPWAction:(UIButton *)btn
{
    FindPWController *findPWVc = [[FindPWController alloc]init];
    [self.navigationController pushViewController:findPWVc animated:YES];
}



@end
