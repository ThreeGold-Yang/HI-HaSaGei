//
//  TopicTwoViewController.m
//  BigNews
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TopicTwoViewController.h"
#import "TopicDetailsModel.h"
#import "AnswerAndAskTableViewCell.h"
#import "TopicThreeViewController.h"

typedef NS_ENUM(NSInteger,HotOrLates) {
    hotState,
    latesState
};
@interface TopicTwoViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>


@property(nonatomic,strong) UIView *hideTopV; // 隐藏栏
@property(nonatomic,strong) UIImageView *headImg; //背景图
@property(nonatomic,strong) UILabel *contentL; // 背景图上得介绍
@property(nonatomic,strong) UILabel *fouL; // 背景图上的关注数
@property(nonatomic,strong) UILabel *introL; // 本人介绍
@property(nonatomic,strong) UIButton *showIntroBtn; // 展开按钮
@property(nonatomic,strong) UIView *oneV; // 分区1的视图
@property(nonatomic,assign) CGFloat H; // 分区1的视图高度
@property(nonatomic,strong) UIView *twoV; // 分区2的视图
@property(nonatomic,strong) UILabel *askL; // 提问、回复数
@property(nonatomic,strong) NSMutableArray *hotArr; // 最热
@property(nonatomic,strong) NSMutableArray *latestArr; // 最新
@property(nonatomic,strong) UIButton *talkNumBtn;
@property(nonatomic,strong) UITextField *inTF;
@property(nonatomic,strong) UIView *bottomV;
@property(nonatomic,strong) UIButton *shareBtn;
@property(nonatomic,strong) NSMutableArray *BigArr; // 切换最新最热
@property(nonatomic,assign) HotOrLates hotOrlates;
@property(nonatomic,strong) TopicDetailsModel *topicDetailsModel; // 总体model
@end

@implementation TopicTwoViewController

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)hotArr
{
    if (!_hotArr) {
        _hotArr = [NSMutableArray array];
    }
    return _hotArr;
}

-(NSMutableArray *)latestArr
{
    if (!_latestArr) {
        _latestArr = [NSMutableArray array];
    }
    return _latestArr;
}

#pragma mark ==== view ====
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    self.H = 100;
    [self creatTableView];
    [self creatHideTopView];
    [self creatTableHeaderView];
    [self requestData];
    self.hideTopV.alpha = 0;
    self.hotOrlates = hotState;
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(10, 20, 40, 40);
    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    backBtn.tintColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(backToTopic) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    [self creatBottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark ==== 方法 ====
-(void)creatTableView
{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, KScreenW, KScreenH-69) style:(UITableViewStyleGrouped)];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.showsVerticalScrollIndicator = NO;
    [self.tableV registerNib:[UINib nibWithNibName:@"AnswerAndAskTableViewCell" bundle:nil] forCellReuseIdentifier:@"AnswerAndAskTableViewCell"];
    self.tableV.tableHeaderView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableV];
}

// 非协议头视图
-(void)creatTableHeaderView
{
    self.tableV.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KScreenW, 160)]; // 很关键
    self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 160)];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.picurl] placeholderImage:placeHoldImageURL completed:nil];
    [self.tableV.tableHeaderView addSubview:self.headImg];
    
    UIBlurEffect *glass = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIView * scr1 = [[UIVisualEffectView alloc] initWithEffect:glass];
    scr1.alpha = 0.4;
    scr1.frame = CGRectMake(0, 0, KScreenW,160);
    [self.headImg addSubview:scr1];
    
    UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, KScreenW-40, 40)];
    contentL.numberOfLines = 2;
    contentL.textAlignment = 1;
    contentL.font = [UIFont systemFontOfSize:15];
    contentL.textColor = [UIColor whiteColor];
    self.contentL = contentL;
    [self.tableV.tableHeaderView addSubview:self.contentL];
    
    UILabel *fouL = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/3, 90, KScreenW/3, 20)];
    fouL.textColor = [UIColor whiteColor];
    fouL.font = [UIFont systemFontOfSize:12];
    fouL.textAlignment = 1;
    self.fouL = fouL;
    [self.tableV.tableHeaderView addSubview:self.fouL];
    
    UIButton *concernBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    concernBtn.frame = CGRectMake(KScreenW/3, 120, KScreenW/3, 30);
    [concernBtn setTitle:@"+关注"forState:(UIControlStateNormal)];
    concernBtn.tintColor = [UIColor whiteColor];
    concernBtn.backgroundColor = [UIColor redColor];
    [self.tableV.tableHeaderView addSubview:concernBtn];

}

// 隐藏栏
-(void)creatHideTopView
{
    self.hideTopV = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KScreenW, self.navigationController.navigationBar.bounds.size.height)];
    self.hideTopV.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.hideTopV];
}

-(void)creatBottomView
{
    self.bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenH-49, KScreenW, 49)];
    self.bottomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomV];
    
    self.inTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, KScreenW-160, 35)];
    self.inTF.borderStyle = UITextBorderStyleRoundedRect;
    self.inTF.placeholder = @"我也要提问!";
    [self.bottomV addSubview:self.inTF];
    
    self.talkNumBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.talkNumBtn.frame = CGRectMake(KScreenW-150, 5, 100, 35);
    self.talkNumBtn.tintColor = [UIColor redColor];
    [self.bottomV addSubview:self.talkNumBtn];
    
    self.shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.shareBtn.frame = CGRectMake(KScreenW-40, 5, 30, 35);
    [self.shareBtn addTarget:self action:@selector(shareTopicText:) forControlEvents:(UIControlEventTouchUpInside)];
    self.shareBtn.tintColor = [UIColor redColor];
    [self.shareBtn setTitle:@"分享" forState:(UIControlStateNormal)];
    [self.bottomV addSubview:self.shareBtn];
}

-(void)requestData
{
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/qa/%@.html",self.expertId];
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.topicDetailsModel = [TopicDetailsModel modelConfigWithJsonDic:dic];
        self.hotArr = [TopicDetailsModel hotmodelConfigWithJsonDic:dic];
        self.latestArr = [TopicDetailsModel latestmodelConfigWithJsonDic:dic];
        
        // tableviewHeadrView赋值
        self.contentL.text = self.topicDetailsModel.alias;
        self.fouL.text = [NSString stringWithFormat:@"— %@关注 —",self.topicDetailsModel.concernCount];
        // bottomV赋值
        [self.talkNumBtn setTitle:[NSString stringWithFormat:@"💬%@",self.topicDetailsModel.answerCount] forState:(UIControlStateNormal)];
        self.BigArr = self.hotArr;
        [self.tableV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(UIView *)oneSectionV
{
    self.oneV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 100)];
    self.oneV.backgroundColor = [UIColor whiteColor];
    
    UIImageView *authImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    authImg.layer.cornerRadius = 25;
    authImg.layer.masksToBounds = YES;
    [authImg sd_setImageWithURL:[NSURL URLWithString:self.topicDetailsModel.headpicurl] placeholderImage:placeHoldImageURL completed:nil];
    [self.oneV addSubview:authImg];
    
    UILabel *authNameL = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 0, 20)];
    authNameL.font = [UIFont systemFontOfSize:12];
    authNameL.alpha = 0.5;
    authNameL.text = [NSString stringWithFormat:@"%@ 丨 %@",self.topicDetailsModel.name,self.topicDetailsModel.classification];
    [authNameL sizeToFit];
    [self.oneV addSubview:authNameL];
    
    self.introL = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, KScreenW-80, 30)];
    self.introL.numberOfLines = 2;
    self.introL.font = [UIFont systemFontOfSize:12];
    self.introL.alpha = 0.5;
    self.introL.text = self.topicDetailsModel.expertcontent;
    [self.oneV addSubview:self.introL];
    
    self.showIntroBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.showIntroBtn.frame = CGRectMake(0, 70, KScreenW, 30);
    [self.showIntroBtn setTitle:@"展开" forState:(UIControlStateNormal)];
    [self.showIntroBtn addTarget:self action:@selector(showIntroBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.oneV addSubview:self.showIntroBtn];
    
    return self.oneV;
}

-(UIView *)twoSectionV
{
    self.twoV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, self.navigationController.navigationBar.bounds.size.height)];
    
    self.askL = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 30)];
    self.askL.font = [UIFont systemFontOfSize:12];
    self.askL.alpha = 0.5;
    self.askL.text = [NSString stringWithFormat:@"%@提问   %@回复",self.topicDetailsModel.questionCount,self.topicDetailsModel.answerCount];
    [self.askL sizeToFit];
    [self.twoV addSubview:self.askL];
    
    NSArray *arr = @[@"最热",@"最新"];
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:arr];
    seg.frame = CGRectMake(KScreenW-110, 10, 100, 30);
    seg.tintColor = [UIColor redColor];
    if (self.hotOrlates == hotState) {
        seg.selectedSegmentIndex = 0;
    }else{
        seg.selectedSegmentIndex = 1;
    }
    [seg addTarget:self action:@selector(hotandlatestQuest:) forControlEvents:(UIControlEventValueChanged)];
    [self.twoV addSubview:seg];
    
    return self.twoV;
}


#pragma mark ==== 点击方法 ====
-(void)backToTopic
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showIntroBtnAction
{
    if ([self.showIntroBtn.titleLabel.text isEqualToString:@"展开"]) {
        self.introL.numberOfLines = 0;
        CGFloat h = [justHeight justHeightBy:self.topicDetailsModel.expertcontent font:12 width:KScreenW-80];
        self.H = h + 70;
        [self.tableV reloadData];
    }else{
        self.H = 100;
        [self.tableV reloadData];
    }
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

-(void)keyboardShow:(NSNotification *)notifi
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

-(void)keyboardHide:(NSNotification *)notifi
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

-(void)hotandlatestQuest:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        self.BigArr = self.hotArr;
        self.hotOrlates = hotState;
    }else{
        self.BigArr = self.latestArr;
        self.hotOrlates = latesState;
    }
    [self.tableV reloadData];
}
#pragma mark ==== 协议 ====
// 滚动协议
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.bounces = NO;
    self.hideTopV.alpha = (scrollView.contentOffset.y/self.headImg.bounds.size.height);
    [self.inTF resignFirstResponder];
}

// table协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return self.BigArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerAndAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerAndAskTableViewCell" forIndexPath:indexPath];
    if (self.hotOrlates == hotState) {
        TopicDetailsModel *hotModel = self.hotArr[indexPath.row];
        cell.model = hotModel;
    }else{
        TopicDetailsModel *lastesModel = self.latestArr[indexPath.row];
        cell.model = lastesModel;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicDetailsModel *model = self.BigArr[indexPath.row];
    TopicThreeViewController *threeVC = [[TopicThreeViewController alloc]init];
    threeVC.board = model.board;
    threeVC.commentId = model.commentId;
    [self.navigationController pushViewController:threeVC animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicDetailsModel *hotmodel = self.BigArr[indexPath.row];
    CGFloat userH = [justHeight justHeightBy:hotmodel.questioncontent font:15 width:KScreenW-70];
    CGFloat authH = [justHeight justHeightBy:hotmodel.answercontent font:15 width:KScreenW-70];
    return 210+userH+authH;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *v1 = [self oneSectionV];
        if (self.H>100) {
            self.introL.numberOfLines = 0;
            CGFloat h = [justHeight justHeightBy:self.topicDetailsModel.expertcontent font:12 width:KScreenW-80];
            self.introL.frame = CGRectMake(70, 40, KScreenW-80, h);
            self.showIntroBtn.frame = CGRectMake(0,40+h, KScreenW, 30);
            [self.showIntroBtn setTitle:@"收起" forState:(UIControlStateNormal)];
        }
        return v1;
    }else{
        UIView *v2 = [self twoSectionV];
        return v2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.H;
    }else{
        return self.navigationController.navigationBar.bounds.size.height;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 1;
    }
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
