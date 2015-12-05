//
//  CoreDataModel+CoreDataProperties.h
//  果壳精选
//
//  Created by lanou on 15/12/4.
//  Copyright © 2015年 RockyFung. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSString *headline_img;
@property (nullable, nonatomic, retain) NSString *headline_img_tb;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *date_created;
@property (nullable, nonatomic, retain) NSNumber *date_picked;
@property (nullable, nonatomic, retain) NSNumber *detailId;
@property (nullable, nonatomic, retain) NSString *source_name;
@property (nullable, nonatomic, retain) NSString *link_v2;
@property (nullable, nonatomic, retain) NSString *summary;

@end

NS_ASSUME_NONNULL_END
