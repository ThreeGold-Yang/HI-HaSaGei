//
//  NewsTwoViewController.h
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

@implementation UIScrollView (UITouchEvent)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesBegan:touches withEvent:event];
}
@end

#import "FirstViewController.h"

// 文字新闻详情通用


@interface NewsTwoViewController : FirstViewController

@property(nonatomic,strong) NSString *docid;
@property(nonatomic,strong) NSString *boardid;
@property(nonatomic,strong) NSString *replyCount;
@end
