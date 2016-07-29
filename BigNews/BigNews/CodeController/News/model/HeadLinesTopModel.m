//
//  HeadLinesTopModel.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "HeadLinesTopModel.h"

@implementation HeadLinesTopModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(HeadLinesTopModel *)modelConfigWithJsDic:(NSDictionary *)jsonDic;
{
    HeadLinesTopModel *model = [[HeadLinesTopModel alloc]init];
    NSArray *arr = jsonDic[@"T1348647853363"];
    NSDictionary *dic = arr[0];
    for (NSString *key in dic) {
        [model setValue:dic[key] forKey:key];
    }
    return model;
}
@end
