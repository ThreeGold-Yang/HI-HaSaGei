//
//  VideoOneViewController.m
//  BigNews
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "VideoOneViewController.h"
#import "TitleBarCollectionViewCell.h"
#import "RecommendedView.h"
#import "VideoTitleBarModel.h"


@interface VideoOneViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) NSMutableArray *titleBarArr;

@property(nonatomic,strong) UICollectionView *titleBarV;
@property(nonatomic,strong) UIScrollView *videoContentV;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) NSMutableArray *mytids;
@property(nonatomic,strong) RecommendedView *recommendV;
@end

@implementation VideoOneViewController

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)titleBarArr
{
    if (!_titleBarArr) {
        _titleBarArr = [NSMutableArray array];
    }
    return _titleBarArr;
}
-(NSMutableArray *)mytids
{
    if (!_mytids) {
        _mytids = [NSMutableArray array];
    }
    return _mytids;
}
#pragma mark ==== view ====
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    [self creatVideoView];
    [self requestTitleBarData];
    
}



#pragma mark ==== 方法 ====
-(void)creatVideoView
{
    // 创建标题栏 (集合视图:预计高度 30)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((KScreenW-30)/4.0, 30);
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.titleBarV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, KScreenW, 30) collectionViewLayout:layout];
    self.titleBarV.dataSource = self;
    self.titleBarV.delegate = self;
    self.titleBarV.showsHorizontalScrollIndicator = NO;
    self.titleBarV.backgroundColor = [UIColor whiteColor];
    [self.titleBarV registerClass:[TitleBarCollectionViewCell class] forCellWithReuseIdentifier:@"titleBarCell"];
    [self.view addSubview:self.titleBarV];
    
    // 横线
    UIView *verV = [[UIView alloc]initWithFrame:CGRectMake(0, 90, KScreenW, 1)];
    verV.backgroundColor = [UIColor blackColor];
    [self.view addSubview:verV];

    // 视频内容 (滚动视图:预计高度 KScreenH-160)
    self.videoContentV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 91, KScreenW, KScreenH-140)];
    self.videoContentV.backgroundColor = [UIColor whiteColor];
    self.videoContentV.pagingEnabled = YES;
    self.videoContentV.delegate = self;
    [self.view addSubview:self.videoContentV];

}

-(void)requestTitleBarData
{
    NSString *url = @"http://c.m.163.com/nc/video/topiclist.html";
    [RequestManger requestWithURLString:url parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.titleBarArr = [VideoTitleBarModel modelConfigWithJsonDic:jsonArr];
        for (VideoTitleBarModel *model in self.titleBarArr) {
            [self.mytids addObject:model.tid];
        }
        [self creatRecommendV];
        self.videoContentV.contentSize = CGSizeMake(self.titleBarArr.count * KScreenW, 0);
        [self.titleBarV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)creatRecommendV
{
    self.recommendV = [[RecommendedView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-140)];
    self.recommendV.videoOneVC = self;
    self.recommendV.mytid = self.mytids[0];
    [self.videoContentV addSubview:self.recommendV];
}







#pragma mark ==== 点击方法 ====




#pragma mark ==== 协议 ====
// **** collectionView协议 ****
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleBarArr.count; // 标题个数
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleBarCell" forIndexPath:indexPath];
    VideoTitleBarModel *model = self.titleBarArr[indexPath.row];
    cell.titleL.text = model.tname;
    if (self.index == indexPath.row) {
        cell.titleL.textColor = [UIColor redColor];
    }else{
        cell.titleL.textColor = [UIColor blackColor];
    }
    cell.titleL.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = indexPath.row;
    [self.videoContentV setContentOffset:CGPointMake(indexPath.row * KScreenW, 0) animated:YES];
    [self.titleBarV reloadData];
}

// **** scrollView协议 ****
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.videoContentV) {
        self.index = scrollView.contentOffset.x / KScreenW;
        [self.titleBarV setContentOffset:CGPointMake((KScreenW-30)*((scrollView.contentOffset.x/KScreenW))/4.0, 0) animated:YES];
        [self.titleBarV reloadData];
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
