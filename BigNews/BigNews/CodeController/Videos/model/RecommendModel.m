//
//  RecommendModel.m
//  BigNews
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic mytid:(NSString *)mytid
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *tidArr = [jsonDic valueForKey:mytid];
    for (NSDictionary *dic in tidArr) {
        RecommendModel *model = [[RecommendModel alloc]init];
        NSDictionary *videoTopicDic = dic[@"videoTopic"];
        model.ename = videoTopicDic[@"ename"];
        model.tid = videoTopicDic[@"tid"];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}
@end
