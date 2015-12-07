//
//  ChangePWController.m
//  果壳精选
//
//  Created by lanou on 15/12/7.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "ChangePWController.h"
#import <BmobSDK/Bmob.h>
#import "Define.h"
#import "JCAlertView.h"


@interface ChangePWController ()
@property (nonatomic, strong) UITextField *oldPW;
@property (nonatomic, strong) UITextField *nowPW;
@property (nonatomic, strong) UITextField *againPW;
@property (nonatomic, strong) UIButton *OK;
@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) JCAlertView *alertView;
@end

@implementation ChangePWController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat w = KScreenWidth / 12.5; // 30
    
    // 用户名
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 7, KScreenWidth / 4.5 , w)];
    userLabel.text = @"旧密码:";
    userLabel.textAlignment = NSTextAlignmentRight;
    userLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8 weight:KScreenWidth / 18.75];
    [self.view addSubview:userLabel];
    
    self.oldPW = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 7, KScreenWidth / 1.5, w)];
    self.oldPW.placeholder = @"请输入旧密码";
    //    self.userName.backgroundColor = [UIColor grayColor];
    self.oldPW.borderStyle = UITextBorderStyleRoundedRect;
    self.oldPW.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_oldPW];
    
    
    
    // 密码
    UILabel *pwLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 4.5, KScreenWidth / 4.5 , w)];
    pwLabel.text = @"密 码:";
    pwLabel.textAlignment = NSTextAlignmentRight;
    pwLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8 weight:KScreenWidth / 18.75];
    [self.view addSubview:pwLabel];
    
    self.nowPW = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 4.5, KScreenWidth / 1.5, w)];
    self.nowPW.placeholder = @"请输入密码";
    //    self.password.backgroundColor = [UIColor grayColor];
    self.nowPW.borderStyle = UITextBorderStyleRoundedRect;
    self.nowPW.secureTextEntry = YES;
    self.nowPW.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_nowPW];
    
    // 密码确认
    UILabel *againPWLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 3.2, KScreenWidth / 4.5 , w)];
    againPWLabel.text = @"确认密码:";
    againPWLabel.textAlignment = NSTextAlignmentRight;
    againPWLabel.font = [UIFont systemFontOfSize:KScreenWidth / 20.8 weight:KScreenWidth / 18.75];
    [self.view addSubview:againPWLabel];
    
    self.againPW = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3.5 , KScreenHeight / 3.2, KScreenWidth / 1.5, w)];
    self.againPW.placeholder = @"请再次输入密码";
    self.againPW.borderStyle = UITextBorderStyleRoundedRect;
    self.againPW.secureTextEntry = YES;
    self.againPW.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_againPW];

    
 
    
    // 确认
    self.OK = [UIButton buttonWithType:UIButtonTypeCustom];
    self.OK.frame = CGRectMake(KScreenWidth / 4, KScreenHeight / 2.5, KScreenWidth / 5, w);
    self.OK.backgroundColor = [UIColor grayColor];
    [self.OK setTitle:@"确 认" forState:UIControlStateNormal];
    [self.OK addTarget:self action:@selector(OKAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_OK];
    
    // 取消
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancel.frame = CGRectMake(KScreenWidth / 1.8, KScreenHeight / 2.5, KScreenWidth / 5, w);
    self.cancel.backgroundColor = [UIColor grayColor];
    [self.cancel setTitle:@"取 消" forState:UIControlStateNormal];
    [self.cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancel];
    

}

// 确认
- (void)OKAction
{
    BmobUser *user = [BmobUser getCurrentUser];
    [user updateCurrentUserPasswordWithOldPassword:self.oldPW.text newPassword:self.nowPW.text block:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            // 密码修改成功
            [BmobUser logout];
            // 自定义弹出窗口
            UIToolbar *view = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth / 1.87, KScreenWidth / 3)];
            view.layer.cornerRadius = 10;
            view.layer.masksToBounds = YES;
            UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0, KScreenWidth / 9.37, KScreenWidth /1.87, KScreenWidth / 9.37)];
            label.text = @"密码修改成功 !";
            label.font = [UIFont systemFontOfSize:KScreenWidth / 18.75 weight:KScreenWidth / 18.75];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            self.alertView = [[JCAlertView alloc] initWithCustomView:view dismissWhenTouchedBackground:NO];
            [self.alertView show];
            
            // 添加延时执行方法
            [self performSelector:@selector(dismissAction) withObject:nil afterDelay:1.5];

        }else{
            
            // 登陆失败
            [JCAlertView  showOneButtonWithTitle:@"⚠️密码修改失败!" Message:[NSString stringWithFormat:@"%@",error] ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"确定" Click:nil];
        }
    }];
}

// 延时执行方法
- (void)dismissAction
{
    [self.alertView dismissWithCompletion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


// 取消
- (void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
