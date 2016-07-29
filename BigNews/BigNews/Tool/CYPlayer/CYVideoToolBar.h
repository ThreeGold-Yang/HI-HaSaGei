//
//  CYViewToolBar.h
//  CYVideoPlayer
//
//  Created by dongzb on 16/2/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYVideoToolBar;
NS_ASSUME_NONNULL_BEGIN

@protocol CYVideoToolBarDelegate <NSObject>

@optional

/** <点击了底部工具条上的播放/暂停按钮> */
- (void)cyVideoToolBarView:(CYVideoToolBar*)cyVideoToolBar didPlayVideo:(BOOL)isPlay;
/** <是否全屏播放视频> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar shouldFullScreen:(BOOL)isFull;
/** <开始拖到滑块> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar didDragSlider:(UISlider*)slider;
/** <松开滑块继续播放> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar didReplayVideo:(UISlider*)slider;
/** <改变滑块的当前值> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar didChangeValue:(UISlider*)slider;
@end

/** < 播放器底部的控制面板 > */

@interface CYVideoToolBar : UIView
/** < 控制条背景图片 > */
@property (nonatomic,strong) UIView *bottomView;
/** <播放的按钮> */
@property (nonatomic,strong) UIButton *playBtn;
/** < 滑块 > */
@property (nonatomic,strong) UISlider *playerSlider;
/** < 全屏或半屏的按钮 > */
@property (nonatomic,strong) UIButton *fullBtn;
/** < timeLabel > */
@property (nonatomic,strong) UILabel *timeLabel;

/** <delegate> */
@property(nonatomic,weak) id<CYVideoToolBarDelegate>delegate;

NS_ASSUME_NONNULL_END

@end
