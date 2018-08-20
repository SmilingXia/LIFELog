//
//  XLLManageCenter.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLManageCenter.h"
#import <Accelerate/Accelerate.h>

@interface XLLManageCenter()

@end

@implementation XLLManageCenter


+ (XLLManageCenter *)instanceManageCenter {
    
    static XLLManageCenter *manageCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manageCenter = [[XLLManageCenter alloc] init];
    });
    return manageCenter;
}


/**
 获取当前时间

 @return yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)getCurrentTimeString {
    // 获取系统当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTimeString = [dateFormatter stringFromDate:date];
    return currentTimeString;
}


/**
 获取 范围 随机数

 @param from    开始数
 @param to      目标数
 @return        范围随机数
 */
+ (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

/**
 * 功能；动态计算字符串的高度
 * 需求：一个字符串，字符串字体大小，字符串对象的宽度
 */
+ (CGFloat)labHeigthString:(NSString *)content andFont:(UIFont *)viewFont andWidth:(float)objectWidth{
    NSDictionary *attrs = @{NSFontAttributeName : viewFont};
    CGSize maxSize = CGSizeMake(objectWidth, MAXFLOAT);
    // 计算文字占据的高度
    CGSize size = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.height;
}

/**
 * 功能；动态计算字符串的宽度
 * 需求：一个字符串，字符串字体大小，字符串对象的高度
 */
+ (CGFloat)labWidthString:(NSString *)content andFont:(UIFont *)viewFont andObjectHeigth:(float)objectHeigth{
    NSDictionary *attrs = @{NSFontAttributeName : viewFont};
    CGSize maxSize = CGSizeMake(MAXFLOAT, objectHeigth);
    // 计算文字占据的高度
    CGSize size = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.width;
}


/**
 图片模糊效果

 @param image 需要模糊的图片
 @param blur 模糊度 0-1
 @return 模糊后的图片
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (image==nil)
    {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片");
        return nil;
    }
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
    } else if (blur > 1.0f) {
        blur = 1.0f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace);   //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
}

/**
 颜色 - 生成图片

 @param color 图片颜色
 @return 图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


/**
 设置图片透明度

 @param alpha 透明度
 @param image 图片
 @return 透明度的图片
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image {
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 得到 - 分 - 秒 - 格式数据

 @param timeValue 时间
 @return 分 - 秒 - 格式数据
 */
+ (NSString *)getTimeValueString:(NSString *)timeValue {
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    formatter.dateFormat = @"mm:ss";
    NSDate *date    = [NSDate dateWithTimeIntervalSince1970:[timeValue integerValue]];
    NSString *imeValueString = [formatter stringFromDate:date];
    return imeValueString;
}


@end
