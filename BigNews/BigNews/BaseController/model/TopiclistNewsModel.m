//
//  TopiclistNewsModel.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TopiclistNewsModel.h"

@implementation TopiclistNewsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigWithJsDic:(NSDictionary *)jsonDic docid:(NSString *)docid
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *docDic = [jsonDic valueForKey:docid];
    NSArray *topiclistnewsArr = docDic[@"topiclist_news"];
    for (NSDictionary *dic in topiclistnewsArr) {
        TopiclistNewsModel *model = [[TopiclistNewsModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}



@end
