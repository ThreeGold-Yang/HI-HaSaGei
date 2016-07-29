//
//  RleativesysModel.h
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RleativesysModel : NSObject

// 其他新闻
@property(nonatomic,strong) NSString *docID;
@property(nonatomic,strong) NSString *imgsrc;
@property(nonatomic,strong) NSString *ptime;
@property(nonatomic,strong) NSString *source;
@property(nonatomic,strong) NSString *title;

+(NSMutableArray *)modelConfigWithJsDic:(NSDictionary *)jsonDic docid:(NSString *)docid;
@end
