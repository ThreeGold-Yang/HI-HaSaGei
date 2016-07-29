//
//  HeadlinesView.h
//  BigNews
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsOneViewController.h"


// 头条页面

@interface HeadlinesView : UIView
@property(nonatomic,strong) CarouselView *carouselV;
@property(nonatomic,strong) NewsOneViewController *oneVC;
@end
