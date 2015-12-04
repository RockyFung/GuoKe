//
//  BestModel.m
//  果壳精选
//
//  Created by lanou on 15/12/1.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "BestModel.h"

@implementation BestModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.detailId = [value intValue];
    }
}
@end
