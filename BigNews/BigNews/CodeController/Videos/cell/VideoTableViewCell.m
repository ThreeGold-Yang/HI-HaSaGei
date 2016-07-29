//
//  VideoTableViewCell.m
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, KScreenW-20, 30)];
        [self.contentView addSubview:self.titleL];

        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, KScreenW-20, 200)];
        [self.contentView addSubview:self.imageV];
        
        self.playBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.playBtn.frame = CGRectMake((KScreenW-100)/2, 90, 100, 100);
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"music_icon_play_highlighted@2x"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.playBtn];
        
        self.authL = [[UILabel alloc]initWithFrame:CGRectMake(10, 250, 150, 20)];
        self.authL.font = [UIFont systemFontOfSize:15];
        self.authL.alpha = 0.5;
        [self.contentView addSubview:self.authL];
    }
    return self;
}

-(void)setModel:(RecommendModel *)model
{
    
    
    
    
    
    
    if (_model != model) {
        _model = model;
        self.titleL.text = model.title;
        self.authL.text = model.topicName;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:placeHoldImageURL completed:nil];
    }
}


















@end
