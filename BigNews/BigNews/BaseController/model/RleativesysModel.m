//
//  RleativesysModel.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "RleativesysModel.h"

@implementation RleativesysModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsDic:(NSDictionary *)jsonDic docid:(NSString *)docid
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *docDic = [jsonDic valueForKey:docid];
    NSArray *relativesysArr = docDic[@"relative_sys"];
    for (NSDictionary *dic in relativesysArr) {
        RleativesysModel *model = [[RleativesysModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}

@end
