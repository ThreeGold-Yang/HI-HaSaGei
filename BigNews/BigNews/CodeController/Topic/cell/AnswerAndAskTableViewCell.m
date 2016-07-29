//
//  AnswerAndAskTableViewCell.m
//  BigNews
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "AnswerAndAskTableViewCell.h"

@implementation AnswerAndAskTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(TopicDetailsModel *)model
{
    if (_model != model) {
        _model = model;
        [self.userHeadImg sd_setImageWithURL:[NSURL URLWithString:model.userHeadPicUrl] placeholderImage:placeHoldImageURL completed:nil];
        self.userNameL.text = model.userName;
        self.userAskL.text = model.questioncontent;
        
        [self.authHeadImg sd_setImageWithURL:[NSURL URLWithString:model.specialistHeadPicUrl] placeholderImage:placeHoldImageURL completed:nil];
        self.authNameL.text = model.specialistName;
        self.authAnswerL.text = model.answercontent;
        self.talkNumL.text = [NSString stringWithFormat:@"💬%@",model.replyCount];
        [self.zanBtn setTitle:[NSString stringWithFormat:@"👐%@",model.supportCount] forState:(UIControlStateNormal)];
        self.timeL.hidden = YES;
    }
}






@end
