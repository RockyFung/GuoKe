//
//  CollectCell.m
//  果壳精选
//
//  Created by lanou on 15/12/4.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "CollectCell.h"
#import "Define.h"
@interface CollectCell()

@property (nonatomic, strong) UILabel *titleLabel; // 标题
@property (nonatomic, strong) UILabel *summaryLabel; // 简介

@property (nonatomic, strong) UIImageView *sourcePic; // 来源图标
@property (nonatomic, strong) UILabel *sourcelabel; // 来源
@property (nonatomic, strong) UIImageView *timePic; // 发布时间图标
@property (nonatomic, strong) UILabel *timeLabel; // 发布时间
@end


@implementation CollectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        CGFloat cellHeight = 145;
        
        
        
        // 标题
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, KScreenWidth - 20, 40)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:_titleLabel];
        
        // 简介
        self.summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, KScreenWidth - 20, 60)];
        self.summaryLabel.font = [UIFont systemFontOfSize:16];
        self.summaryLabel.numberOfLines = 3;
        [self.contentView addSubview:_summaryLabel];
        
        CGFloat iconWidth = 20;
        // 来源
        self.sourcePic = [[UIImageView alloc]initWithFrame:CGRectMake(10, cellHeight - 25, iconWidth, iconWidth)];
        self.sourcePic.image = [UIImage imageNamed:@"laiyuan"];
        [self.contentView addSubview:_sourcePic];
        
        self.sourcelabel = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight - 25, (KScreenWidth - 3 * iconWidth) / 2, iconWidth)];
        [self.contentView addSubview:_sourcelabel];
        
        
        // 发布时间
        self.timePic = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth / 2 - 10, cellHeight - 25, iconWidth, iconWidth)];
        self.timePic.image = [UIImage imageNamed:@"shijian"];
        [self.contentView addSubview:_timePic];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth / 2 - 10 + 20, cellHeight - 25, (KScreenWidth - 3 * iconWidth) / 2, iconWidth)];
        [self.contentView addSubview:_timeLabel];
        
    }
    return self;
}


// 赋值
- (void)setModel:(BestModel *)model
{
    _model = model;
    
    // 标题
    self.titleLabel.text = model.title;
    
    // 简介
    self.summaryLabel.text = [NSString stringWithFormat:@"%@...",model.summary];
    
    // 来源
    self.sourcelabel.text = model.source_name;
    
    
    // 发布时间
    NSDate *date = [NSDate date];
    NSTimeInterval now = [date timeIntervalSince1970];
    NSTimeInterval time = now - model.date_picked;
    // 判断发布时间距离现在多长
    CGFloat oneDay = 60*60*24;
    
    if (time < 60*60) {
        self.timeLabel.text = @"1小时内";
    }else if (time > 60*60 && time < 60*60*2) {
        self.timeLabel.text = @"1小时前";
    }else if (time > 60*60*2 && time < oneDay / 2){
        self.timeLabel.text = @"2小时前";
    }else if (time > oneDay / 2 &&time < oneDay){
        self.timeLabel.text = @"半天前";
    }else if(time > oneDay){
        NSInteger day = time / oneDay;
        if (day < 7) {
            self.timeLabel.text =[NSString stringWithFormat:@"%d天前",(int)day];
        }else if (day > 7 && day < 30) {
            self.timeLabel.text =[NSString stringWithFormat:@"%d周前",(int)(day/7)];
        } else if (day > 30 && day < 365) {
            self.timeLabel.text =[NSString stringWithFormat:@"%d个月前",(int)(day/30)];
        }else if (day > 365){
            self.timeLabel.text =[NSString stringWithFormat:@"%d年前",(int)(day/365)];
        }
    }

}




@end
