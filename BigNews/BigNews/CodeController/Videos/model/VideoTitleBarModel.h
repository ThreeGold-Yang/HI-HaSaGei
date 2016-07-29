//
//  VideoTitleBarModel.h
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

// 视频页面标题栏
@interface VideoTitleBarModel : NSObject
@property(nonatomic,strong) NSString *tid;
@property(nonatomic,strong) NSString *tname;

+(NSMutableArray *)modelConfigWithJsonDic:(NSArray *)jsonArr;
@end
