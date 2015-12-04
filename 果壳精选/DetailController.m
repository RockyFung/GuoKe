//
//  DetailController.m
//  果壳精选
//
//  Created by lanou on 15/12/2.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "DetailController.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "LinkController.h"

@interface DetailController () < UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIImageView *topView;
@property (nonatomic, strong) UIWebView *webView; // 网页显示
@end

const CGFloat TopViewH = 168; // 图片的高度

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加表头
    self.topView = [[UIImageView alloc] init];
    [self.topView sd_setImageWithURL:[NSURL URLWithString:self.model.headline_img] placeholderImage:[UIImage imageNamed:@"hoderPic"]];
    self.topView.frame = CGRectMake(0, -TopViewH, KScreenWidth, TopViewH);
    self.topView.contentMode = UIViewContentModeScaleAspectFill;

    
    //添加网络视图
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    // 自动对页面进行缩放以适应屏幕
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.gapBetweenPages = 100;
    NSURL *targetUrl = [NSURL URLWithString:self.model.link_v2];
    [self.webView loadRequest:[NSURLRequest requestWithURL:targetUrl]];

    
    [self.webView.scrollView addSubview:_topView];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(TopViewH+20, 0, 0, 0);
    [self.view addSubview:_webView];

    
}




- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL);
    if (navigationType == 0) {
        
        
        // 警告框
        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"即将跳转到其他网页！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *goToRegist = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 跳转到链接
            LinkController *linkVc = [[LinkController alloc]init];
            linkVc.link = request.URL.absoluteString;
            [self.navigationController pushViewController:linkVc animated:YES];

        }];
        [alertController addAction:goToRegist];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat down = - (TopViewH * 1) - scrollView.contentOffset.y;
    if (down < 0) {
        return;
    }
    CGRect frame = self.topView.frame;
    // topview放大，位置也往下
    //    frame.size.height = TopViewH + down * 5;// 系数 5 决定速度
    // topview只放大，位置不变
    frame = CGRectMake(0, -TopViewH-down*3, KScreenWidth, TopViewH + down*3);
    self.topView.frame = frame;
}


















@end
