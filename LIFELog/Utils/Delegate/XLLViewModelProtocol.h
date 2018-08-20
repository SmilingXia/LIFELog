//
//  XLLViewModelProtocol.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLLViewModelProtocol <NSObject>

@optional
/**
 路由
 
 @param className 选择路由
 */
- (void)protocolCallbackClassName:(Class)className;

/**
 路由
 
 @param className 选择路由类名称
 @param classValue 对象
 */
- (void)protocolCallbackClassName:(Class)className ClassValue:(id)classValue;

/**
 协议回调传值
 
 @param value 值
 */
- (void)protocolCallbackValue:(id)value;


/**
 协议回调传值

 @param onevalue 第一个标记
 @param twoValue 第二标记值
 */
- (void)protocolCallbackOneValue:(id)onevalue twoValue:(id)twoValue;


@end
