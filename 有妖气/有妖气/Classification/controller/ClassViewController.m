//
//  ClassViewController.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassificationView.h"
@interface ClassViewController ()

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    ClassificationView *claV = [[ClassificationView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-49)];
    claV.classVC = self;
    [self.view addSubview:claV];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
