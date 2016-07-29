//
//  NewsImageModel.h
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>
// 新闻图集
@interface NewsImageModel : NSObject

@property(nonatomic,strong) NSString *cimgurl;
@property(nonatomic,strong) NSString *imgurl;
@property(nonatomic,strong) NSString *note;
@property(nonatomic,strong) NSString *photohtml;
@property(nonatomic,strong) NSString *photoid;
@property(nonatomic,strong) NSString *simgurl;
@property(nonatomic,strong) NSString *squareimgurl;
@property(nonatomic,strong) NSString *timgurl;
@property(nonatomic,strong) NSString *setname;


+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic;

@end
