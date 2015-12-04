//
//  BestModel.h
//  果壳精选
//
//  Created by lanou on 15/12/1.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BestModel : NSObject

@property (nonatomic, copy) NSString *author; // 作者
@property (nonatomic, copy) NSString *headline_img; // 全图
@property (nonatomic, copy) NSString *headline_img_tb; // 1/2图片
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, assign) NSTimeInterval date_created; // 创建时间戳
@property (nonatomic, assign) NSTimeInterval date_picked; // 上传时间
@property (nonatomic, assign) NSInteger detailId; // 拼接id
@property (nonatomic, copy) NSString *source_name; // 来源
@property (nonatomic, copy) NSString *link_v2; // 详情链接


@end
