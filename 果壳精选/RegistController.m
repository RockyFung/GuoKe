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
#import <BmobSDK/Bmob.h>
#import "JCAlertView.h"

@interface RegistController ()
@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *againPW;
@property (nonatomic, strong) UITextField *email;
@property (nonatomic, strong) UIButton *OK;
@property (nonatomic, strong) UIButton *cancel;

@end

@implementation RegistController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat w = KScreenWidth / 12.5;
    
    // 用户名
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 7, KScreenWidth / 4.5 , w)];
    userLabel.text = @"用户名:";
    userLabel.textAlignment = NSTextAlignmentRight;
    userLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8  weight:20];
    [self.view addSubview:userLabel];
    
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 7, KScreenWidth / 1.5, w)];
    self.userName.placeholder = @"请输入账号";
    //    self.userName.backgroundColor = [UIColor grayColor];
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_userName];
    
    
    
    // 密码
    UILabel *pwLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 4.5, KScreenWidth / 4.5 , w)];
    pwLabel.text = @"密 码:";
    pwLabel.textAlignment = NSTextAlignmentRight;
    pwLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8  weight:KScreenWidth / 18.75];
    [self.view addSubview:pwLabel];
    
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 4.5, KScreenWidth / 1.5, w)];
    self.password.placeholder = @"请输入密码";
    //    self.password.backgroundColor = [UIColor grayColor];
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.secureTextEntry = YES;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_password];
    
    // 密码确认
    UILabel *againPWLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 3.2, KScreenWidth / 4.5 , w)];
    againPWLabel.text = @"确认密码:";
    againPWLabel.textAlignment = NSTextAlignmentRight;
    againPWLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8  weight:KScreenWidth / 18.75];
    [self.view addSubview:againPWLabel];
    
    self.againPW = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 3.2, KScreenWidth / 1.5, w)];
    self.againPW.placeholder = @"请再次输入密码";
    self.againPW.borderStyle = UITextBorderStyleRoundedRect;
    self.againPW.secureTextEntry = YES;
    self.againPW.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_againPW];
    
    
    // 邮箱
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 2.5, KScreenWidth / 4.5 , w)];
    emailLabel.text = @"邮箱:";
    emailLabel.textAlignment = NSTextAlignmentRight;
    emailLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8  weight:KScreenWidth / 18.75];
    [self.view addSubview:emailLabel];
    
    self.email = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 2.5, KScreenWidth / 1.5, w)];
    self.email.placeholder = @"请输入邮箱";
    self.email.borderStyle = UITextBorderStyleRoundedRect;
    self.email.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_email];


    
    // 确认
    self.OK = [UIButton buttonWithType:UIButtonTypeCustom];
    self.OK.frame = CGRectMake(KScreenWidth / 4, KScreenHeight / 2, KScreenWidth / 5, w);
    self.OK.backgroundColor = [UIColor grayColor];
    [self.OK setTitle:@"确 认" forState:UIControlStateNormal];
    [self.OK addTarget:self action:@selector(OKAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_OK];
    
    // 取消
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancel.frame = CGRectMake(KScreenWidth / 1.8, KScreenHeight / 2, KScreenWidth / 5, w);
    self.cancel.backgroundColor = [UIColor grayColor];
    [self.cancel setTitle:@"取 消" forState:UIControlStateNormal];
    [self.cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancel];
    
    
}

// 确认
- (void)OKAction:(UIButton *)btn
{
    BmobUser *user = [[BmobUser alloc]init];
    [user setUsername:self.userName.text]; // 用户名
    [user setPassword:self.password.text]; // 密码
    [user setEmail:self.email.text]; // 邮箱
    
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            [JCAlertView showOneButtonWithTitle:@"恭喜你！" Message:@"注册成功！"  ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"确认" Click:^{
                [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"queren ");
            }];
        }else{
            [JCAlertView showOneButtonWithTitle:@"注册失败！" Message:[NSString stringWithFormat:@"%@",error] ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"确认" Click:nil];
        }
        
    }];
}

// 取消
- (void)cancelAction:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}







@end
