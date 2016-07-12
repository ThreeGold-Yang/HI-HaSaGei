//
//  ClassificationOneModel.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ClassificationOneModel.h"

@implementation ClassificationOneModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelconfigWith:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSDictionary *returnDic = dataDic[@"returnData"];
    NSArray *rankinglistArr = returnDic[@"rankinglist"];
    for (NSDictionary *dic in rankinglistArr) {
        ClassificationOneModel *model = [[ClassificationOneModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}




@end
