//
//  NewsTwoViewController.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "NewsTwoViewController.h"
#import "ShareView.h"

#import "NewsTalkTableViewCell.h"

#import "NewsDetailsModel.h"
#import "HotTalkModel.h"
@interface NewsTwoViewController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NewsDetailsModel *NDModel;

@property(nonatomic,strong) UIScrollView *backScrV;
@property(nonatomic,strong) UIWebView *web;
@property(nonatomic,strong) ShareView *shareV;
@property(nonatomic,strong) UITableView *talkV;
@property(nonatomic,strong) UIView *headV;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UILabel *authNameL;
@property(nonatomic,assign) CGFloat H;
@property(nonatomic,strong) NSMutableArray *hotArr;
@property(nonatomic,strong) UIButton *talkNumBtn;
@property(nonatomic,strong) UITextField *inTF;
@property(nonatomic,strong) UIView *bottomV;
@property(nonatomic,strong) UIButton *shareBtn;
@end

@implementation NewsTwoViewController

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)hotArr
{
    if (!_hotArr) {
        _hotArr = [NSMutableArray array];
    }
    return _hotArr;
}

#pragma mark ==== view ====
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.docid];
    
    self.H = 200;
    [self creatView]; // 返回栏
    
    [self requestData];// 网络请求
    [self requestTalkData]; // 获取评论
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow1:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide1:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark ==== 方法 ====
-(void)creatView
{
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(0, 20, 50, 40);
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    [backBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:backBtn];
}

-(void)creatConentView
{
    self.talkV = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, KScreenW, KScreenH-109) style:(UITableViewStyleGrouped)];
    self.talkV.backgroundColor = [UIColor whiteColor];
    self.talkV.dataSource = self;
    self.talkV.delegate = self;
    [self.talkV registerClass:[NewsTalkTableViewCell class] forCellReuseIdentifier:@"talkCell"];
    [self.view addSubview:self.talkV];
}

// 新闻内容请求
-(void)requestData
{
    [RequestManger requestWithURLString:self.url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSLog(@"00000000%@",self.url);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.NDModel = [NewsDetailsModel modelConfigWithJsDic:dic docid:self.docid];
        self.web = [[UIWebView alloc]initWithFrame:CGRectMake(10, 120, KScreenW-20, 200)];
        [self.web loadHTMLString:self.NDModel.body baseURL:nil];
        self.web.delegate = self;
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 评论请求
-(void)requestTalkData
{
    NSString *url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.boardid,self.docid];
    NSLog(@"%@",url);
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.hotArr = [HotTalkModel modelConfigWithJsonDic:dic];
        [self.talkV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)creatBottomView
{
    self.bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenH-49, KScreenW, 49)];
    [self.view addSubview:self.bottomV];
    
    self.inTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, KScreenW-160, 35)];
    self.inTF.borderStyle = UITextBorderStyleRoundedRect;
    self.inTF.placeholder = @"写跟帖";
    [self.bottomV addSubview:self.inTF];
    
    self.talkNumBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.talkNumBtn.frame = CGRectMake(KScreenW-150, 5, 100, 35);
    [self.talkNumBtn setTitle:[NSString stringWithFormat:@"💬%@",self.replyCount] forState:(UIControlStateNormal)];
    self.talkNumBtn.tintColor = [UIColor redColor];
    [self.bottomV addSubview:self.talkNumBtn];
    
    self.shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.shareBtn.frame = CGRectMake(KScreenW-40, 5, 30, 35);
    self.shareBtn.tintColor = [UIColor redColor];
    [self.shareBtn addTarget:self action:@selector(shareNewsImage:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shareBtn setTitle:@"分享" forState:(UIControlStateNormal)];
    [self.bottomV addSubview:self.shareBtn];
}

-(void)keyboardShow1:(NSNotification *)notifi
{
    NSDictionary* info = [notifi userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
    
    self.bottomV.frame = CGRectMake(0, KScreenH-kbSize.height-49, KScreenW, 49);
    self.bottomV.backgroundColor = [UIColor whiteColor];
    self.inTF.frame = CGRectMake(10,5, KScreenW-50, 35);
    self.talkNumBtn.hidden = YES;
    self.inTF.placeholder = @"";
    [self.shareBtn setTitle:@"发送" forState:(UIControlStateNormal)];
}

-(void)keyboardHide1:(NSNotification *)notifi
{
    self.bottomV.frame = CGRectMake(0, KScreenH-49, KScreenW, 49);
    self.bottomV.backgroundColor = [UIColor whiteColor];
    self.talkNumBtn.hidden = NO;
    [self.shareBtn setTitle:@"分享" forState:(UIControlStateNormal)];
    self.inTF.frame = CGRectMake(10, 5, KScreenW-160, 35);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inTF resignFirstResponder];
}

#pragma mark ==== 点击方法 ====
-(void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)shareNewsImage:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"分享"]) {
        NSLog(@"分享");
    }else{
        NSLog(@"发送");
        [self.inTF resignFirstResponder];
        self.inTF.text = @"";
    }
}

#pragma mark ==== 协议 ====
// ***** web协议 *****
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[self.web stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    self.web.frame = CGRectMake(10, 120, KScreenW-20, height);
    
    UIScrollView *tempView = (UIScrollView *)[self.web.subviews objectAtIndex:0];
    tempView.scrollEnabled = NO;
    
    self.H = 180+height;
    
    [self creatConentView];
    [self creatBottomView]; // 添加书写框
    
}

// ***** tableV协议 *****
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hotArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"talkCell" forIndexPath:indexPath];
    HotTalkModel *model = self.hotArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotTalkModel *model = self.hotArr[indexPath.row];
    CGFloat H = [justHeight justHeightBy:model.b font:15 width:KScreenW-30-KScreenW/10];
    return H + 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 400)];
    
    // 标题
    self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, KScreenW-20, 60)];
    self.titleL.numberOfLines = 2;
    self.titleL.font = [UIFont systemFontOfSize:20];
    self.titleL.text = self.NDModel.title;
    [self.headV addSubview:self.titleL];
    
    // 作者+日期
    self.authNameL = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 0, 30)];
    self.authNameL.font = [UIFont systemFontOfSize:15];
    self.authNameL.alpha = 0.5;
    self.authNameL.text = [NSString stringWithFormat:@"%@     %@",self.NDModel.source,self.NDModel.ptime];
    [self.authNameL sizeToFit];
    [self.headV addSubview:self.authNameL];
    
    [self.headV addSubview:self.web];
    
    self.shareV = [[ShareView alloc]initWithFrame:CGRectMake(10, self.H-55, KScreenW-20, 50)];
    self.shareV.backgroundColor = [UIColor redColor];
    [self.headV addSubview:self.shareV];
    
    UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.H + 10, 100, 20)];
    hotLabel.text = @"热门跟帖";
    hotLabel.textColor = [UIColor redColor];
    [self.headV addSubview:hotLabel];
    
    return self.headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.H + 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *moreBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    moreBtn.frame = CGRectMake(KScreenW/3, 10, KScreenW/3, 20);
    [moreBtn setTitle:@"更多跟帖" forState:(UIControlStateNormal)];
    
    return moreBtn;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

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
