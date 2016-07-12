//
//  ClassificationView.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ClassificationView.h"
#import "ClassificationOneModel.h"
#import "ClassificationOneCollectionViewCell.h"
#import "ClassificationTwoViewController.h"

@interface ClassificationView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) NSMutableArray *classificationOneArr;
@end

@implementation ClassificationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSMutableArray *)classificationOneArr
{
    if (!_classificationOneArr) {
        _classificationOneArr = [NSMutableArray array];
    }
    return _classificationOneArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((KScreenW-40)/3, 150);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        self.classfConllectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-49) collectionViewLayout:layout];
        self.classfConllectionV.backgroundColor = [UIColor whiteColor];
        self.classfConllectionV.dataSource = self;
        self.classfConllectionV.delegate = self;
        [self.classfConllectionV registerClass:[ClassificationOneCollectionViewCell class] forCellWithReuseIdentifier:@"classificationOneCell"];
        [self addSubview:self.classfConllectionV];
        [self requestData];
    }
    return self;
}

-(void)requestData
{
    [RequestManger requestWithURLString:categoryURL parDic:nil requestType:RequestGET sucess:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.classificationOneArr = [ClassificationOneModel modelconfigWith:dic];
        [self.classfConllectionV reloadData];
    } falure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.classificationOneArr.count;
    //return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classificationOneCell" forIndexPath:indexPath];
    ClassificationOneModel *model = self.classificationOneArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationOneModel *model = self.classificationOneArr[indexPath.row];
    ClassificationTwoViewController *classTwoVC = [[ClassificationTwoViewController alloc]init];
    classTwoVC.argName = model.argName;
    classTwoVC.argValue = model.argValue;
    [self.classVC.navigationController pushViewController:classTwoVC animated:YES];
}







@end
