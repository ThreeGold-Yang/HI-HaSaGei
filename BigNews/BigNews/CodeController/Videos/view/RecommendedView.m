//
//  RecommendedView.m
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "RecommendedView.h"
#import "RecommendModel.h"
#import "VideoTableViewCell.h"
#import "VideoThreeViewController.h"

@interface RecommendedView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableV;
@property(nonatomic,strong) NSMutableArray *recommendArr;
@property(nonatomic,strong) AVPlayer *myplayer;
@property(nonatomic,strong) AVPlayerLayer *mylayer;
@end

@implementation RecommendedView

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)recommendArr
{
    if (!_recommendArr) {
        _recommendArr = [NSMutableArray array];
    }
    return _recommendArr;
}

#pragma mark ==== 初始化 ====
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, frame.size.height) style:(UITableViewStylePlain)];
        self.tableV.dataSource = self;
        self.tableV.delegate = self;
        [self.tableV registerClass:[VideoTableViewCell
                                    class] forCellReuseIdentifier:@"videoCell"];
        [self addSubview:self.tableV];
        //self.mytid = @"T1457068979049";
//        [self requestVideoData];
    }
    return self;
}

#pragma mark ==== 方法 ====
// 获取到VC中得tid
-(void)setMytid:(NSString *)mytid
{
    if (_mytid != mytid) {
        _mytid = mytid;
        [self requestVideoData];
    }
}

-(void)requestVideoData
{
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/Tlist/%@/0-10.html",self.mytid];
    NSLog(@"%@",url);
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.recommendArr = [RecommendModel modelConfigWithJsonDic:dic mytid:self.mytid];
        [self.tableV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark ==== 点击方法 ====
-(void)startPlay:(UIButton *)btn
{
    VideoTableViewCell *cell = (VideoTableViewCell *)btn.superview.superview;
    NSIndexPath *path = [self.tableV indexPathForCell:cell];
    
    RecommendModel *model = self.recommendArr[path.row];
    if (model.ischoose == NO) {
        model.ischoose = YES;
        cell.playBtn.hidden = YES;
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:model.mp4_url]];
        self.myplayer = [[AVPlayer alloc]init];
        [self.myplayer replaceCurrentItemWithPlayerItem:item];
        [self.myplayer play];
        
        self.mylayer = [AVPlayerLayer playerLayerWithPlayer:self.myplayer];
        // 播放窗口属性
        self.mylayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.mylayer.frame = CGRectMake(0, 0, KScreenW-20, 200);
        self.mylayer.backgroundColor = [UIColor blueColor].CGColor;
        [cell.imageV.layer addSublayer:self.mylayer];
    }else{
        cell.playBtn.hidden = NO;
    }
}

#pragma mark ==== 协议 ====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommendArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
    RecommendModel *model = self.recommendArr[indexPath.row];
    cell.model = model;
    cell.playBtn.hidden = NO;

    for (VideoTableViewCell *cell in tableView.visibleCells) { // 很关键(遍历展示出得cell)
        if (cell.model.ischoose == YES) {
            cell.model.ischoose = YES;
        }else{
            cell.model.ischoose = NO;
            [self.myplayer pause];
            [self.mylayer removeFromSuperlayer];
        }
    }
    [cell.playBtn addTarget:self action:@selector(startPlay:) forControlEvents:(UIControlEventTouchUpInside)];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendModel *model = self.recommendArr[indexPath.row];
    VideoThreeViewController *videoThreeVC = [[VideoThreeViewController alloc]init];
    videoThreeVC.videoUrl = model.mp4_url;
    videoThreeVC.replyBoard = model.replyBoard;
    videoThreeVC.replyid = model.replyid;
    [self.videoOneVC.navigationController pushViewController:videoThreeVC animated:YES];
}










@end
