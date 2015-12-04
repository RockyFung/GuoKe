//
//  BestCell.h
//  果壳精选
//
//  Created by lanou on 15/12/1.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BestModel.h"

@interface BestCell : UICollectionViewCell

@property (nonatomic, strong) BestModel *model;

@property (nonatomic, strong) UIImageView *picImageView; // 图片

@end
