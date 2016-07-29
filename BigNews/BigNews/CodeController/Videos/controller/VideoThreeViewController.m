//
//  VideoThreeViewController.m
//  BigNews
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "VideoThreeViewController.h"
#import "VideoTalkModel.h"
#import "NewsTalkTableViewCell.h"

@interface VideoThreeViewController ()<CYVideoPlayerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) CYVideoPlayerView *playerView;
@property (nonatomic,strong) CYFullViewController *fullViewController;

@property(nonatomic,strong)  NSMutableArray *videoTalkArr;
@property(nonatomic,strong) UITableView *talkTableView;

@end

@implementation VideoThreeViewController
#pragma mark ==== 懒加载 ====
-(NSMutableArray *)videoTalkArr
{
    if (!_videoTalkArr) {
        _videoTalkArr = [NSMutableArray array];
    }
    return _videoTalkArr;
}

#pragma mark ==== view ====
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatBackView];
    [self creatPlayVC];
    [self creatTalkView];
    [self requestTalkData];
    
    [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(pauseVideo)];
}


#pragma mark ==== 方法 ====
// 返回栏
-(void)creatBackView
{
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(10, 30, 30, 30);
    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    backBtn.tintColor = [UIColor blackColor];
    [backBtn addTarget:self action:@selector(backToVideo) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
}

// 创建播放器
-(void)creatPlayVC
{
    self.playerView = [[CYVideoPlayerView alloc]initWithFrame:CGRectMake(0, 70, KScreenW, 200)];
    self.playerView.delegate = self;
    [self.view addSubview:self.playerView];
    [self.playerView replaceAVPlayerItem:[[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.videoUrl]]];
}

// 创建评论区
-(void)creatTalkView
{
    self.talkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 270, KScreenW, KScreenH-270) style:(UITableViewStylePlain)];
    self.talkTableView.dataSource = self;
    self.talkTableView.delegate = self;
    [self.talkTableView registerClass:[NewsTalkTableViewCell class] forCellReuseIdentifier:@"videoTalkCell"];
    [self.talkTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"videoTalkCell1"];
    [self.view addSubview:self.talkTableView];
}

// 评论获取
-(void)requestTalkData
{
    NSString *url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/normal/%@/%@/desc/0/10/10/2/2",self.replyBoard,self.replyid];
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.videoTalkArr = [VideoTalkModel modelConfigWithJsonDic:dic];
        [self.talkTableView reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)pauseVideo
{
    self.tabBarController.tabBar.hidden = NO;
    [self.playerView.player pause];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ==== 点击方法 ====
- (void)backToVideo
{
    self.tabBarController.tabBar.hidden = NO;
    [self.playerView.player pause];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CYVideoPlayerDelegate
/** <是否全屏播放视频> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar shouldFullScreen:(BOOL)isFull
{
    if (isFull) {
        self.fullViewController = [[CYFullViewController alloc] init];
        [self.fullViewController.view addSubview:self.playerView];
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.removeExisting = YES;
        }];
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.fullViewController.view);
        }];
        [self presentViewController:self.fullViewController animated:NO completion:nil];
    }else
    {
        [self.fullViewController dismissViewControllerAnimated:NO completion:^{
            [self.view addSubview:self.playerView];
            self.fullViewController = nil;
            [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(70);
                make.left.equalTo(self.view.mas_left).offset(0);
                make.right.equalTo(self.view.mas_right).offset(0);
                make.height.mas_equalTo(self.view.bounds.size.width * 9 / 16);
            }];
        }];
    }
}

#pragma mark ==== 协议 ====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.videoTalkArr.count == 0) {
        return 1;
    }
    return self.videoTalkArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.videoTalkArr.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoTalkCell1" forIndexPath:indexPath];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.text = @"快来抢沙发!!!!";
        return cell;
    }else{
        NewsTalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoTalkCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        VideoTalkModel *model = self.videoTalkArr[indexPath.row];
        cell.videoTalkModel = model;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.videoTalkArr.count == 0) {
        return 60;
    }else{
        VideoTalkModel *model = self.videoTalkArr[indexPath.row];
        CGFloat H = [justHeight justHeightBy:model.b font:18 width:KScreenW-30-KScreenW/10];
        return H + 70;
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
