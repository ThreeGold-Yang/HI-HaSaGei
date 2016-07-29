//
//  TopiclistNewsModel.h
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopiclistNewsModel : NSObject

// 相关新闻
@property(nonatomic,strong) NSString *alias;
@property(nonatomic,strong) NSString *cid;
@property(nonatomic,strong) NSString *subnum;
@property(nonatomic,strong) NSString *tid;
@property(nonatomic,strong) NSString *tname;

+(NSMutableArray *)modelConfigWithJsDic:(NSDictionary *)jsonDic docid:(NSString *)docid;
@end
