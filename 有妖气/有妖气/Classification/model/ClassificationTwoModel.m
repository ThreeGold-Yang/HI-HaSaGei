//
//  ClassificationTwoModel.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ClassificationTwoModel.h"

@implementation ClassificationTwoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWith:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *returnDataArr = dataDic[@"returnData"];
    for (NSDictionary *dic in returnDataArr) {
        ClassificationTwoModel *model = [[ClassificationTwoModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}


@end
