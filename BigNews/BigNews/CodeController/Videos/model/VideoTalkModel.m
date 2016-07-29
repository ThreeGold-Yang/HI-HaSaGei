//
//  VideoTalkModel.m
//  BigNews
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "VideoTalkModel.h"

@implementation VideoTalkModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *newPosts = jsonDic[@"newPosts"];
    for (NSDictionary *dic in newPosts) {
        VideoTalkModel *model = [[VideoTalkModel alloc]init];
        NSDictionary *dicc = dic[@"1"];
        [model setValuesForKeysWithDictionary:dicc];
        [arr addObject:model];
    }
    return arr;
}

@end
