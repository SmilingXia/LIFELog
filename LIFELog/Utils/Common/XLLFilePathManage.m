//
//  XLLFilePathManage.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLFilePathManage.h"

@interface XLLFilePathManage()

/**
 录音文件 - 路径
 */
@property (nonatomic, copy) NSString    *recordingFilePath;

/**
 录音plist文件 - 路径
 */
@property (nonatomic, copy) NSString    *recordingPlistFilePath;

@end

@implementation XLLFilePathManage

+ (XLLFilePathManage *)instanceFilePathManage {
    static XLLFilePathManage *filePathManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filePathManage = [[XLLFilePathManage alloc] init];
    });
    return filePathManage;
}


/**
 得到 - 录音文件 - 路径

 @return 录音文件路径
 */
- (NSString *)getRecordingFilePath{
    if (_recordingFilePath == nil) {
        _recordingFilePath = [NSString stringWithFormat:@"%@/Library/%@/", NSHomeDirectory(),@"RecordingFile"];
        //创建 - 文件夹
        [[NSFileManager defaultManager] createDirectoryAtPath:_recordingFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return _recordingFilePath;
}

/**
 得到 - 录音PLIST文件 - 路径

 @return 录音PLIST文件路径
 */
- (NSString *)getRecordingFilePathPlist{
    if (_recordingPlistFilePath == nil) {
        NSString *record = [NSString stringWithFormat:@"%@/Library/RecordingFile/",NSHomeDirectory()];
        _recordingPlistFilePath = [record stringByAppendingString:kRecording_Plistfile_Name];
        if (![[NSFileManager defaultManager] fileExistsAtPath:record]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:record withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:_recordingPlistFilePath]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic writeToFile:_recordingPlistFilePath atomically:YES];
        }
    }
    return _recordingPlistFilePath;
}

@end
