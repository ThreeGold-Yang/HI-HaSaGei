//
//  NewsOneViewController.m
//  BigNews
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "NewsOneViewController.h"
#import "TitleBarCollectionViewCell.h"

#import "HeadlinesView.h"


@interface NewsOneViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) NSArray *titleBarArr;
@property(nonatomic,strong) NSArray *viewColorArr;

@property(nonatomic,strong) UICollectionView *titleBarV;
@property(nonatomic,strong) UIScrollView *newsContentV;
@property(nonatomic,strong) HeadlinesView *headlineV;


@property(nonatomic,assign) NSInteger index; //判断标题栏哪个被点击


@end

@implementation NewsOneViewController


#pragma mark ==== ViewDidLoad ====
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBarArr = @[@"头条",@"NBA",@"手机",@"娱乐",@"时尚",@"电影",@"移动互联",@"科技"];
    self.viewColorArr = @[[UIColor redColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor blueColor],[UIColor grayColor],[UIColor greenColor],[UIColor yellowColor],[UIColor brownColor]];
    
    self.index = 0;
    [self creatNewsView];
    [self creatNewsContentView];
}




#pragma mark ==== 方法 ====
-(void)creatNewsView
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
    
    // 新闻内容 (滚动视图:预计高度 KScreenH-160)
    self.newsContentV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 91, KScreenW, KScreenH-140)];
    self.newsContentV.backgroundColor = [UIColor whiteColor];
    self.newsContentV.contentSize = CGSizeMake(8 * KScreenW, 0);
    self.newsContentV.pagingEnabled = YES;
    self.newsContentV.delegate = self;
    [self.view addSubview:self.newsContentV];
    
    // 循环创建每个标题对应的 view
    for (int i = 0; i < 8; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(KScreenW*i, 0, KScreenW, self.newsContentV.bounds.size.height)];
        view.tag = i+100;
        view.backgroundColor = self.viewColorArr[i];
        [self.newsContentV addSubview:view];
    }
}

-(void)creatNewsContentView
{
    self.headlineV = [[HeadlinesView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-140)];
    [self.newsContentV addSubview:self.headlineV];
    self.headlineV.oneVC = self;
}







#pragma mark ==== 协议 ====
// **** collectionView协议 ****
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8; // 标题个数
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleBarCell" forIndexPath:indexPath];
    cell.titleL.text = self.titleBarArr[indexPath.row];
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
    [self.newsContentV setContentOffset:CGPointMake(indexPath.row * KScreenW, 0) animated:YES];
    [self.titleBarV reloadData];
}



// **** tableView协议 ****







// **** scrollView协议 ****
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.newsContentV) {
        self.index = scrollView.contentOffset.x / KScreenW;
        [self.titleBarV setContentOffset:CGPointMake((KScreenW-30)*((scrollView.contentOffset.x/KScreenW))/4.0, 0) animated:YES];
        if (scrollView.contentOffset.x > 4*KScreenW) {
            [self.titleBarV setContentOffset:CGPointMake(KScreenW, 0) animated:YES];
        }
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
