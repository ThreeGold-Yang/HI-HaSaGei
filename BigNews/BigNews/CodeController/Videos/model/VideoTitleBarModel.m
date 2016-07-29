//
//  VideoTitleBarModel.m
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "VideoTitleBarModel.h"

@implementation VideoTitleBarModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsonDic:(NSArray *)jsonArr
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in jsonArr) {
        VideoTitleBarModel *model = [[VideoTitleBarModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}

@end
