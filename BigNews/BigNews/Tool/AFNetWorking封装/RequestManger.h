//
//  RequestManger.h
//  UI++18COCOPODS
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 dou. All rights reserved.
//

#import <Foundation/Foundation.h>

// 基于NFNetWorking的网络请求二次封装

typedef NS_ENUM(NSInteger,ResquestType) {
    RequestGET,
    RequestPOST
};
typedef void(^Finish)(NSData *data);
typedef void(^Error)(NSError *error);


@interface RequestManger : NSObject
@property (nonatomic,copy)Finish finish;
@property (nonatomic,copy)Error error;
@property (nonatomic,assign)ResquestType *requestType;

+(void)requestWithURLString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(ResquestType)type sucess:(Finish)finish falure:(Error)error;




@end
