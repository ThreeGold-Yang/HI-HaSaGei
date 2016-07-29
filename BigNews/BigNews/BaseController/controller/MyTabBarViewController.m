//
//  MyTabBarViewController.m
//  BigNews
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "NewsOneViewController.h"
#import "ReadOneViewController.h"
#import "TopicOneViewController.h"
#import "VideoOneViewController.h"
#import "MyViewController.h"




@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController




- (void)viewDidLoad {
    [super viewDidLoad];
   
    NewsOneViewController *newOneVC = [[NewsOneViewController alloc]init];
    [self creatTabBarViewWith:newOneVC title:@"新闻"];
    
    ReadOneViewController *readOneVC = [[ReadOneViewController alloc]init];
    [self creatTabBarViewWith:readOneVC title:@"阅读"];
    
    VideoOneViewController *videoOneVC = [[VideoOneViewController alloc]init];
    [self creatTabBarViewWith:videoOneVC title:@"视频"];
    
    TopicOneViewController *topicOneVC = [[TopicOneViewController alloc]init];
    [self creatTabBarViewWith:topicOneVC title:@"话题"];
    
    MyViewController *myVC = [[MyViewController alloc]init];
    [self creatTabBarViewWith:myVC title:@"我的"];
    
    
}

-(void)creatTabBarViewWith:(UIViewController *)vc title:(NSString *)title
{
    vc.title = title;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    vc.tabBarItem.title = title;
    vc.navigationController.navigationBar.hidden = YES;
    
    // 自带右滑手势
    [vc.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(showTabBar:)];
    [self addChildViewController:navi];
}

-(void)showTabBar:(UIGestureRecognizer *)gestureRecognizer
{
    self.tabBar.hidden = NO;
}






@end
