//
//  AnswerAndAskTableViewCell.h
//  BigNews
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDetailsModel.h"

@interface AnswerAndAskTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userHeadImg;
@property (strong, nonatomic) IBOutlet UILabel *userNameL;
@property (strong, nonatomic) IBOutlet UILabel *userAskL;
@property (strong, nonatomic) IBOutlet UIImageView *authHeadImg;
@property (strong, nonatomic) IBOutlet UILabel *authNameL;
@property (strong, nonatomic) IBOutlet UILabel *authAnswerL;
@property (strong, nonatomic) IBOutlet UILabel *timeL;
@property (strong, nonatomic) IBOutlet UILabel *talkNumL;
@property (strong, nonatomic) IBOutlet UIButton *zanBtn;

@property(nonatomic,strong) TopicDetailsModel *model;
@end
