//
//  XLLManageCenter.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLLManageCenter : NSObject

+ (XLLManageCenter *)instanceManageCenter;

/**
 获取当前时间
 
 @return yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)getCurrentTimeString;

/**
 获取 范围 随机数
 
 @param from    开始数
 @param to      目标数
 @return        范围随机数
 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 * 功能；动态计算字符串的高度
 * 需求：一个字符串，字符串字体大小，字符串对象的宽度
 */
+ (CGFloat)labHeigthString:(NSString *)content andFont:(UIFont *)viewFont andWidth:(float)objectWidth;

/**
 * 功能；动态计算字符串的宽度
 * 需求：一个字符串，字符串字体大小，字符串对象的高度
 */
+ (CGFloat)labWidthString:(NSString *)content andFont:(UIFont *)viewFont andObjectHeigth:(float)objectHeigth;

/**
 图片模糊效果
 
 @param image 需要模糊的图片
 @param blur 模糊度 0-1
 @return 模糊后的图片
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 颜色 - 生成图片
 
 @param color 图片颜色
 @return 图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 设置图片透明度
 
 @param alpha 透明度
 @param image 图片
 @return 透明度的图片
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image;

/**
 得到 - 分 - 秒 - 格式数据
 
 @param timeValue 时间
 @return 分 - 秒 - 格式数据
 */
+ (NSString *)getTimeValueString:(NSString *)timeValue;

@end
