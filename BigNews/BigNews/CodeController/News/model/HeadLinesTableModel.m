//
//  HeadLinesTableModel.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "HeadLinesTableModel.h"

@implementation HeadLinesTableModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *arr = jsonDic[@"T1348647853363"];
    for (NSDictionary *dicc in arr) {
        HeadLinesTableModel *model = [[HeadLinesTableModel alloc]init];
        model.imgsrcArr = [NSMutableArray array];
        NSArray *imgs = dicc[@"imgextra"];
        for (NSDictionary *imgDic in imgs) {
            NSString *imgsUrl = imgDic[@"imgsrc"];
            [model.imgsrcArr addObject:imgsUrl];
        }
        [model setValuesForKeysWithDictionary:dicc];
        [array addObject:model];
    }
    return array;
}











@end
