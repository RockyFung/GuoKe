//
//  CollectController.m
//  果壳精选
//
//  Created by lanou on 15/12/4.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "CollectController.h"
#import "CoreDataManage.h"
#import "CollectCell.h"
#import "BestModel.h"
#import "Define.h"
#import "DetailController.h"


@interface CollectController ()

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation CollectController


- (void)viewWillAppear:(BOOL)animated
{
    self.modelArray = [CoreDataManage findAllCoreData];
    [self.tableView reloadData];
//    NSLog(@"modelArray = %@",self.modelArray);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];    
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScreenWidth / 2.58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[CollectCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    BestModel *model = self.modelArray[indexPath.row];
    
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *detailVc = [[DetailController alloc]init];
    detailVc.model = self.modelArray[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}



@end
