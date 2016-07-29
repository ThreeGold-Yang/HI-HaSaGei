//
//  RecommendedView.h
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoOneViewController.h"
// 推荐页面
@interface RecommendedView : UIView

@property(nonatomic,strong) VideoOneViewController *videoOneVC;
@property(nonatomic,strong) NSString *mytid;

@end
