//
//  TopicFirstTableViewCell.h
//  BigNews
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
@interface TopicFirstTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *nickL;
@property (strong, nonatomic) IBOutlet UILabel *typeL;
@property (strong, nonatomic) IBOutlet UIImageView *conImg;
@property (strong, nonatomic) IBOutlet UILabel *conL;
@property (strong, nonatomic) IBOutlet UILabel *classificationL;
@property (strong, nonatomic) IBOutlet UILabel *fouL;
@property (strong, nonatomic) IBOutlet UILabel *askL;

@property(nonatomic,strong) TopicModel *model;

@end
