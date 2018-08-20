//
//  XLLHomeItemModel.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XLLHomeItemModel : NSObject

/**
 * 类型
 */
@property (nonatomic, copy) NSString    *itemModeType;

/**
 * 描述
 */
@property (nonatomic, copy) NSString    *itemDescription;

/**
 * 描述封面
 */
@property (nonatomic, copy) NSString    *itemBackgroundImageName;

/**
 * 记录日期
 */
@property (nonatomic, copy) NSString    *itemRecordingDate;

/**
 * 记录内容数据
 */
@property (nonatomic, strong) NSData    *itemRecordContentData;


- (NSArray<XLLHomeItemModel *> *)getModelTypeList;

@end
