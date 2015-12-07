//
//  FindPWController.m
//  果壳精选
//
//  Created by lanou on 15/12/6.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "FindPWController.h"
#import "Define.h"
#import "UIViewController+MMDrawerController.h"


@interface FindPWController ()

@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UITextField *emailText;
@property (nonatomic, strong) UIButton *send;

@end

@implementation FindPWController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 信息
    self.info = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenHeight / 5, KScreenWidth - 20, 80)];
    self.info.numberOfLines = 0;
    self.info.text = @"请输入您的邮箱, 我们将会发送邮件到您的邮箱, 请注意查收!";
    [self.view addSubview:_info];
    
    // 填邮箱
    self.emailText = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 6, KScreenHeight / 7, KScreenWidth / 1.5, KScreenWidth / 10)];
    self.emailText.placeholder = @"请输入邮箱";
    self.emailText.textAlignment = NSTextAlignmentCenter;
    self.emailText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_emailText];
    
    // 发送按钮
    self.send = [UIButton buttonWithType:UIButtonTypeCustom];
    self.send.frame = CGRectMake(KScreenWidth / 4, KScreenHeight / 3, KScreenWidth/2, KScreenWidth / 10);
    self.send.backgroundColor = [UIColor grayColor];
    [self.send addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.send setTitle:@"确认发送" forState:UIControlStateNormal];
    [self.view addSubview:_send];

    
    // 关闭左右滑动功能
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
}

/*
- (void)sendAction:(UIButton *)btn
{
    [BmobUser requestPasswordResetInBackgroundWithEmail:self.emailText.text];
    
    BmobUser *user = [BmobUser getCurrentUser];
    if (user.email == self.emailText.text) {
        // 警告框
        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"已发送到您的邮箱!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        // 警告框
        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"发送失败!" message:@"与注册时候的邮箱不匹配！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

*/


















@end
