//
//  ClassificationOneCollectionViewCell.m
//  有妖气
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ClassificationOneCollectionViewCell.h"

@implementation ClassificationOneCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.titleL = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.contentView.bounds.size.width;
    CGFloat h = self.contentView.bounds.size.height;
    self.imageV.frame = CGRectMake(0, 0, w, h*4/5);
    self.imageV.backgroundColor = [UIColor redColor];
    self.titleL.frame = CGRectMake(0, h*4/5, w, h/5);
    self.titleL.textAlignment = 1;
    self.titleL.backgroundColor = [UIColor orangeColor];
}

-(void)setModel:(ClassificationOneModel *)model
{
    if (_model != model) {
        _model = model;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:placeHoldImageURL completed:nil];
        self.titleL.text = model.sortName;
    }
}


@end
