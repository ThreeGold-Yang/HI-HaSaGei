//
//  CYVideoPlayerView.m
//  CYVideoPlayer
//
//  Created by dongzb on 16/2/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYVideoPlayerView.h"
#import "CYVideoToolBar.h"
static const NSString *PlayerItemStatusContext;
static const NSString *PlayerItemLoadedTimeRangesContext;
@interface CYVideoPlayerView  ()<CYVideoToolBarDelegate>
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@property (nonatomic,strong) NSTimer *progressTimer;
@end

@implementation CYVideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 封面
        self.imageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            [imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"bg_media_default"]];
            imageView;
        });
        // 底部工具条
        self.toolBarView = ({
            CYVideoToolBar *toolBar = [[CYVideoToolBar alloc] init];
            toolBar.delegate = self;
            [self addSubview:toolBar];
            [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self);
                make.height.mas_equalTo(50);
            }];
            toolBar;
        });
        self.player = [[AVPlayer alloc] init];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.imageView.layer addSublayer:self.playerLayer];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.toolBarView.hidden = ! self.toolBarView.hidden;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}
/**
 *  替换一个播放的 item
 */
- (void)replaceAVPlayerItem:(AVPlayerItem*)playerItem
{
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self.player play];
    [self addPlayerItemObserverWith:playerItem];
    [self addNotification];
    self->_playerItem = playerItem;
}
#pragma mark - 定时器操作
/**
 *  添加定时器
 */
- (void)addProgressTimer
{
    [self removeProgressTimer];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
    [self.progressTimer fire];
}
/**
 *  移除定时器
 */
- (void)removeProgressTimer
{
    if (self.progressTimer) {
        [self.progressTimer invalidate];
        self.progressTimer = nil;
    }
}
- (void)updateProgressInfo{
    if (!self.isPlaying) return;
    // 1.更新时间
    self.toolBarView.timeLabel.text = [self updateTimeString];
    double currentTime = CMTimeGetSeconds(self.player.currentTime);
    // 2.设置进度条的value
    self.toolBarView.playerSlider.value = currentTime;
}
#pragma mark - 讲当前时间转成时间戳给label显示
- (NSString*)updateTimeString
{
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    return [self stringWithCurrentTime:currentTime duration:duration];
}
- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration
{
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", dMin, dSec];
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", cMin, cSec];
    return [NSString stringWithFormat:@"%@/%@", currentString, durationString];
}
#pragma mark - KVO 观察AVPlayerItme的属性
/**
 *  添加观察者开始观察 AVPlayer 的状态
 */
- (void)addPlayerItemObserverWith:(AVPlayerItem*)playerItem
{
    [self removePlayerItemObserver];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:&PlayerItemStatusContext];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:&PlayerItemLoadedTimeRangesContext];
}
/**
 *  移除观察者不再观察 AVPlayer 的状态
 */
- (void)removePlayerItemObserver
{
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        self->_playerItem = nil;
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == &PlayerItemStatusContext) {
        if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
            double durition = CMTimeGetSeconds(self.playerItem.duration);
            self.toolBarView.playerSlider.maximumValue = durition;
            NSLog(@"可以正常播放视频");
            self->_playing = YES;
            [self addProgressTimer];
        }else if (self.playerItem.status == AVPlayerItemStatusUnknown) {
            NSLog(@"未知状态");
        }else if (self.playerItem.status == AVPlayerItemStatusFailed) {
            NSLog(@"--> %@",self.playerItem.error.localizedDescription);
        }
    }else if (context == &PlayerItemLoadedTimeRangesContext) {
        
    }
}
#pragma mark - 监听播放器播放结束的通知
/**
 *  添加通知
 */
- (void)addNotification
{
    [self removeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerEndPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
}
/**
 *  移除通知
 */
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  播放结束时的通知
 */
- (void)playerEndPlay:(NSNotification*)noti
{
    NSLog(@"播放结束了");
    [self.player pause];
    self->_playing = NO;
    [self removeAllObserver];
}
- (void)removeAllObserver
{
    [self removePlayerItemObserver];
    [self removeNotification];
    [self removeProgressTimer];
}

#pragma mark - CYVideoToolBarDelegate
/** <点击了底部工具条上的播放/暂停按钮> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar didPlayVideo:(BOOL)isPlay
{
    if (isPlay) {
        [self.player play];
        self->_playing = YES;
    }else{
        [self.player pause];
        self->_playing = NO;
    }
}
/** <是否全屏播放视频> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar shouldFullScreen:(BOOL)isFull
{
    if ([self.delegate respondsToSelector:@selector(cyVideoToolBarView:shouldFullScreen:)]) {
        [self.delegate cyVideoToolBarView:self.toolBarView shouldFullScreen:isFull];
    }
}
/** <开始拖到滑块> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar didDragSlider:(UISlider *)slider
{
    [self.player pause];
    self->_playing = NO;
}
/** <松开滑块继续播放> */

- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar didReplayVideo:(UISlider *)slider
{
    [self.player play];
    self->_playing = YES;
}
/** <改变滑块的当前值> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar didChangeValue:(UISlider*)slider
{
    double currentTime = (double)(slider.value);
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
- (void)dealloc
{
    [self removeAllObserver];
}
@end
