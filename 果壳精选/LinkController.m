
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
    [self.webView canGoBack];
    [self.webView canGoForward];
    
    NSURL *targetUrl = [NSURL URLWithString:self.link];
    [self.webView loadRequest:[NSURLRequest requestWithURL:targetUrl]];
    [self.view addSubview:_webView];
    
    
    // 添加底部工具栏
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0 , KScreenHeight - 49, KScreenWidth, 49)];
    [self.view addSubview:toolBar];
    
    
    // 底部工具栏添加button
    // 返回
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(30, 10, 30, 30);
    [back setImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:back];
    
    // 下一页
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    next.frame = CGRectMake(KScreenWidth - 30 - 30, 10, 30, 30);
    [next setImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:next];
    
    // 刷新
    UIButton *refresh = [UIButton buttonWithType:UIButtonTypeCustom];
    refresh.frame = CGRectMake(KScreenWidth / 2 - 15, 10, 30, 30);
    [refresh setImage:[UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:refresh];
    
    
}

#pragma mark - 按键方法实现
- (void)backAction
{
    [self.webView goBack];
}

- (void)nextAction
{
    [self.webView goForward];
}

- (void)refreshAction
{
    [self.webView reload];
}



@end
