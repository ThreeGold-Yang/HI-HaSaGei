//
//  InfomationOnePageViewController.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "InfomationOnePageViewController.h"
#import "InfomationOnePageTableViewCell.h"
#import "InfomationOneModel.h"

#import "InfomationTwoViewController.h"

@interface InfomationOnePageViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *infomationTableV;
@property(nonatomic,strong) NSMutableArray *infomationOneArr;
@property(nonatomic,assign) NSInteger index;

@end

@implementation InfomationOnePageViewController

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)infomationOneArr
{
    if (!_infomationOneArr) {
        _infomationOneArr = [NSMutableArray array];
    }
    return _infomationOneArr;
}

#pragma mark ==== ViewDidLoad ====

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatInfomationTableView];
    
    [self requsetData];
    
    
    self.infomationTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 0;
        [self.infomationOneArr removeAllObjects];
        [self requsetData];
    }];
    
    self.infomationTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.index += 10;
        [self requsetData];
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ==== 方法 ====

-(void)creatInfomationTableView
{
    self.infomationTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-49) style:(UITableViewStylePlain)];
    self.infomationTableV.dataSource = self;
    self.infomationTableV.delegate = self;
    self.infomationTableV.rowHeight = (KScreenW-20)*13/32+70;
    [self.infomationTableV registerClass:[InfomationOnePageTableViewCell class] forCellReuseIdentifier:@"infomationOneCell"];
    [self.view addSubview:self.infomationTableV];
}

-(void)requsetData
{
    NSString *url = [NSString stringWithFormat:KInfomationUrl,self.index];
    [RequestManger requestWithURLString:url parDic:nil requestType:(RequestGET) sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arr = [InfomationOneModel modelConfigWith:dic];
        for (InfomationOneModel *model in arr) {
            [self.infomationOneArr addObject:model];
        }
        [self.infomationTableV.mj_header endRefreshing];
        [self.infomationTableV.mj_footer endRefreshing];
        //[self.infomationTableV reloadData];
        [self.infomationTableV reloadDataAnimateWithWave:(RightToLeftWaveAnimation)];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark ==== 协议 ====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infomationOneArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfomationOnePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infomationOneCell" forIndexPath:indexPath];
    
    InfomationOneModel *model = self.infomationOneArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfomationOneModel *model = self.infomationOneArr[indexPath.row];
    InfomationTwoViewController *infomationTwoVC = [[InfomationTwoViewController alloc]init];
    infomationTwoVC.webUrl = model.url;
    [self.navigationController pushViewController:infomationTwoVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
