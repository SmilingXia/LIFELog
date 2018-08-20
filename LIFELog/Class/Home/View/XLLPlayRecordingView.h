//
//  XLLPlayRecordingView.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/17.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseView.h"
@class XLLRecordingModel;

@interface XLLPlayRecordingView : XLLBaseView

+ (XLLPlayRecordingView *)initWithXib;

- (void)updateModelValue:(XLLRecordingModel *)modelValue;

@end
