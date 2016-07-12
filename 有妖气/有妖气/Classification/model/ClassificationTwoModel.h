//
//  ClassificationTwoModel.h
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassificationTwoModel : NSObject
@property(nonatomic,strong) NSString *accredit;
@property(nonatomic,strong) NSString *chapter_num;
@property(nonatomic,strong) NSString *click_total;
@property(nonatomic,strong) NSString *comic_id;
@property(nonatomic,strong) NSString *comic_type;
@property(nonatomic,strong) NSString *cover;
@property(nonatomic,strong) NSString *content; //代替description
@property(nonatomic,strong) NSString *extraValue;
@property(nonatomic,strong) NSString *last_update_chapter_name;
@property(nonatomic,strong) NSString *last_update_chapter_id;
@property(nonatomic,strong) NSString *last_update_time;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *nickname;
@property(nonatomic,strong) NSString *short_description;
@property(nonatomic,strong) NSString *theme_ids;
@property(nonatomic,strong) NSString *user_id;


+(NSMutableArray *)modelConfigWith:(NSDictionary *)jsonDic;
@end
