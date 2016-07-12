//
//  InfomationTwoViewController.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "InfomationTwoViewController.h"

@interface InfomationTwoViewController ()

@end

@implementation InfomationTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)creatWebView
{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-49)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    
    [self.view addSubview:web];
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
