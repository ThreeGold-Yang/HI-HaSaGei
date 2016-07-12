//
//  InfomationOneModel.h
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfomationOneModel : NSObject

@property(nonatomic,strong) NSString *author;
@property(nonatomic,strong) NSString *ID;
@property(nonatomic,strong) NSString *imglink;
@property(nonatomic,strong) NSString *likecount;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *talkcount;
@property(nonatomic,strong) NSString *url;


+(NSMutableArray *)modelConfigWith:(NSDictionary *)jsonDic;
@end
