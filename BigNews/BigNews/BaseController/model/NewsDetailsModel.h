//
//  NewsDetailsModel.h
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailsModel : NSObject

// 新闻详情
@property(nonatomic,strong) NSString *body;
@property(nonatomic,strong) NSString *dkeys;
@property(nonatomic,strong) NSString *docid;
@property(nonatomic,strong) NSString *ec;
@property(nonatomic,strong) NSArray *img;//
@property(nonatomic,strong) NSString *ptime;
//@property(nonatomic,strong) NSString *relative_sys;//
@property(nonatomic,strong) NSString *replyCount;
@property(nonatomic,strong) NSString *source;
@property(nonatomic,strong) NSString *title;
//@property(nonatomic,strong) NSString *topiclist_news;//


+(NewsDetailsModel *)modelConfigWithJsDic:(NSDictionary *)jsonDic docid:(NSString *)docid;
@end
