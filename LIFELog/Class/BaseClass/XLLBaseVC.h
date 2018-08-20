//
//  XLLBaseVC.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLLViewModelProtocol.h"

@interface XLLBaseVC : UIViewController <XLLViewModelProtocol>

@property (nonatomic, weak) id<XLLViewModelProtocol> viewControllerDelegate;

- (void)setNavigationTitle:(NSString *)title;

- (void)updateRightItemBarImageName:(NSString *)imageName;
- (void)rightButtonAction;

@end
