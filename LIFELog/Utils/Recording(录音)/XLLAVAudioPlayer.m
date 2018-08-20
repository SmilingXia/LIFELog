//
//  XLLAVAudioPlayer.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/18.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface XLLAVAudioPlayer()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer     *audioPlayer;

@property (nonatomic, strong) NSTimer           *playerTimer;

@end

@implementation XLLAVAudioPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 播放音频
 */
- (void)audioPlayerPlay:(NSString *)filePath {
    
    // 判断将要播放文件是否存在
    NSURL *urlFile = [NSURL fileURLWithPath:filePath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlFile error:nil];
    NSString *durationString = [NSString stringWithFormat:@"%ld",(NSInteger)self.audioPlayer.duration];
    [self protocolCallbackOneValue:@"总时间" twoValue:durationString];
    self.audioPlayer.delegate = self;
    if (self.audioPlayer) {
        if ([self.audioPlayer prepareToPlay]) {
            // 播放时，设置喇叭播放否则音量很小
            AVAudioSession *playSession = [AVAudioSession sharedInstance];
            [playSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            [playSession setActive:YES error:nil];
            [self.audioPlayer play];
            [self turnOffThePlayerTimer];
            self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(playerTimerAction) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.playerTimer forMode:NSRunLoopCommonModes];
        }
    }
}

/**
 * 关闭定时器
 * 清除视频播放器 - 不管是切换视频 - 退出控制器 - 都必须执行该方法
 */
- (void)turnOffThePlayerTimer{
    if ([_playerTimer isValid]) {
        [_playerTimer invalidate];
        _playerTimer = nil;
    }
}

- (void)play {
    [self.audioPlayer play];
}

- (void)pause {
    [self.audioPlayer pause];
}

- (void)stop {
    [self.audioPlayer stop];
    [self turnOffThePlayerTimer];
}

- (void)dealloc {
    NSLog(@"播放已销毁");
}

#pragma mark -
#pragma mark    delegate

- (void)playerTimerAction {
    NSString *currentTimeString = [NSString stringWithFormat:@"%ld",(NSInteger)self.audioPlayer.currentTime + 1];
    [self protocolCallbackOneValue:@"进度时间" twoValue:currentTimeString];
}

/**
 播放 - 完毕
 */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self protocolCallbackOneValue:@"播放完毕" twoValue:@""];
}


@end
