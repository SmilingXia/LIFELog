//
//  XLLBaseVC.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseVC.h"

@interface XLLBaseVC ()

@end

@implementation XLLBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setNavigationTitle:(NSString *)title {
    self.navigationItem.title = title;
}

- (void)updateRightItemBarImageName:(NSString *)imageName {
    
    UIImage *itemBarImage = [self reSizeImage:[UIImage imageNamed:imageName] toSize:CGSizeMake(25, 25)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[itemBarImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
    
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)rightButtonAction {
    NSLog(@"rightItemBar");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
