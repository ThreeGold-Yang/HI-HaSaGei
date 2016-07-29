//
//  HeadLinesCarouselModel.h
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadLinesCarouselModel : NSObject

// 头条轮播图
@property(nonatomic,strong) NSString *imgsrc;
@property(nonatomic,strong) NSString *tag;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *url;

+(NSMutableArray *)modelConfigWithJsonDic:(NSDictionary *)jsonDic;
@end
