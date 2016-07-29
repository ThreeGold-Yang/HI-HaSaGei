//
//  NewsTalkTableViewCell.h
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTalkModel.h"
#import "VideoTalkModel.h"
#import "RowModel.h"
@interface NewsTalkTableViewCell : UITableViewCell

// 热评cell
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *nickNameL;
@property(nonatomic,strong) UILabel *timeL;
@property(nonatomic,strong) UILabel *fowL;
@property(nonatomic,strong) UILabel *contentL;

@property(nonatomic,strong) HotTalkModel *model;
@property(nonatomic,strong) VideoTalkModel *videoTalkModel;
@property(nonatomic,strong) RowModel *rowModel;
@end
