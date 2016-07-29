//
//  SectionModel.m
//  BigNews
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "SectionModel.h"

@implementation SectionModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)sectionArrWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *hotPosts = jsonDic[@"hotPosts"];
    for (NSDictionary *Dic in hotPosts) {
        NSDictionary *dic = Dic[@"1"];
        SectionModel *sectionModel = [[SectionModel alloc]init];
        sectionModel.rowArr = [NSMutableArray array];
        [sectionModel setValuesForKeysWithDictionary:dic];
        sectionModel.sectionH = [justHeight justHeightBy:sectionModel.b font:15 width:KScreenW-20];
        for (NSString *key in Dic) {
            if ([key isEqualToString:@"1"]) {
                
            }else{
                RowModel *rowModel = [[RowModel alloc]init];
                [rowModel setValuesForKeysWithDictionary:Dic[key]];
                [sectionModel.rowArr addObject:rowModel];
            }
        }
        [arr addObject:sectionModel];
    }
    return arr;
}
@end
