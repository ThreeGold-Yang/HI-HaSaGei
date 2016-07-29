//
//  RecommendModel.h
//  BigNews
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>
// 推荐类视频

@interface RecommendModel : NSObject

@property(nonatomic,strong) NSString *cover;
@property(nonatomic,strong) NSString *content;// 代替description
@property(nonatomic,strong) NSString *mp4_url;
@property(nonatomic,strong) NSString *playCount;
@property(nonatomic,strong) NSString *ptime;
@property(nonatomic,strong) NSString *replyCount;
@property(nonatomic,strong) NSString *replyid; // 获取评论所需参数
@property(nonatomic,strong) NSString *replyBoard; // 获取评论所需参数
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *topicDesc;
@property(nonatomic,strong) NSString *topicName;
@property(nonatomic,strong) NSString *topicSid;
@property(nonatomic,strong) NSString *vid;
@property(nonatomic,strong) NSString *videosource;
@property(nonatomic,strong) NSString *ename;
@property(nonatomic,strong) NSString *tid;

@property(nonatomic,assign) BOOL ischoose;

+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic mytid:(NSString *)mytid;

@end
