//
//  TopicDetailsModel.h
//  BigNews
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

// 话题详情
#import <Foundation/Foundation.h>

@interface TopicDetailsModel : NSObject
// 作者部分
@property(nonatomic,strong) NSString *alias;
@property(nonatomic,strong) NSString *answerCount;
@property(nonatomic,strong) NSString *classification;
@property(nonatomic,strong) NSString *concernCount;
@property(nonatomic,strong) NSString *createTime;
@property(nonatomic,strong) NSString *expertcontent;// 代替description
@property(nonatomic,strong) NSString *expertId;
@property(nonatomic,strong) NSString *headpicurl;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *picurl;
@property(nonatomic,strong) NSString *questionCount;
@property(nonatomic,strong) NSString *stitle;
@property(nonatomic,strong) NSString *title;

+(TopicDetailsModel *)modelConfigWithJsonDic:(NSDictionary *)jsonDic;

// 回答
@property(nonatomic,strong) NSString *answerId;
@property(nonatomic,strong) NSString *board;
@property(nonatomic,strong) NSString *commentId;
@property(nonatomic,strong) NSString *answercontent; //
@property(nonatomic,strong) NSString *cTime;
@property(nonatomic,strong) NSString *relatedQuestionId;
@property(nonatomic,strong) NSString *replyCount;
@property(nonatomic,strong) NSString *specialistHeadPicUrl;
@property(nonatomic,strong) NSString *specialistName;
@property(nonatomic,strong) NSString *supportCount;
// 提问
@property(nonatomic,strong) NSString *questioncontent; //
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSString *relatedExpertId;
@property(nonatomic,strong) NSString *userHeadPicUrl;
@property(nonatomic,strong) NSString *userName;

+(NSMutableArray *)hotmodelConfigWithJsonDic:(NSDictionary *)jsonDic;
+(NSMutableArray *)latestmodelConfigWithJsonDic:(NSDictionary *)jsonDic;



@end
