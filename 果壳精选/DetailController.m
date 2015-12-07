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
#import "DIYButton.h"
#import "CoreDataManage.h"
#import "UIViewController+MMDrawerController.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"


@interface DetailController () < UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *topView;
@property (nonatomic, strong) UIWebView *webView; // 网页显示
@property (nonatomic, strong) UIButton *rightBtn; // 收藏按钮
@property (nonatomic, strong) UIButton *shareBtn; // 分享按钮
@property (nonatomic, assign) BOOL isCollect; // 用来判断有没有收藏过
@end

const CGFloat TopViewH = 168; // 图片的高度

@implementation DetailController


- (void)viewWillAppear:(BOOL)animated
{
    // 页面即将出现的时候判断有没有收藏过
    if([CoreDataManage findCoreDataWithUrl:self.model.link_v2]){
        [self.rightBtn setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateNormal];
    }else{
        [self.rightBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    // 页面即将消失的时候让页面可以滑动
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加表头
    self.topView = [[UIImageView alloc] init];
    self.topView.frame = CGRectMake(0, -TopViewH, KScreenWidth, TopViewH);
    [self.topView sd_setImageWithURL:[NSURL URLWithString:self.model.headline_img] placeholderImage:[UIImage imageNamed:@"hoderPic"]];
    self.topView.contentMode = UIViewContentModeScaleAspectFill;
    
    //添加网络视图
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64)];
    // 自动对页面进行缩放以适应屏幕
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self; // 设置scrollView的代理
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.gapBetweenPages = 100;
    NSURL *targetUrl = [NSURL URLWithString:self.model.link_v2];
    [self.webView loadRequest:[NSURLRequest requestWithURL:targetUrl]];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(TopViewH, 0, 0, 0);
    
    [self.view addSubview:_webView];
    [self.webView.scrollView addSubview:_topView];
    [self.webView.scrollView insertSubview:_topView atIndex:0]; // 把视图放到scrollView最底层（让webView在前面）



    // 添加收藏按钮
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame =CGRectMake(0, 0, 25, 25);
    [self.rightBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    
    // 添加分享按钮
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame =CGRectMake(0, 0, 25, 25);
    [self.shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    UIBarButtonItem *shareBarBtn = [[UIBarButtonItem alloc]initWithCustomView:_shareBtn];
    
    // 把两个按钮添加到右边
    self.navigationItem.rightBarButtonItems = @[shareBarBtn, rightBarBtn];
    
    
    // 关闭左右滑动功能
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}


#pragma mark - 收藏按钮
- (void)collectAction:(UIButton *)button
{
///////// 收藏
    if(![CoreDataManage findCoreDataWithUrl:self.model.link_v2]){
        NSLog(@"收藏");
        [self.rightBtn setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateNormal];
        // 添加到收藏夹
        [CoreDataManage addCoreData:self.model];
    }
///////// 取消收藏
    else{
        NSLog(@"取消收藏");
        [self.rightBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        // 取消收藏
        [CoreDataManage deleteCoreDataWithUrl:self.model.link_v2];
    }
}


#pragma mark - 分享按钮
- (void)shareAction:(UIButton *)btn
{
    NSLog(@"share......");
    
    
    NSString *str = [NSString stringWithFormat:@"%@ \n %@ \n分享自 GuoKe", self.model.title, self.model.link_v2];
    
    [UMSocialWechatHandler setWXAppId:@"wxaae072fcd1c171fa" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:self.model.link_v2];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5662812967e58e2991005b9f"
                                      shareText:str
                                     shareImage:self.model.headline_img
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline, nil]
                                       delegate:nil];
    
}


#pragma mark - webView代理方法
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

#pragma mark - scrollView代理
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
