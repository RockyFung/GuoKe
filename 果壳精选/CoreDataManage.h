//
//  CoreDataManage.h
//  果壳精选
//
//  Created by lanou on 15/12/4.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataModel.h"
#import "BestModel.h"



@interface CoreDataManage : NSObject

// 创建coreData数据库
+ (NSManagedObjectContext *)creatCoreData;

// 添加数据
+ (void)addCoreData:(BestModel *)bestModel;

// 根据url删除一条数据
+ (void)deleteCoreDataWithUrl:(NSString *)url;

// 查找一条数据
+ (BestModel *)findCoreDataWithUrl:(NSString *)url;

// 查找所有数据
+ (NSArray *)findAllCoreData;


@end
