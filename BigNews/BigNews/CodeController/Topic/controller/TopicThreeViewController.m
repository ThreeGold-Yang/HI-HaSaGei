//
//  TopicThreeViewController.m
//  BigNews
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TopicThreeViewController.h"
#import "TopicTwoViewController.h"
#import "NewsTalkTableViewCell.h"
#import "SectionModel.h"
#import "RowModel.h"
@interface TopicThreeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableV;
@property(nonatomic,strong) NSMutableArray *sectionArr;
@property(nonatomic,strong) NSMutableArray *rowArr;
@property(nonatomic,assign) CGFloat h;
@property(nonatomic,strong) UITextField *inTF;
@property(nonatomic,strong) UIView *bottomV;
@property(nonatomic,strong) UIButton *shareBtn;
@end

@implementation TopicThreeViewController

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)sectionArr
{
    if (!_sectionArr) {
        _sectionArr = [NSMutableArray array];
    }
    return _sectionArr;
}

-(NSMutableArray *)rowArr
{
    if (!_rowArr) {
        _rowArr = [NSMutableArray array];
    }
    return _rowArr;
}
#pragma mark ==== view ====
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatBackView];
    [self creatTableView];
    [self creatBottomView];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}


#pragma mark ==== 方法 ====

-(void)creatBackView
{
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(10, 20, 40, 40);
    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backToTwoVC) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
}


-(void)creatTableView
{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, KScreenW, KScreenH-109) style:(UITableViewStyleGrouped)];
    self.tableV.backgroundColor = [UIColor whiteColor];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.tableV registerClass:[NewsTalkTableViewCell class] forCellReuseIdentifier:@"topicthreeCell"];
    [self.view addSubview:self.tableV];
}

-(void)creatBottomView
{
    self.bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenH-49, KScreenW, 49)];
    [self.view addSubview:self.bottomV];
    
    self.inTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, KScreenW-50, 35)];
    self.inTF.borderStyle = UITextBorderStyleRoundedRect;
    self.inTF.placeholder = @"我也说两句...";
    [self.bottomV addSubview:self.inTF];
    
    self.shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.shareBtn.frame = CGRectMake(KScreenW-40, 5, 30, 35);
    [self.shareBtn addTarget:self action:@selector(shareTopicText:) forControlEvents:(UIControlEventTouchUpInside)];
    self.shareBtn.tintColor = [UIColor redColor];
    [self.shareBtn setTitle:@"分享" forState:(UIControlStateNormal)];
    [self.bottomV addSubview:self.shareBtn];
}


-(void)requestData
{
    NSString *url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.board,self.commentId];
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.sectionArr = [SectionModel sectionArrWithJsonDic:jsonDic];
        [self.tableV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark ==== 点击方法 ====
-(void)backToTwoVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showMoreTalk:(UIButton *)btn
{
    NSInteger index = btn.tag - 200;
    SectionModel *secModel = self.sectionArr[index];
    if (secModel.isChoose == YES) {
        secModel.isChoose = NO;
    }else{
        secModel.isChoose = YES;
    }
    [self.tableV reloadData];
}

-(void)keyboardShow:(NSNotification *)notifi
{
    NSDictionary* info = [notifi userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
    
    self.bottomV.frame = CGRectMake(0, KScreenH-kbSize.height-49, KScreenW, 49);
    self.bottomV.backgroundColor = [UIColor whiteColor];
    self.inTF.frame = CGRectMake(10,5, KScreenW-50, 35);
    self.inTF.placeholder = @"";
    [self.shareBtn setTitle:@"发送" forState:(UIControlStateNormal)];
}

-(void)keyboardHide:(NSNotification *)notifi
{
    self.bottomV.frame = CGRectMake(0, KScreenH-49, KScreenW, 49);
    self.inTF.frame = CGRectMake(10, 5, KScreenW-50, 35);
    [self.shareBtn setTitle:@"分享" forState:(UIControlStateNormal)];
}

-(void)shareTopicText:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"分享"]) {
        NSLog(@"分享");
    }else{
        NSLog(@"发送");
        [self.inTF resignFirstResponder];
        self.inTF.text = @"";
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inTF resignFirstResponder];
}
#pragma mark ==== 协议 ====
// 头部
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArr.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionModel *secModel = self.sectionArr[section];
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 200)];
    headV.backgroundColor = [UIColor whiteColor];
    
    UIImageView *authImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    authImg.backgroundColor = [UIColor redColor];
    [authImg sd_setImageWithURL:[NSURL URLWithString:secModel.timg] placeholderImage:placeHoldImageURL completed:nil];
    [headV addSubview:authImg];
    
    UILabel *authL = [[UILabel alloc]initWithFrame:CGRectMake(70, 25, 0, 20)];
    authL.font = [UIFont systemFontOfSize:15];
    authL.text = secModel.n;
    [authL sizeToFit];
    [headV addSubview:authL];
    
    UILabel *contL = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, KScreenW-20, secModel.sectionH)];
    contL.text = secModel.b;
    contL.font = [UIFont systemFontOfSize:15];
    contL.numberOfLines = 0;
    [headV addSubview:contL];
    
    UIButton *moreTalkBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    moreTalkBtn.frame = CGRectMake(10, secModel.sectionH+80, KScreenW-10, 30);
    moreTalkBtn.tintColor = [UIColor redColor];
    [moreTalkBtn setTitle:@"更多评论" forState:(UIControlStateNormal)];
    [moreTalkBtn addTarget:self action:@selector(showMoreTalk:) forControlEvents:(UIControlEventTouchUpInside)];
    moreTalkBtn.tag = section + 200;
    [headV addSubview:moreTalkBtn];
    
    return headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    SectionModel *secModel = self.sectionArr[section];
    return secModel.sectionH+120;
}

// cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel *secModel = self.sectionArr[section];
    if (secModel.isChoose == YES) {
        return secModel.rowArr.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicthreeCell" forIndexPath:indexPath];
    SectionModel *secModel = self.sectionArr[indexPath.section];
    RowModel *rowModel = secModel.rowArr[indexPath.row];
    cell.rowModel = rowModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionModel *secModel = self.sectionArr[indexPath.section];
    RowModel *rowModel = secModel.rowArr[indexPath.row];
    CGFloat h = [justHeight justHeightBy:rowModel.b font:15 width:KScreenW-30-KScreenW/10];
    return 75+h;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

// scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.inTF resignFirstResponder];
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
