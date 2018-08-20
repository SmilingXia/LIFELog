//
//  XLLMacro.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

//调试
#ifdef DEBUG
# define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//delegate
#define SharedDelegate  ((XLLAppDelegate*)[UIApplication sharedApplication].delegate)

//self
#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF __strong typeof(self) strongSelf = weakSelf

//设置颜色
#define XLLCOLOR(x, y, z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]
#define XLLCOLORALPHA(x, y, z , a) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//随机颜色
#define XLLRandomColor XLLCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//图片
#define XLLIMAGECONTENTSFILE(resourcePath,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:resourcePath ofType:type]]
