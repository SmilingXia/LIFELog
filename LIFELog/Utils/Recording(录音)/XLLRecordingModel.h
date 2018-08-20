//
//  XLLRecordingModel.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/17.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLLRecordingModel : NSObject

/**
 * 录音文件名称
 */
@property (nonatomic, copy) NSString    *recordingFileName;

/**
 * 录音文件标题
 */
@property (nonatomic, copy) NSString    *recordingFileTitle;

/**
 * 录音文件封面名称
 */
@property (nonatomic, copy) NSString    *recordingFileCoverName;

/**
 * 录音文件描述
 */
@property (nonatomic, copy) NSString    *recordingFileDescribe;

/**
 * 录音文件日期
 */
@property (nonatomic, copy) NSString    *recordingFileDate;

@end
