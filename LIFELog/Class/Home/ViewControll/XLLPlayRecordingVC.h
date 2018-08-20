//
//  XLLPlayRecordingVC.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/17.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseVC.h"

@interface XLLPlayRecordingVC : XLLBaseVC

/**
 设置数据源 - 首次下标 - 初始化调用

 @param modelArray 数据源
 @param selectIndexPathRow 下标
 */
- (void)setViewModelArray:(NSArray *)modelArray andSelectIndexPathRow:(NSInteger)selectIndexPathRow;

@end
