//
//  XLLBaseVM.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLLViewModelProtocol.h"

@interface XLLBaseVM : NSObject <XLLViewModelProtocol>

@property (nonatomic, weak) id<XLLViewModelProtocol> viewModelDelegate;
- (void)protocolCallbackValue:(id)value;
- (void)protocolCallbackOneValue:(id)onevalue twoValue:(id)twoValue;


@property (nonatomic, strong) UIAlertView               *alertView;
/**
 显示alertView
 
 @param messige 提示信息
 */
- (void)showAlertViewWithMessige:(NSString *)messige;

@end
