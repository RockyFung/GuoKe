//
//  BestController.m
//  果壳精选
//
//  Created by lanou on 15/12/1.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "BestController.h"
#import "Define.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "BestCell.h"
#import "BestModel.h"
#import "WaterFlowLayout.h"
#import "UIImageView+WebCache.h"
#import "DetailController.h"
#import "MJRefresh.h"
#import "CollectController.h"

@interface BestController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateWaterFlowLayout>
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSTimeInterval time; // 用于往期时间累计
@property (nonatomic, strong) CollectController *collectVc;
@end

@implementation BestController


 static NSString *cellIdentifier = @"cell";



// 懒加载
- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        self.modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"每日精选";
    self.navigationController.hidesBarsOnSwipe = NO;

    
    // 用于往期时间累计
//    self.time = 1448928055;
    NSDate *date = [NSDate date];
    NSTimeInterval now = [date timeIntervalSince1970];
    self.time = now - 60*60*50;
    
    
    // 请求数据
    //    self.url = @"http://apis.guokr.com/handpick/article.json?retrieve_type=by_since";
    self.url = [NSString stringWithFormat:@"http://apis.guokr.com/handpick/article.json?retrieve_type=by_since&since=%.f",now];
    [self setNetWorkRequestWithUrlString:_url];
    

    // 先创建一个布局对象
    WaterFlowLayout *layout = [[WaterFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((KScreenWidth - 30) / 2, 0); // 返回items的高和宽
    layout.sectionInsets = UIEdgeInsetsMake(0, 10, 10, 10);
    layout.numberOfColumns = 2; // 列数
    layout.interitemSpacing = 10; // 列间距
    layout.delegate = self;
    
    
    
    // 创建collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    // 设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    // 注册
    [self.collectionView registerClass:[BestCell class] forCellWithReuseIdentifier:cellIdentifier];

    
    
    // 下拉刷新
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
    // 下拉加载
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerAction)];

}



#pragma mark - 上拉加载更多，下拉刷新
// 下拉刷新
- (void)headerAction
{
//    [self.modelArray removeAllObjects];
//    [self setNetWorkRequestWithUrlString:self.url];
    [self.collectionView reloadData];
    [self.collectionView.header endRefreshing];
}
// 上拉加载更多
- (void)footerAction
{
    NSString *url =[NSString stringWithFormat:@"http://apis.guokr.com/handpick/article.json?retrieve_type=by_since&since=%.f",self.time]; ;
    [self setNetWorkRequestWithUrlString:url];
    [self.collectionView reloadData];
    [self.collectionView.footer endRefreshing];
    self.time -= 60*60*48; // 每上拉一次往前48小时
}



#pragma  mark - collectionView代理方法
// 返回每个分区多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

// 返回items
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    BestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES; // 图片变圆后去掉多余边框
    
    if (self.modelArray.count != 0) {
        BestModel *model = self.modelArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}


#pragma mark - 返回每一个items的高
- (CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(WaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出model
    if (self.modelArray.count != 0) {
        BestModel *model = self.modelArray[indexPath.row];
        // 取出图片的链接
        NSString *picUrl = model.headline_img_tb;
        // 得到图片的尺寸
        CGSize picSize = [self picSizeWithUrl:picUrl];
        
        // 得到title的可变高度
        CGFloat titleHeight = [self stringSizeWithFont:[UIFont systemFontOfSize:15] string:model.title width:picSize.width].height;
        
        return 145 * picSize.height / picSize.width  + 10 + titleHeight + 10 + 20 + 10; // 145??
    }
    return 0;
}


#pragma mark - items点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *detailVc = [[DetailController alloc]init];
    detailVc.model = self.modelArray[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}


#pragma mark - 数据请求
- (void)setNetWorkRequestWithUrlString:(NSString *)urlString
{
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"网络请求错误,%@",error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *resultArray = dic[@"result"];
        for (NSDictionary *dict in resultArray) {
            BestModel *model = [[BestModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.modelArray addObject:model];
        }
        // 刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
//                 NSLog(@"%@",self.modelArray);
    }]resume];
}


// "http://1.im.guokr.com/AskBtf8Go3NLAwyOyfyf3J6SpiFFTfUdZfsSoCv-MqlEAgAAgAEAAFBO.png?imageView2/1/w/288/h/190"
// 取出链接中图片的大小
- (CGSize )picSizeWithUrl:(NSString *)url
{
    
    // 截取指定字符串之后的字符串
    NSString *str = [url componentsSeparatedByString:@"/w/"].lastObject;
    // 窃取指定字符串之前的字符串 w
    NSString *widthStr = [str componentsSeparatedByString:@"/h/"].firstObject;
    // h
    NSString *heightStr = [str componentsSeparatedByString:@"/h/"].lastObject;
    
    // 转类型
    
    CGFloat width = [widthStr floatValue];
    CGFloat height = [heightStr floatValue];
    
    // 返回CGSize类型
    CGSize picSize = CGSizeMake(width, height);
    
    // 当连接没有给宽高的时候赋值
    if (width == 0 || height == 0) {
        picSize = CGSizeMake(600, 400);
    }
    
    return picSize;
}







// 根据字符串和字体求字符串的高度
- (CGSize)stringSizeWithFont:(UIFont *)font string:(NSString *)string width:(CGFloat)width
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}



































@end
