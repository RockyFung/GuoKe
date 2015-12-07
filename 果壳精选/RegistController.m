//
//  RegistController.m
//  果壳精选
//
//  Created by lanou on 15/12/6.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "RegistController.h"
#import "Define.h"
#import "UIViewController+MMDrawerController.h"

@interface RegistController ()
@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *againPW;
@property (nonatomic, strong) UITextField *email;
@property (nonatomic, strong) UIButton *OK;

@end

@implementation RegistController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 用户名
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 15, KScreenWidth / 4.5 , 30)];
    userLabel.text = @"用户名:";
    userLabel.textAlignment = NSTextAlignmentRight;
    userLabel.font = [UIFont systemFontOfSize:18 weight:20];
    [self.view addSubview:userLabel];
    
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 15, KScreenWidth / 1.5, 30)];
    self.userName.placeholder = @"请输入账号";
    //    self.userName.backgroundColor = [UIColor grayColor];
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_userName];
    
    
    
    // 密码
    UILabel *pwLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 7, KScreenWidth / 4.5 , 30)];
    pwLabel.text = @"密 码:";
    pwLabel.textAlignment = NSTextAlignmentRight;
    pwLabel.font = [UIFont systemFontOfSize:18 weight:20];
    [self.view addSubview:pwLabel];
    
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 7, KScreenWidth / 1.5, 30)];
    self.password.placeholder = @"请输入密码";
    //    self.password.backgroundColor = [UIColor grayColor];
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.secureTextEntry = YES;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_password];
    
    // 密码确认
    UILabel *againPWLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 4.5, KScreenWidth / 4.5 , 30)];
    againPWLabel.text = @"确认密码:";
    againPWLabel.textAlignment = NSTextAlignmentRight;
    againPWLabel.font = [UIFont systemFontOfSize:18 weight:20];
    [self.view addSubview:againPWLabel];
    
    self.againPW = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 4.5, KScreenWidth / 1.5, 30)];
    self.againPW.placeholder = @"请再次输入密码";
    self.againPW.borderStyle = UITextBorderStyleRoundedRect;
    self.againPW.secureTextEntry = YES;
    self.againPW.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_againPW];
    
    
    // 邮箱
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 3.2, KScreenWidth / 4.5 , 30)];
    emailLabel.text = @"邮箱:";
    emailLabel.textAlignment = NSTextAlignmentRight;
    emailLabel.font = [UIFont systemFontOfSize:18 weight:20];
    [self.view addSubview:emailLabel];
    
    self.email = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 3.2, KScreenWidth / 1.5, 30)];
    self.email.placeholder = @"请输入邮箱";
    self.email.borderStyle = UITextBorderStyleRoundedRect;
    self.email.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_email];


    
    // 确认
    // 登录按钮
    self.OK = [UIButton buttonWithType:UIButtonTypeCustom];
    self.OK.frame = CGRectMake((KScreenWidth - KScreenWidth / 5) / 2, KScreenHeight / 2.4, KScreenWidth / 5, 30);
    self.OK.backgroundColor = [UIColor grayColor];
    [self.OK setTitle:@"确 认" forState:UIControlStateNormal];
    [self.OK addTarget:self action:@selector(OKAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_OK];
    
    
    
    // 关闭左右滑动功能
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
}

- (void)OKAction:(UIButton *)btn
{
    
}



@end
