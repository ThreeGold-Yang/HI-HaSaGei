//
//  RequestManger.m
//  UI++18COCOPODS
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 dou. All rights reserved.
//

#import "RequestManger.h"

@implementation RequestManger

+(void)requestWithURLString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(ResquestType)type sucess:(Finish)finish falure:(Error)error{
    RequestManger *manager = [[RequestManger alloc]init];
    [manager requestWithURLString:urlString parDic:parDic requestType:type sucess:finish falure:error];
}

-(void)requestWithURLString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(ResquestType)type sucess:(Finish)finish falure:(Error)error{
    self.finish = finish;
    self.error = error;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (type == RequestGET) {
        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self returntoMainQueue:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.error(error);
        }];
    }else{
        [manager POST:urlString parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self returntoMainQueue:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.error(error);
        }];
    }
    
    
    
}

-(void)returntoMainQueue:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finish(data);
    });
}



@end
