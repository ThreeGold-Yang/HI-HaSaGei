//
//  TopicModel.h
//  BigNews
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//


// 话题一级界面
#import <Foundation/Foundation.h>

@interface TopicModel : NSObject


@property(nonatomic,strong) NSString *alias;
@property(nonatomic,strong) NSString *answerCount;
@property(nonatomic,strong) NSString *classification;
@property(nonatomic,strong) NSString *concernCount;
@property(nonatomic,strong) NSString *topicContent; //代替description
@property(nonatomic,strong) NSString *expertId; // 参数
@property(nonatomic,strong) NSString *expertState;
@property(nonatomic,strong) NSString *headpicurl;// 头像
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *picurl;
@property(nonatomic,strong) NSString *questionCount;
@property(nonatomic,strong) NSString *title;

+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic;

@end
