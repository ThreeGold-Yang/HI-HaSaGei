//
//  justHeight.m
//  豆瓣
//
//  Created by lanou on 16/5/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "justHeight.h"

@implementation justHeight

+(CGFloat)justHeightBy:(NSString *)text font:(CGFloat)font width:(CGFloat)width;
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGFloat h = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    return h;
}


@end
