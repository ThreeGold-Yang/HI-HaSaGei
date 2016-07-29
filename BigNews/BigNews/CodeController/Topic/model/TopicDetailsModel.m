//
//  TopicDetailsModel.m
//  BigNews
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TopicDetailsModel.h"

@implementation TopicDetailsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(TopicDetailsModel *)modelConfigWithJsonDic:(NSDictionary *)jsonDic
{
    TopicDetailsModel *model = [[TopicDetailsModel alloc]init];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSDictionary *expertDic = dataDic[@"expert"];
    model.expertcontent = expertDic[@"description"];
    [model setValuesForKeysWithDictionary:expertDic];
    return model;
}

+(NSMutableArray *)hotmodelConfigWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *hotList = dataDic[@"hotList"];
    for (NSDictionary *dic in hotList) {
        TopicDetailsModel *model = [[TopicDetailsModel alloc]init];
        NSDictionary *answerDic = dic[@"answer"];
        model.answercontent = answerDic[@"content"];
        [model setValuesForKeysWithDictionary:answerDic];
        
        NSDictionary *questionDic = dic[@"question"];
        model.questioncontent = questionDic[@"content"];
        [model setValuesForKeysWithDictionary:questionDic];
        
        [arr addObject:model];
    }
    return arr;
}

+(NSMutableArray *)latestmodelConfigWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *latestList = dataDic[@"latestList"];
    for (NSDictionary *dic in latestList) {
        TopicDetailsModel *model = [[TopicDetailsModel alloc]init];
        NSDictionary *answerDic = dic[@"answer"];
        model.answercontent = answerDic[@"content"];
        [model setValuesForKeysWithDictionary:answerDic];
        
        NSDictionary *questionDic = dic[@"question"];
        model.questioncontent = questionDic[@"content"];
        [model setValuesForKeysWithDictionary:questionDic];
        
        [arr addObject:model];
    }
    return arr;
}









@end
