//
//  NewsType1TableViewCell.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "NewsType1TableViewCell.h"

@implementation NewsType1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 1 * image + 2 * lab 类型

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.lab1 = [[UILabel alloc]init];
        self.lab1.numberOfLines = 2;
        [self.contentView addSubview:self.lab1];
        
        self.lab2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab2];
        
        self.topBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.contentView addSubview:self.topBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(10, 10, KScreenW/4, 80);
    self.lab1.frame = CGRectMake(KScreenW/4 + 20, 10, KScreenW - 30 - KScreenW/4, 50);
    self.lab2.frame = CGRectMake(KScreenW/4 + 20, 70, 0, 30);
    self.lab2.alpha = 0.5;
    self.lab2.font = [UIFont systemFontOfSize:15];
    [self.lab2 sizeToFit];
    self.topBtn.frame = CGRectMake(KScreenW-60, 65, 50, 30);
    [self.topBtn setTitle:@"置顶" forState:(UIControlStateNormal)];
}



@end
