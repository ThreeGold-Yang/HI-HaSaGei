//
//  TopicOneViewController.m
//  BigNews
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TopicOneViewController.h"
#import "TopicModel.h"
#import "TopicFirstTableViewCell.h"
#import "TopicTwoViewController.h"

@interface TopicOneViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableV;
@property(nonatomic,strong) NSMutableArray *topicArr;
@end

@implementation TopicOneViewController

#pragma mark ==== 懒加载
-(NSMutableArray *)topicArr
{
    if (!_topicArr) {
        _topicArr = [NSMutableArray array];
    }
    return _topicArr;
}

#pragma mark ==== view ====
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    [self requestData];
    
}


#pragma mark ==== 方法 ====
-(void)creatTableView
{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, KScreenW, KScreenH-109) style:(UITableViewStylePlain)];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.tableV registerNib:[UINib nibWithNibName:@"TopicFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"topicCell"];
    [self.view addSubview:self.tableV];
}

-(void)requestData
{
    NSString *url = @"http://c.m.163.com/newstopic/list/expert/0-10.html";
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.topicArr = [TopicModel modelConfigWithJsonDic:dic];
        [self.tableV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark ==== 点击方法 ====




#pragma mark ==== 协议 ====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell" forIndexPath:indexPath];
    TopicModel *model = self.topicArr[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160+KScreenW/1.8;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicModel *model = self.topicArr[indexPath.row];
    TopicTwoViewController *topicTwoVC = [[TopicTwoViewController alloc]init];
    topicTwoVC.expertId = model.expertId;
    topicTwoVC.picurl = model.picurl;
    [self.navigationController pushViewController:topicTwoVC animated:YES];
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
