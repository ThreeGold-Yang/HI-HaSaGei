//
//  NewsThreeViewController.m
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "NewsThreeViewController.h"

#import "NewsImageModel.h"

@interface NewsThreeViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrV;
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UITextView *contentL;
@property(nonatomic,strong) UILabel *numL;
@property(nonatomic,strong) NSMutableArray<NewsImageModel *> *newsImageArr;
@property(nonatomic,strong) NSMutableArray<UIImageView *> *imgs;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) UIButton *talkNumBtn;
@property(nonatomic,strong) UITextField *inTF;
@property(nonatomic,strong) UIView *bottomV;
@property(nonatomic,strong) UIButton *shareBtn;
@end

@implementation NewsThreeViewController

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)newsImageArr
{
    if (!_newsImageArr) {
        _newsImageArr = [NSMutableArray array];
    }
    return _newsImageArr;
}

-(NSMutableArray *)imgs
{
    if (!_imgs) {
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    
    self.index = 0;
    [self creatBackView];
    [self creatImageView];
    [self creatBottomView];
    [self requestData];
    [self requestTalkData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark ==== 方法 ====

-(void)creatBackView
{
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(10, 30, 40, 40);
    [backBtn addTarget:self action:@selector(ImageBackToTop) forControlEvents:(UIControlEventTouchUpInside)];
    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    backBtn.tintColor = [UIColor whiteColor];
    [self.view addSubview:backBtn];
}

-(void)creatImageView
{
    self.scrV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KScreenH/8, KScreenW, KScreenH/3)];
    self.scrV.backgroundColor = [UIColor blackColor];
    self.scrV.delegate = self;
    self.scrV.pagingEnabled = YES;
    [self.view addSubview:self.scrV];
    
    self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, KScreenH/8+KScreenH/3+10, KScreenW-20, 30)];
    self.titleL.textColor = [UIColor whiteColor];
    [self.view addSubview:self.titleL];
    
    self.numL = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW-110, KScreenH/8+KScreenH/3+40, 100, 30)];
    self.numL.textColor = [UIColor whiteColor];
    self.numL.textAlignment = 1;
    [self.view addSubview:self.numL];
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
    [self.shareBtn addTarget:self action:@selector(shareNewText:) forControlEvents:(UIControlEventTouchUpInside)];
    self.shareBtn.tintColor = [UIColor redColor];
    [self.shareBtn setTitle:@"分享" forState:(UIControlStateNormal)];
    [self.bottomV addSubview:self.shareBtn];
}

// 新闻图集获取
-(void)requestData
{
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",self.parameter1,self.parameter2];
    NSLog(@"%1515151515@",url);
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.newsImageArr = [NewsImageModel modelConfigWithJsonDic:dic];
        self.scrV.contentSize = CGSizeMake(self.newsImageArr.count*KScreenW, 0);
        
        NewsImageModel *model = self.newsImageArr[0];
        self.titleL.text = model.setname;
        self.numL.text = [NSString stringWithFormat:@"%d/%ld",self.index+1,(unsigned long)self.newsImageArr.count];
    
        
        self.contentL = [[UITextView alloc]initWithFrame:CGRectMake(0, KScreenH/8+KScreenH/3+70, KScreenW, KScreenH-(KScreenH/8+KScreenH/3+70+49))];
        self.contentL.text = model.note;
        self.contentL.font = [UIFont systemFontOfSize:18];
        self.contentL.backgroundColor = [UIColor blackColor];
        self.contentL.editable = NO;
        self.contentL.textColor = [UIColor whiteColor];
        [self.view addSubview:self.contentL];
        
        for (int i = 0; i < self.newsImageArr.count; i++) {
            UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW*i, 0, KScreenW, KScreenH/3)];
            imageV1.tag = i + 200;
            [imageV1 sd_setImageWithURL:[NSURL URLWithString:self.newsImageArr[i].imgurl] placeholderImage:placeHoldImageURL completed:nil];
            [self.imgs addObject:imageV1];
            [self.scrV addSubview:imageV1];
        }
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 图集评论获取
-(void)requestTalkData
{
    NSString *url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.boardid,self.postid];
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
    self.bottomV.backgroundColor = [UIColor blackColor];
    self.talkNumBtn.hidden = NO;
    [self.shareBtn setTitle:@"分享" forState:(UIControlStateNormal)];
    self.inTF.frame = CGRectMake(10, 5, KScreenW-160, 35);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inTF resignFirstResponder];
}
#pragma mark ==== 点击方法 ====
-(void)ImageBackToTop
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareNewText:(UIButton *)btn
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.index = scrollView.contentOffset.x / KScreenW;
    NewsImageModel *model = self.newsImageArr[self.index];
    self.contentL.text = model.note;
    self.numL.text = [NSString stringWithFormat:@"%ld/%ld",self.index+1,self.newsImageArr.count];
   
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
