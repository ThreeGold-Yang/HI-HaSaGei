//
//  NewsThreeViewController.h
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>


//@implementation UIScrollView (UITouchEvent)
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.nextResponder touchesBegan:touches withEvent:event];
//}
//@end

// 图集新闻通用


@interface NewsThreeViewController : UIViewController
  // 图集内容
@property(nonatomic,strong) NSString *parameter1;
@property(nonatomic,strong) NSString *parameter2;
  // 图集评论
@property(nonatomic,strong) NSString *boardid;
@property(nonatomic,strong) NSString *postid;
@property(nonatomic,strong) NSString *replyCount;
@end
