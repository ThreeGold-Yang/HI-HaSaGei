//
//  NewsDetailsModel.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "NewsDetailsModel.h"



@implementation NewsDetailsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NewsDetailsModel *)modelConfigWithJsDic:(NSDictionary *)jsonDic docid:(NSString *)docid
{
    NSDictionary *docDic = [jsonDic valueForKey:docid];
    NewsDetailsModel *model = [[NewsDetailsModel alloc]init];
    for (NSString *key in docDic) {
        [model setValue:docDic[key] forKey:key];
    }
    return model;
}

@end
