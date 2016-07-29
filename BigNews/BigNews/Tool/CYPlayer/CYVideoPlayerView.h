//
//  CYVideoPlayerView.h
//  CYVideoPlayer
//
//  Created by dongzb on 16/2/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class CYVideoToolBar;
@class CYVideoPlayerView;
NS_ASSUME_NONNULL_BEGIN
@protocol CYVideoPlayerDelegate <NSObject>

@optional

/** <是否全屏播放视频> */
- (void)cyVideoToolBarView:(CYVideoToolBar *)cyVideoToolBar shouldFullScreen:(BOOL)isFull;

@end

/** <播放器的view> */
@interface CYVideoPlayerView : UIView
/** <封面图片> */
@property (nonatomic,strong) UIImageView *imageView;
/** <底部工具条> */
@property (nonatomic,strong) CYVideoToolBar *toolBarView;
/** < player > */
@property (nonatomic,strong) AVPlayer *player;
/** <playerItem> */
@property (nonatomic,strong,readonly) AVPlayerItem *playerItem;
/** <delegate> */
@property(nonatomic,weak) id<CYVideoPlayerDelegate>delegate;
/** <播放器播放状态> */
@property (nonatomic,assign,getter=isPlaying,readonly) BOOL playing;
/** <切换一个播放的 item> */
- (void)replaceAVPlayerItem:(AVPlayerItem*)playerItem;

NS_ASSUME_NONNULL_END
@end
