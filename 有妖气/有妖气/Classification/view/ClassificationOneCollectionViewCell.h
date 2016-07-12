//
//  ClassificationOneCollectionViewCell.h
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificationOneModel.h"
@interface ClassificationOneCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) ClassificationOneModel *model;
@end
