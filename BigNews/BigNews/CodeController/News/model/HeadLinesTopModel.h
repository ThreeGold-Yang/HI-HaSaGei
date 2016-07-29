//
//  HeadLinesTopModel.h
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadLinesTopModel : NSObject
// 置顶新闻
@property(nonatomic,strong) NSString *alias;
@property(nonatomic,strong) NSString *boardid;
@property(nonatomic,strong) NSString *cid;
@property(nonatomic,strong) NSString *docid;
@property(nonatomic,strong) NSString *ename;
@property(nonatomic,strong) NSString *imgsrc;
@property(nonatomic,strong) NSString *replyCount;
@property(nonatomic,strong) NSString *source;
@property(nonatomic,strong) NSString *skipID;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *tname;
@property(nonatomic,strong) NSString *postid;
@property(nonatomic,strong) NSArray *imgextra;

+(HeadLinesTopModel *)modelConfigWithJsDic:(NSDictionary *)jsonDic;
@end
