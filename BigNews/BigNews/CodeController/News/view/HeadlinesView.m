//
//  HeadlinesView.m
//  BigNews
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "HeadlinesView.h"
#import "NewsTwoViewController.h"
#import "NewsOneViewController.h"
#import "NewsThreeViewController.h"

// model
#import "HeadLinesCarouselModel.h"
#import "HeadLinesTableModel.h"
#import "HeadLinesTopModel.h"

// cell
#import "NewsType1TableViewCell.h"
#import "NewsType2TableViewCell.h"


@interface HeadlinesView ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) UITableView *tableV;

@property(nonatomic,strong) NSMutableArray *HLCModelArr;
@property(nonatomic,strong) NSMutableArray *HLCImageArr;
@property(nonatomic,strong) NSMutableArray *HLTModelArr;
@property(nonatomic,strong) HeadLinesTopModel *topModel;

@end

@implementation HeadlinesView

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)HLCModelArr
{
    if (!_HLCModelArr) {
        _HLCModelArr = [NSMutableArray array];
    }
    return _HLCModelArr;
}
-(NSMutableArray *)HLCImageArr
{
    if (!_HLCImageArr) {
        _HLCImageArr = [NSMutableArray array];
    }
    return _HLCImageArr;
}
-(NSMutableArray *)HLTModelArr
{
    if (!_HLTModelArr) {
        _HLTModelArr = [NSMutableArray array];
    }
    return _HLTModelArr;
}
#pragma mark ==== 初始化 ====

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:(UITableViewStyleGrouped)];
        self.tableV.dataSource = self;
        self.tableV.delegate = self;
        [self.tableV registerClass:[NewsType1TableViewCell class] forCellReuseIdentifier:@"tableCell"];
        [self.tableV registerNib:[UINib nibWithNibName:@"NewsType2TableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsType2Cell"];
        [self addSubview:self.tableV];
        [self requestData];
        
    }
    return self;
}


#pragma mark ==== 方法 ====

-(void)requestData
{
    [RequestManger requestWithURLString:KHeadlinesURL parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.topModel = [HeadLinesTopModel modelConfigWithJsDic:dic];
        self.HLTModelArr = [HeadLinesTableModel modelConfigWithJsDic:dic];
        self.HLCModelArr = [HeadLinesCarouselModel modelConfigWithJsonDic:dic];
        for (HeadLinesCarouselModel *HLCModel in self.HLCModelArr) {
            [self.HLCImageArr addObject:HLCModel.imgsrc];
        }
        self.carouselV = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH/4) imageURLs:self.HLCImageArr];
        
        __weak HeadlinesView *myself = self;
        myself.carouselV.imageClick = ^(NSInteger index)
        {
            HeadLinesCarouselModel *model = self.HLCModelArr[index];
            NSString *sss = model.url;
            NSArray *parameters = [sss componentsSeparatedByString:@"|"];
            NSString *parameter2 = [parameters lastObject];
            NSString *parameter1 = [[parameters firstObject] substringFromIndex:4];
        
            NewsThreeViewController *threeVC = [[NewsThreeViewController alloc]init];
            threeVC.parameter1 = parameter1;
            threeVC.parameter2 = parameter2;
            [myself.oneVC.navigationController pushViewController:threeVC animated:YES];
        };
        
        
        [self.tableV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"头条请求:%@",error);
    }];
}










#pragma mark ==== 协议 ==== 
// 头视图部分
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH/4)];
    headV.backgroundColor = [UIColor purpleColor];
    [headV addSubview:self.carouselV];
    return headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KScreenH/4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
// cell部分
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.HLTModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadLinesTableModel *model = self.HLTModelArr[indexPath.row];
    if (indexPath.row == 0) {
        NewsType1TableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
        cell1.lab1.text = self.topModel.title;
        cell1.lab2.text = self.topModel.tname;
        [cell1.imageV sd_setImageWithURL:[NSURL URLWithString:self.topModel.imgsrc] placeholderImage:placeHoldImageURL completed:nil];
        cell1.topBtn.hidden = NO;
        return cell1;
    }
    if (model.imgsrcArr.count) {
        NewsType2TableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"NewsType2Cell" forIndexPath:indexPath];
        cell2.lab1.text = model.title;
        cell2.lab2.text = model.source;
        cell2.lab3.text = [NSString stringWithFormat:@"%@跟帖",model.replyCount];
        [cell2.image3 sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:placeHoldImageURL completed:nil];
        [cell2.image1 sd_setImageWithURL:[NSURL URLWithString:model.imgsrcArr[0]] placeholderImage:placeHoldImageURL completed:nil];
        [cell2.image2 sd_setImageWithURL:[NSURL URLWithString:model.imgsrcArr[1]] placeholderImage:placeHoldImageURL completed:nil];
        return cell2;
    }else{
        NewsType1TableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
        cell1.lab1.text = model.title;
        cell1.lab2.text = model.source;
        [cell1.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:placeHoldImageURL completed:nil];
        cell1.topBtn.hidden = YES;
        return cell1;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        if (self.topModel.imgextra) {
            NSLog(@"0909090900%@",self.topModel.skipID);
            NewsThreeViewController *threeVC = [[NewsThreeViewController alloc]init];
            NSArray *parameters = [self.topModel.skipID componentsSeparatedByString:@"|"];
            NSString *parameter2 = [parameters lastObject];
            NSString *parameter1 = [[parameters firstObject] substringFromIndex:4];
            threeVC.parameter1 = parameter1;
            threeVC.parameter2 = parameter2;
            threeVC.boardid = self.topModel.boardid;
            threeVC.postid = self.topModel.postid;
            threeVC.replyCount = self.topModel.replyCount;
            [self.oneVC.navigationController pushViewController:threeVC animated:YES];
        }else{
            NewsTwoViewController *newTwoVC = [[NewsTwoViewController alloc]init];
            newTwoVC.docid = self.topModel.docid;
            newTwoVC.boardid = self.topModel.boardid;
            newTwoVC.replyCount = self.topModel.replyCount;
            [self.oneVC.navigationController pushViewController:newTwoVC animated:YES];
        }
    }else{
        HeadLinesTableModel *model = self.HLTModelArr[indexPath.row];
        if (model.skipID) {
            NewsThreeViewController *threeVC = [[NewsThreeViewController alloc]init];
            NSArray *parameters = [model.skipID componentsSeparatedByString:@"|"];
            NSString *parameter2 = [parameters lastObject];
            NSString *parameter1 = [[parameters firstObject] substringFromIndex:4];
            threeVC.parameter1 = parameter1;
            threeVC.parameter2 = parameter2;
            threeVC.boardid = model.boardid;
            threeVC.postid = model.postid;
            threeVC.replyCount = model.replyCount;
            [self.oneVC.navigationController pushViewController:threeVC animated:YES];
            
        }else{
            NewsTwoViewController *newTwoVC = [[NewsTwoViewController alloc]init];
            newTwoVC.docid = model.docid;
            newTwoVC.boardid = model.boardid;
            newTwoVC.replyCount = model.replyCount;
            [self.oneVC.navigationController pushViewController:newTwoVC animated:YES];
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadLinesTableModel *model = self.HLTModelArr[indexPath.row];
    if (model.imgsrcArr.count) {
        if (indexPath.row == 0) {
            return 100;
        }else{
            return 190;
        }
    }else{
        return 100;
    }
}








@end
