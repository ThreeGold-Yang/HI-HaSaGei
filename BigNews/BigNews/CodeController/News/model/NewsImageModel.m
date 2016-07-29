//
//  NewsImageModel.m
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "NewsImageModel.h"


@implementation NewsImageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *photoArr = jsonDic[@"photos"];
    for (NSDictionary *dic in photoArr) {
        NewsImageModel *model = [[NewsImageModel alloc]init];
        model.setname = jsonDic[@"setname"];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}


@end
