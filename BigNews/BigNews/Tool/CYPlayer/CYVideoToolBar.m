//
//  CYViewToolBar.m
//  CYVideoPlayer
//
//  Created by dongzb on 16/2/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYVideoToolBar.h"

@implementation CYVideoToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景 view
        self.bottomView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor blackColor];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            view;
        });
        // 播放按钮
        self.playBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"full_pause_btn_hl"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"full_play_btn_hl"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(self.bottomView);
                make.width.height.mas_equalTo(50);
            }];
            btn ;
        });
        // 全屏的按钮
        self.fullBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"mini_launchFullScreen_btn_hl"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"full_minimize_btn_hl"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(fullBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.equalTo(self.bottomView);
                make.width.height.mas_equalTo(50);
            }];
            btn ;
        });
        // 进度条的滑块
        self.playerSlider = [[UISlider alloc] init];
        [self.bottomView addSubview:self.playerSlider];
        // 显示时间的 label
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.text = @"00:30/03:55";
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor whiteColor];
        [self.bottomView addSubview:self.timeLabel];
        // 添加约束
        [self.playerSlider mas_updateConstraints:^(MASConstraintMaker *make) {
            make.removeExisting = YES;
            make.top.bottom.equalTo(self.fullBtn);
            make.left.equalTo(self.playBtn.mas_right).offset(10);
            make.right.equalTo(self.timeLabel.mas_left).offset(-10);
        }];
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.removeExisting = YES;
            make.top.bottom.equalTo(self.playerSlider);
            make.right.equalTo(self.fullBtn.mas_left);
            make.width.mas_equalTo(100);
        }];
        [self.playerSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
        [self.playerSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
        [self.playerSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
        
        [self.playerSlider addTarget:self action:@selector(didDragSlider:) forControlEvents:UIControlEventTouchDown];
        [self.playerSlider addTarget:self action:@selector(didReplay:) forControlEvents:UIControlEventTouchUpInside];
        [self.playerSlider addTarget:self action:@selector(didReplay:) forControlEvents:UIControlEventTouchUpOutside];
        [self.playerSlider addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)playBtnClick:(UIButton*)playBtn
{
    playBtn.selected = !playBtn.selected;
    if ([self.delegate respondsToSelector:@selector(cyVideoToolBarView:didPlayVideo:)]) {
        [self.delegate cyVideoToolBarView:self didPlayVideo:!playBtn.selected];
    }
}

- (void)fullBtnClick:(UIButton*)fullBtn
{
    fullBtn.selected = !fullBtn.selected;
    if ([self.delegate respondsToSelector:@selector(cyVideoToolBarView:shouldFullScreen:)]) {
        [self.delegate cyVideoToolBarView:self shouldFullScreen:fullBtn.selected];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - 监听滑块的一些事件

- (void)didDragSlider:(UISlider*)playerSlider
{
    self.playBtn.selected = YES;
    if ([self.delegate respondsToSelector:@selector(cyVideoToolBarView:didDragSlider:)]) {
        [self.delegate cyVideoToolBarView:self didDragSlider:playerSlider];
    }
}
- (void)didReplay:(UISlider*)playerSlider
{
    self.playBtn.selected = !self.playBtn.selected;
    if ([self.delegate respondsToSelector:@selector(cyVideoToolBarView:didReplayVideo:)]) {
        [self.delegate cyVideoToolBarView:self didReplayVideo:playerSlider];
    }
}
- (void)didChangeValue:(UISlider*)playerSlider
{
    if ([self.delegate respondsToSelector:@selector(cyVideoToolBarView:didChangeValue:)]) {
        [self.delegate cyVideoToolBarView:self didChangeValue:playerSlider];
    }
}
@end
