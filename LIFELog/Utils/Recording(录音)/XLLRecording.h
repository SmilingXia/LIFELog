//
//  XLLRecording.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLLRecordingDelegate <NSObject>

/**
 录音完成 - 回调
 */
- (void)recordingDidFinishRecording;

/**
 保存完成 - 保存是否成功 - YES成功 - NO失败
 */
- (void)saveRecordingIsSuccess:(BOOL)isSuccess;

@end

@interface XLLRecording : NSObject

@property (nonatomic, weak) id<XLLRecordingDelegate> recordingDelegate;

/**
 开始录制
 */
- (void)startRecording;

/**
 暂停录制
 */
- (void)pauseRecording;

/**
 恢复录制
 */
- (void)recordRecording;

/**
 结束录制
 */
- (void)stopRecording;

/**
 是否保存 - YES保存反之
 */
- (void)saveFileWithTitle:(NSString *)titleString andCoverName:(NSString *)coverName andDescribe:(NSString *)describe isSave:(BOOL)isSave;

@end
