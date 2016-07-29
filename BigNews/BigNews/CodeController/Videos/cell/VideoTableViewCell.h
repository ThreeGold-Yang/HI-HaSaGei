//
//  VideoTableViewCell.h
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface VideoTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *authL;
@property(nonatomic,strong) RecommendModel *model;
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) UIButton *playBtn;
@end
