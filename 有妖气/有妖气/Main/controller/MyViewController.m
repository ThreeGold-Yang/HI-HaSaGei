//
//  MyViewController.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *arr;
@end

@implementation MyViewController



#pragma mark ==== ViewDidLoad ====
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.arr = @[@"清空缓存",@"我的收藏",@"设置"];
    [self creatTopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ==== 方法 ====
-(void)creatTopView
{
    UIImageView *backGroudV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH/5)];
    backGroudV.backgroundColor = [UIColor redColor];
    backGroudV.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:backGroudV];
    
    UIButton *headBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    headBtn.frame = CGRectMake(KScreenH/20, KScreenH/20, KScreenH/10, KScreenH/10);
    headBtn.backgroundColor = [UIColor redColor];
    [headBtn.layer setMasksToBounds:YES];
    headBtn.layer.cornerRadius = KScreenH/20;
    [backGroudV addSubview:headBtn];
    
    
    
    
    UITableView *myTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, KScreenH/5, KScreenW, KScreenH-49)];
    myTableV.dataSource = self;
    myTableV.delegate = self;
    [self.view addSubview:myTableV];
    
}

#pragma mark ==== 协议 ====

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = self.arr[indexPath.section];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KScreenH/20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
