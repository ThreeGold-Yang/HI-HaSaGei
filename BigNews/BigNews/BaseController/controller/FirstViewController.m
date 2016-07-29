//
//  FirstViewController.m
//  BigNews
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self creatTopView];
    
    
}

-(void)creatTopView
{
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 60)];
    topV.backgroundColor = [UIColor redColor];
    [self.view addSubview:topV];
}








@end
