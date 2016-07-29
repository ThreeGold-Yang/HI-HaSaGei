//
//  ShareView.m
//  BigNews
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.shareQQ = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.shareQQ.frame = CGRectMake(10, 0, (KScreenW-40)/3.0, 50);
        [self.shareQQ setTitle:@"分享QQ" forState:(UIControlStateNormal)];
        [self addSubview:self.shareQQ];
        
        self.shareSina = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.shareSina.frame = CGRectMake(20+(KScreenW-40)/3.0, 0, (KScreenW-40)/3.0, 50);
        [self.shareSina setTitle:@"分享新浪" forState:(UIControlStateNormal)];
        [self addSubview:self.shareSina];
        
        self.shareWX = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.shareWX.frame = CGRectMake(30+(KScreenW-40)*2/3.0, 0, (KScreenW-40)/3.0, 50);
        [self.shareWX setTitle:@"分享WX" forState:(UIControlStateNormal)];
        [self addSubview:self.shareWX];
        
    }
    return self;
}




@end
