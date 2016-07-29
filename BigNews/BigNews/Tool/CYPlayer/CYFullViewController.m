//
//  CYFullViewController.m
//  CYVideoPlayer
//
//  Created by dongzb on 16/2/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYFullViewController.h"

@interface CYFullViewController ()

@end

@implementation CYFullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 横屏代码
- (BOOL)shouldAutorotate{
    return YES;
} //NS_AVAILABLE_IOS(6_0);当前viewcontroller是否支持转屏

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
} //当前viewcontroller支持哪些转屏方向

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    NSLog(@"----");
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
