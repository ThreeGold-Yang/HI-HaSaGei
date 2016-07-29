//
//  VideoTalkModel.h
//  BigNews
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoTalkModel : NSObject
@property(nonatomic,strong) NSString *b; // 评论内容
@property(nonatomic,strong) NSString *f; // 来自哪里的网友
@property(nonatomic,strong) NSString *t; // 评论时间
@property(nonatomic,strong) NSString *timg; // 评论人头像
@property(nonatomic,strong) NSString *v; // 点赞人数
@property(nonatomic,strong) NSString *n; // 评论人昵称


+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic;

@end
