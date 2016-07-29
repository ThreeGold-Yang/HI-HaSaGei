//
//  HeadLinesCarouselModel.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "HeadLinesCarouselModel.h"

@implementation HeadLinesCarouselModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *arr = jsonDic[@"T1348647853363"];
    NSDictionary *dic = arr[0];
    NSArray *adsArr = dic[@"ads"];
    for (NSDictionary *dicc in adsArr) {
        HeadLinesCarouselModel *model = [[HeadLinesCarouselModel alloc]init];
        [model setValuesForKeysWithDictionary:dicc];
        [array addObject:model];
    }
    return array;
}



@end
