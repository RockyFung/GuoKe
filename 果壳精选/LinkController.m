
//
//  LinkController.m
//  果壳精选
//
//  Created by lanou on 15/12/4.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "LinkController.h"
#import "Define.h"


@interface LinkController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView; // 网页显示

@end

@implementation LinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    //添加网络视图
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64)];
    // 自动对页面进行缩放以适应屏幕
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.gapBetweenPages = 100;
    NSURL *targetUrl = [NSURL URLWithString:self.link];
    [self.webView loadRequest:[NSURLRequest requestWithURL:targetUrl]];
    [self.view addSubview:_webView];
    
    
    // 添加底部工具栏
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0 , KScreenHeight - 49, KScreenWidth, 49)];
    [self.view addSubview:toolBar];
    
    
    // 底部工具栏添加button
    // 返回
    
    
}





@end
