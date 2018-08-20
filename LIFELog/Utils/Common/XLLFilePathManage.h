//
//  XLLFilePathManage.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 文件路径管理
 */
@interface XLLFilePathManage : NSObject

+ (XLLFilePathManage *)instanceFilePathManage;

/**
 获取 - 录音保存文件路径
 */
- (NSString *)getRecordingFilePath;

/**
 获取 - 录音保存plist文件路径
 */
- (NSString *)getRecordingFilePathPlist;

@end
