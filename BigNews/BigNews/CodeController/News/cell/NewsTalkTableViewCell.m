//
//  NewsTalkTableViewCell.m
//  BigNews
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "NewsTalkTableViewCell.h"

@implementation NewsTalkTableViewCell

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
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.nickNameL = [[UILabel alloc]init];
        [self.contentView addSubview:self.nickNameL];
        
        self.fowL = [[UILabel alloc]init];
        [self.contentView addSubview:self.fowL];
        
        self.timeL = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeL];
        
        self.contentL = [[UILabel alloc]init];
        self.contentL.numberOfLines = 0;
        self.contentL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.contentL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(10, 10, KScreenW/10, KScreenW/10);
    
    self.nickNameL.frame = CGRectMake(20+KScreenW/10, 10, 200, 20);
    self.nickNameL.font = [UIFont systemFontOfSize:18];
    
    self.fowL.frame = CGRectMake(KScreenW-110, 20, 100, 20);
    self.fowL.font = [UIFont systemFontOfSize:12];
    self.fowL.textAlignment = 1;
    self.fowL.alpha = 0.5;
    
    self.timeL.frame = CGRectMake(20+KScreenW/10, 35, 0, 20);
    self.timeL.font = [UIFont systemFontOfSize:12];
    self.timeL.alpha = 0.5;
    [self.timeL sizeToFit];
    
    CGFloat h = [justHeight justHeightBy:self.contentL.text font:15 width:KScreenW-30-KScreenW/10];
    self.contentL.frame = CGRectMake(20+KScreenW/10, 65, KScreenW-10-20-KScreenW/10, h);
}

-(void)setModel:(HotTalkModel *)model
{
    if (_model != model) {
        _model = model;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.timg] placeholderImage:placeHoldImageURL completed:nil];
        self.nickNameL.text = model.n;
        self.fowL.text = [NSString stringWithFormat:@"%@帖",model.v];
        self.timeL.text = model.t;
        self.contentL.text = model.b;
    }
}

-(void)setVideoTalkModel:(VideoTalkModel *)videoTalkModel
{
    if (_videoTalkModel != videoTalkModel) {
        _videoTalkModel = videoTalkModel;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:videoTalkModel.timg] placeholderImage:placeHoldImageURL completed:nil];
        self.nickNameL.text = videoTalkModel.n;
        self.fowL.text = [NSString stringWithFormat:@"%@帖",videoTalkModel.v];
        self.timeL.text = videoTalkModel.t;
        self.contentL.text = videoTalkModel.b;
    }
}

-(void)setRowModel:(RowModel *)rowModel
{
    if (_rowModel != rowModel) {
        _rowModel = rowModel;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:rowModel.timg] placeholderImage:placeHoldImageURL completed:nil];
        self.nickNameL.text = rowModel.n;
        self.fowL.text = [NSString stringWithFormat:@"%@帖",rowModel.v];
        self.timeL.text = rowModel.t;
        self.contentL.text = rowModel.b;
    }
}











@end
