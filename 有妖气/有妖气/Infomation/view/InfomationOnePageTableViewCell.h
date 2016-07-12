//
//  InfomationOnePageTableViewCell.h
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfomationOneModel.h"
@interface InfomationOnePageTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *infomationTitleL;
@property(nonatomic,strong) UIImageView *infomationImageV;
@property(nonatomic,strong) UILabel *infomationAuthL;
@property(nonatomic,strong) UIImageView *handImageV;
@property(nonatomic,strong) UIImageView *talkImageV;
@property(nonatomic,strong) UILabel *handNumL;
@property(nonatomic,strong) UILabel *talkNumL;

@property(nonatomic,strong) InfomationOneModel *model;
@end
