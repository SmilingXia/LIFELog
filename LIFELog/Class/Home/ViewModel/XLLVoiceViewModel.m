//
//  XLLVoiceViewModel.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLVoiceViewModel.h"
#import "XLLRecording.h"

@interface XLLVoiceViewModel()<XLLRecordingDelegate>

@property (nonatomic, strong) XLLRecording      *recording;    //录音功能
@property (nonatomic, copy) NSString            *recordingCoverName;

@end

@implementation XLLVoiceViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -
#pragma mark    NSNotificationDelegate -- 通知回调

#pragma mark -
#pragma mark    delegate

/**
 开始录音
 */
- (void)stateBeganAction {
    if (_recording) {
        _recording = nil;
    }
    _recording = [[XLLRecording alloc] init];
    _recording.recordingDelegate = self;
    [_recording startRecording];
}

/**
 结束录音
 */
- (void)stateEndedAction {
    [_recording stopRecording];
}

//录音结束 - 进行保存操作
- (void)recordingDidFinishRecording {
    //1.显示信息弹窗 -
    [self protocolCallbackValue:@"显示信息弹窗"];
}

/**
 录音文件是否保存成功

 @param isSuccess yes成功 - no失败
 */
- (void)saveRecordingIsSuccess:(BOOL)isSuccess {
    if (!isSuccess) {
        [self showAlertViewWithMessige:@"保存失败"];
    }
    [self protocolCallbackValue:@"清空录入信息"];
}

#pragma mark -
#pragma mark    event



#pragma mark -
#pragma mark    method

/**
 语音日志数据源
 */
- (NSMutableArray *)getVoiceTableViewDataSourceArray {
    NSString *plistFilePath         = [[XLLFilePathManage instanceFilePathManage] getRecordingFilePathPlist];
    NSMutableArray *plistFileArray  = [[NSMutableArray alloc] initWithContentsOfFile:plistFilePath];
    if (!plistFileArray) {
        plistFileArray = [NSMutableArray array];
    }
    return plistFileArray;
}

/**
 设置封面昵称
 */
- (void)setCoverName:(NSString *)coverName {
    self.recordingCoverName = coverName;
}

/**
 是否保存 - YES保存反之
 */
- (void)saveFileWithTitle:(NSString *)titleString andDescribe:(NSString *)describe isSave:(BOOL)isSave {
    
    if ([titleString isEqualToString:@""] || titleString == nil) {
        titleString = @"你很懒-什么都没留下";
    }
    if (isSave) {
        [_recording saveFileWithTitle:titleString andCoverName:self.recordingCoverName andDescribe:describe isSave:YES];
    }
    else{
        [_recording saveFileWithTitle:titleString andCoverName:self.recordingCoverName andDescribe:describe isSave:NO];
    }
}


#pragma mark -
#pragma mark    getter/setter

@end
