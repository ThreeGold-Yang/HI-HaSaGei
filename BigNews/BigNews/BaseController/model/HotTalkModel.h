//
//  HotTalkModel.h
//  BigNews
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotTalkModel : NSObject

// 热评
@property(nonatomic,strong) NSString *b; // 评论内容
@property(nonatomic,strong) NSString *d; // 编号?
@property(nonatomic,strong) NSString *n; // 评论者昵称
@property(nonatomic,strong) NSString *timg; // 评论者头像
@property(nonatomic,strong) NSString *t; // 评论时间
@property(nonatomic,strong) NSString *v; // 顶贴人数


+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic;


@end
