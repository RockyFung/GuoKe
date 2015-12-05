//
//  CoreDataManage.m
//  果壳精选
//
//  Created by lanou on 15/12/4.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "CoreDataManage.h"

@implementation CoreDataManage
// 创建coreData数据库
+ (NSManagedObjectContext *)creatCoreData
{
    static NSManagedObjectContext *context = nil;
    if (context) {
        return context;
    }
    /*
     NSConfinementConcurrencyType
     这个是默认项，每个线程一个独立的Context，主要是为了兼容之前的设计。
     NSPrivateQueueConcurrencyType
     创建一个private queue(使用GCD)，这样就不会阻塞主线程。
     NSMainQueueConcurrencyType
     创建一个main queue，使用主线程，会阻塞。
     */
    // 1.创建context
    context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    // 2.创建strore需要的NSManagedObjectModel
    NSString *path = [[NSBundle mainBundle]pathForResource:@"MyCoreData" ofType:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    // 3.创建context需要的NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    // 4.添加持久化数据的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject]; // 找到沙盒
    NSString *sqlite = [docPath stringByAppendingPathComponent:@"MyCoreData.sqlite"];
    NSLog(@"sqlite == %@",sqlite);
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlite] options:nil error:nil];
    // 5.把store给context
    context.persistentStoreCoordinator = store;
    return context;
}

// 添加数据
+ (void)addCoreData:(BestModel *)bestModel
{
    NSManagedObjectContext *context = [self creatCoreData];
    // 添加一条数据
    CoreDataModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"CoreDataModel" inManagedObjectContext:context];
    model.author = bestModel.author;
    model.headline_img = bestModel.headline_img;
    model.headline_img_tb = bestModel.headline_img_tb;
    model.title = bestModel.title;
    model.date_created = [NSNumber numberWithDouble:bestModel.date_created];
    model.date_picked = [NSNumber numberWithDouble:bestModel.date_picked];
    model.detailId =  [NSNumber numberWithDouble:bestModel.detailId];
    model.source_name = bestModel.source_name;
    model.link_v2 = bestModel.link_v2;
    model.summary = bestModel.summary;
    // 保存到数据库
    [context save:nil];
    NSLog(@"添加成功");
}

// 根据url删除一条数据
+ (void)deleteCoreDataWithUrl:(NSString *)url
{
    NSManagedObjectContext *context = [self creatCoreData];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CoreDataModel"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"link_v2 = %@",url];
    request.predicate = predicate;
    CoreDataModel *model = [context executeFetchRequest:request error:nil].firstObject;
    [context deleteObject:model];
    [context save:nil];
    NSLog(@"删除成功");
}

// 查找一条数据
+ (BestModel *)findCoreDataWithUrl:(NSString *)url
{
    NSManagedObjectContext *context = [self creatCoreData];
    
    BestModel *model = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CoreDataModel"];
    // 查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"link_v2 = %@",url];
    request.predicate = predicate;
    // 返回model
    model = [context executeFetchRequest:request error:nil].firstObject;
    NSLog(@"===%@",model.link_v2);
    return model ;
}

// 查找所有数据
+ (NSArray *)findAllCoreData
{
    NSManagedObjectContext *context = [self creatCoreData];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CoreDataModel"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date_picked" ascending:YES];
    request.sortDescriptors = @[sort];
    NSArray *array = [context executeFetchRequest:request error:nil];
    return array;
}

@end
