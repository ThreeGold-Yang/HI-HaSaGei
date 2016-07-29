//
//  TitleBarCollectionViewCell.m
//  BigNews
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TitleBarCollectionViewCell.h"

@implementation TitleBarCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleL = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleL.frame = self.contentView.frame;
    self.titleL.textAlignment = 1;
    self.titleL.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 30);
}






@end
