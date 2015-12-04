//
//  BestCell.m
//  果壳精选
//
//  Created by lanou on 15/12/1.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "BestCell.h"
#import "DIYButton.h"
#import "UIImageView+WebCache.h"
#import "Define.h"


@interface BestCell ()


@property (nonatomic, strong) UILabel *titleLabel; // 标题
@property (nonatomic, strong) UIImageView *sourcePic; // 来源图标
@property (nonatomic, strong) UILabel *sourcelabel; // 来源
@property (nonatomic, strong) UIImageView *timePic; // 发布时间图标
@property (nonatomic, strong) UILabel *timeLabel; // 发布时间

@end



@implementation BestCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // 图片
        self.picImageView = [[UIImageView alloc]init];
        self.picImageView.backgroundColor = [UIColor magentaColor];
        [self.contentView addSubview:_picImageView];
        
        // 标题
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.numberOfLines = 0;
//        self.titleLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_titleLabel];
        
        // 来源
        self.sourcePic = [[UIImageView alloc]init];
        self.sourcePic.image = [UIImage imageNamed:@"laiyuan"];
        [self.contentView addSubview:_sourcePic];
        
        self.sourcelabel = [[UILabel alloc]init];
//        self.sourcelabel.backgroundColor = [UIColor redColor];
        self.sourcelabel.font = [UIFont systemFontOfSize:12];
        self.sourcelabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_sourcelabel];
        
        // 发布时间
        self.timePic = [[UIImageView alloc]init];
        self.timePic.image = [UIImage imageNamed:@"shijian"];
        [self.contentView addSubview:_timePic];
        
        self.timeLabel = [[UILabel alloc]init];
//        self.timeLabel.backgroundColor = [UIColor greenColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLabel];


    }
    return self;
}

// model赋值
- (void)setModel:(BestModel *)model
{
    _model = model;

    // 图片赋值
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:self.model.headline_img_tb] placeholderImage:[UIImage imageNamed:@"holderPic"]];
    
    // title赋值
    self.titleLabel.text = model.title;
    
    // 来源赋值
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



// 重写父类方法，动态返回高度
- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
   
    // 标题高度
    CGFloat labelHeight = [self stringSizeWithFont:[UIFont systemFontOfSize:15] string:self.model.title width:(KScreenWidth - 3 * 10) / 2].height;
    
    // 图片高度
    self.picImageView.frame = CGRectMake(x, y, width, height - labelHeight - 20 - 20);
    
    // title高度
    self.titleLabel.frame = CGRectMake(x+5, self.picImageView.frame.size.height + 10, width - 10, labelHeight);
    
    
    CGFloat iconWidth = 20;
    // 来源label高度
    self.sourcePic.frame = CGRectMake(x , self.picImageView.frame.size.height + self.titleLabel.frame.size.height + 20, iconWidth , iconWidth);
    self.sourcelabel.frame = CGRectMake(x+iconWidth , self.picImageView.frame.size.height + self.titleLabel.frame.size.height + 20, width / 2 - iconWidth , iconWidth);
    
    // 发布时间高度
    self.timePic.frame = CGRectMake(width / 2, self.picImageView.frame.size.height + self.titleLabel.frame.size.height + 20, iconWidth, iconWidth);
    self.timeLabel.frame = CGRectMake(width / 2 + iconWidth, self.picImageView.frame.size.height + self.titleLabel.frame.size.height +20, width / 2 - iconWidth, iconWidth);
    
    
}


// 根据字符串和字体求字符串的高度
- (CGSize)stringSizeWithFont:(UIFont *)font string:(NSString *)string width:(CGFloat)width
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}



























@end
