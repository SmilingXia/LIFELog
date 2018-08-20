//
//  XLLRecording.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

/*
    录音功能实现
    一、录音类对象 - AVAudioRecorder  的实例化
        两种初始化方法
            1.- initWithURL:settings:error:
            //url       -- 要记录到的文件系统位置。 要记录的文件类型是从此参数值中包含的文件扩展名推断出来的。
            //settings  -- 设置 录制会话的设置。 有关录音机可用设置的信息，请参阅音频设置和格式。
            //error     -- 如果发生错误，则通过引用返回错误的描述。 传递nil忽略错误。
 
            2.- initWithURL:format:error:
            //url       -- 要记录到的文件系统位置。 要记录的文件类型是从此参数值中包含的文件扩展名推断出来的。
            //format    -- 表示具有格式的音频数据缓冲区的类。
            //error     -- 如果发生错误，则通过引用返回错误的描述。 传递nil忽略错误。
 
    二、录音设置
        1.AVNumberOfChannelsKey 通道数 通常为双声道 值2
        2.AVSampleRateKey 采样率 单位HZ 通常设置成44100 也就是44.1k
        3.AVLinearPCMBitDepthKey 比特率 8 16 24 32
        4.AVEncoderAudioQualityKey 声音质量
            ① AVAudioQualityMin  = 0, 最小的质量
            ② AVAudioQualityLow  = 0x20, 比较低的质量
            ③ AVAudioQualityMedium = 0x40, 中间的质量
            ④ AVAudioQualityHigh  = 0x60,高的质量
            ⑤ AVAudioQualityMax  = 0x7F 最好的质量
        5.AVEncoderBitRateKey 音频编码的比特率 单位Kbps 传输的速率 一般设置128000 也就是128kbps
 
 */

#import "XLLRecording.h"
#import <AVFoundation/AVFoundation.h>
#import "XLLRecordingModel.h"

@interface XLLRecording() <AVAudioRecorderDelegate>

/**
 录音功能类
 */
@property (nonatomic, strong) AVAudioRecorder   *audioRecorder;

/**
 录音设置
 */
@property (nonatomic, strong) NSDictionary      *audioRecorderSetting;

/**
 录音文件名称
 */
@property (nonatomic, strong) NSString          *audioRecorderFileName;

/**
 录音文件存放路径
 */
@property (nonatomic, strong) NSString          *audioRecorderFilePath;

@end

@implementation XLLRecording

- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadAudioRecorderInfo];
    }
    return self;
}


/**
 加载基础 - 录音信息
 */
- (void)loadAudioRecorderInfo {
    
    AVAudioSession * recorder = [AVAudioSession sharedInstance];
    NSError * sessionError;
    [recorder setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(recorder == nil){
        NSLog(@"Error creating session: %@", [sessionError description]);
    }
    else{
        [recorder setActive:YES error:nil];
    }
    self.audioRecorderFileName  = [self getRecorderFileName];
    self.audioRecorderFilePath  = [self getFilePathWithFileName:self.audioRecorderFileName];
    self.audioRecorderSetting   = [self getRecorderSetting];
    self.audioRecorder          = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.audioRecorderFilePath] settings:self.audioRecorderSetting error:nil];
    self.audioRecorder.delegate = self;
}


/**
 开始录制
 */
- (void)startRecording {
    [self.audioRecorder prepareToRecord];
    [self.audioRecorder record];
}

/**
 暂停录制
 */
- (void)pauseRecording {
    [self.audioRecorder pause];
}

/**
 恢复录制
 */
- (void)recordRecording {
    [self.audioRecorder record];
}

/**
 结束录制
 */
- (void)stopRecording {
    [self.audioRecorder stop];
}

/**
 得到录音文件名称
 */
- (NSString *)getRecorderFileName {
    
    NSString *fileName = [NSString stringWithFormat:@"%d.pcm",(int)[NSDate date].timeIntervalSince1970];
    return fileName;
}

/**
 得到文件存放目录

 @param fileName 文件名称
 @return 文件全路径
 */
- (NSString *)getFilePathWithFileName:(NSString *)fileName {
    
    NSString *filePath = [NSString stringWithFormat:@"%@%@",[[XLLFilePathManage instanceFilePathManage] getRecordingFilePath],fileName];
    return filePath;
}

/**
 录音配置
 */
- (NSDictionary *)getRecorderSetting {
    
    NSMutableDictionary *settingDictionary = [NSMutableDictionary dictionary];
    [settingDictionary setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];      //通道数
    [settingDictionary setObject:[NSNumber numberWithInt:44100] forKey:AVSampleRateKey];        //采样率
    [settingDictionary setObject:[NSNumber numberWithInt:32] forKey:AVLinearPCMBitDepthKey];    //比特率
    [settingDictionary setObject:[NSNumber numberWithInt:AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];   //音质
    [settingDictionary setObject:[NSNumber numberWithInt:128000] forKey:AVEncoderBitRateKey];   //音频编码的比特率
    
    return settingDictionary;
}

/**
 是否需要保存
 */
- (void)saveFileWithTitle:(NSString *)titleString andCoverName:(NSString *)coverName andDescribe:(NSString *)describe isSave:(BOOL)isSave {
    
    if (isSave) {
        //保存 - 1.得到plist文件路劲 2.得到文件数组 3.进行插入
        XLLRecordingModel *model        = [[XLLRecordingModel alloc] init];
        model.recordingFileName         = self.audioRecorderFileName;
        model.recordingFileTitle        = titleString;
        model.recordingFileCoverName    = coverName;
        model.recordingFileDescribe     = describe;
        model.recordingFileDate         = [XLLManageCenter getCurrentTimeString];
        NSDictionary *modelDict         = [model mj_keyValues];
        NSString *plistFilePath         = [[XLLFilePathManage instanceFilePathManage] getRecordingFilePathPlist];
        NSMutableArray *plistFileArray  = [[NSMutableArray alloc] initWithContentsOfFile:plistFilePath];
        if (!plistFileArray) {
            plistFileArray = [NSMutableArray array];
            [plistFileArray addObject:modelDict];
        }
        else {
            NSMutableArray *oneArray = [NSMutableArray array];
            [oneArray addObject:modelDict];
            NSIndexSet *helpIndex = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, plistFileArray.count)];
            [oneArray insertObjects:plistFileArray atIndexes:helpIndex];
            plistFileArray = oneArray;
        }
        BOOL isSuccess = [plistFileArray writeToFile:plistFilePath atomically:YES];
        if (self.recordingDelegate && [self.recordingDelegate respondsToSelector:@selector(saveRecordingIsSuccess:)]) {
            [self.recordingDelegate saveRecordingIsSuccess:isSuccess];
        }
    }
    else{
        //移除文件
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isSuccess = [fileManager removeItemAtPath:self.audioRecorderFilePath error:nil];
        if (isSuccess) {
            NSLog(@"移除成功");
        }
        else{
            NSLog(@"移除失败");
        }
    }
    self.audioRecorderFileName  = nil;
    self.audioRecorderFilePath  = nil;
    self.audioRecorderSetting   = nil;
    self.audioRecorder          = nil;
}

#pragma mark -
#pragma mark    AVAudioRecorderDelegate

/**
 (记录停止 - 达到时限) 完成
 */
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    
    NSLog(@"录音结束 -- 回调");
    if (self.recordingDelegate && [self.recordingDelegate respondsToSelector:@selector(recordingDidFinishRecording)]) {
        [self.recordingDelegate recordingDidFinishRecording];
    }
}

/**
 录制过程中 - 编码错误 - 失败
 */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    
}

@end
