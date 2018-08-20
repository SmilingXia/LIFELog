//
//  XLLHomeCellModel.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLLHomeCellModel : NSObject

/**
 * 类型
 */
@property (nonatomic, copy) NSString    *itemType;

/**
 * 名称
 */
@property (nonatomic, copy) NSString    *itemName;

/**
 * 描述
 */
@property (nonatomic, copy) NSString    *itemDescription;

/**
 * 描述封面
 */
@property (nonatomic, copy) NSString    *itemBackgroundImageName;


+ (NSArray<XLLHomeCellModel *> *)getHomeCellModelList;

@end
