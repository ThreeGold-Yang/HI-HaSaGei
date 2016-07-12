//
//  ClassificationTwoViewController.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ClassificationTwoViewController.h"
#import "ClassificationTwoModel.h"
@interface ClassificationTwoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) NSMutableArray *classTwoArr;
@property(nonatomic,strong) UITableView *classTwoTableV;

@end

@implementation ClassificationTwoViewController

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)classTwoArr
{
    if (!_classTwoArr) {
        _classTwoArr = [NSMutableArray array];
    }
    return _classTwoArr;
}

#pragma mark ==== ViewDidLoad ====
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    [self requestData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ==== 方法 ====

-(void)creatTableView
{
    self.classTwoTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-49) style:(UITableViewStylePlain)];
    self.classTwoTableV.dataSource = self;
    self.classTwoTableV.delegate = self;
    [self.view addSubview:self.classTwoTableV];
}

-(void)requestData
{
    NSString *url = [NSString stringWithFormat:@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.2.2.3&deviceId=7b0216f7b35412c8f99a6fbcce53fb0b09ed844b&model=iPhone&time=1462155631&page=%ld&argName=%@&argValue=%@&size=20&from=10.2.2.3&",self.index,self.argName,self.argValue];
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arr = [ClassificationTwoModel modelConfigWith:dic];
        [self.classTwoTableV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}









#pragma mark ==== 协议 ====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.classTwoArr.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    
//}












/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
