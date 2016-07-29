//
//  TopicFirstTableViewCell.m
//  BigNews
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TopicFirstTableViewCell.h"

@implementation TopicFirstTableViewCell

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setModel:(TopicModel *)model
{
    if (_model != model) {
        _model = model;
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.headpicurl] placeholderImage:placeHoldImageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.headImg.image = [UIImage circleImageWithBorder:4 color:[UIColor whiteColor] image:image];
        }];
        self.nickL.text = [NSString stringWithFormat:@"%@ |",model.name];
        [self.conImg sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:placeHoldImageURL completed:nil];
        self.typeL.text = model.title;
        self.conL.text = model.alias;
        self.classificationL.text = model.classification;
        self.fouL.text = [NSString stringWithFormat:@"%@ 关注",model.concernCount];
        self.askL.text = [NSString stringWithFormat:@"%@ 提问",model.questionCount];
    }
}
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        





@end
