//
//  InfomationOneModel.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "InfomationOneModel.h"

@implementation InfomationOneModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWith:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *rootDic = jsonDic[@"root"];
    NSArray *listArr = rootDic[@"list"];
    for (NSDictionary *dic in listArr) {
        InfomationOneModel *model = [[InfomationOneModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}




@end
