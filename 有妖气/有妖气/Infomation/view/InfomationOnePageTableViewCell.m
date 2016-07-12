//
//  InfomationOnePageTableViewCell.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "InfomationOnePageTableViewCell.h"

@implementation InfomationOnePageTableViewCell

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
        self.infomationTitleL = [[UILabel alloc]init];
        [self.contentView addSubview:self.infomationTitleL];
        
        self.infomationImageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.infomationImageV];
        
        self.infomationAuthL = [[UILabel alloc]init];
        [self.contentView addSubview:self.infomationAuthL];
        
        self.handImageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.handImageV];
        
        self.handNumL = [[UILabel alloc]init];
        [self.contentView addSubview:self.handNumL];
        
        self.talkImageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.talkImageV];
        
        self.talkNumL = [[UILabel alloc]init];
        [self.contentView addSubview:self.talkNumL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.infomationTitleL.frame = CGRectMake(10, 5, KScreenW-20, 20);
    self.infomationImageV.frame = CGRectMake(10, 30, KScreenW -20, (KScreenW-20)*13/32);
    
    self.infomationAuthL.font = [UIFont systemFontOfSize:15];
    self.infomationAuthL.frame = CGRectMake(10, 30+(KScreenW-20)*13/32+10, 0, 20);
    [self.infomationAuthL sizeToFit];
    
    self.handImageV.frame = CGRectMake(KScreenW-160, 30+(KScreenW-20)*13/32+10, 20, 20);
    self.handImageV.image = [UIImage imageNamed:@"hand"];
    self.handNumL.frame = CGRectMake(KScreenW-140, 30+(KScreenW-20)*13/32+10, 50, 20);
    self.talkImageV.frame = CGRectMake(KScreenW-90, 30+(KScreenW-20)*13/32+10, 20, 20);
    self.talkImageV.image = [UIImage imageNamed:@"talkk"];
    self.talkNumL.frame = CGRectMake(KScreenW-70, 30+(KScreenW-20)*13/32+10, 50, 20);
}

-(void)setModel:(InfomationOneModel *)model
{
    if (_model != model) {
        _model = model;
        self.infomationTitleL.text = model.title;
        [self.infomationImageV sd_setImageWithURL:[NSURL URLWithString:model.imglink] placeholderImage:placeHoldImageURL completed:nil];
        self.infomationAuthL.text = model.author;
        self.handNumL.text = [NSString stringWithFormat:@"%@",model.likecount];
        self.talkNumL.text = [NSString stringWithFormat:@"%@",model.talkcount];
    }
}




@end
