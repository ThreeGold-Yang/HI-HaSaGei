//
//  HotTalkModel.m
//  BigNews
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "HotTalkModel.h"

@implementation HotTalkModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *hotPosts = jsonDic[@"hotPosts"];
    for (NSDictionary *dic in hotPosts)
    {
        HotTalkModel *model = [[HotTalkModel alloc]init];
        NSDictionary *dicc = dic[@"1"];
        [model setValuesForKeysWithDictionary:dicc];
        [arr addObject:model];
    }
    return arr;
}





@end
