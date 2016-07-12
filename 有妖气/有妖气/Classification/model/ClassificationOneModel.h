//
//  ClassificationOneModel.h
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassificationOneModel : NSObject

@property(nonatomic,strong) NSString *argName;
@property(nonatomic,strong) NSString *argValue;
@property(nonatomic,strong) NSString *cover;
@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *sortld;
@property(nonatomic,strong) NSString *sortName;


+(NSMutableArray *)modelconfigWith:(NSDictionary *)jsonDic;
@end
