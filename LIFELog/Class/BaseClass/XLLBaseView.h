//
//  XLLBaseView.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLLViewModelProtocol.h"

@interface XLLBaseView : UIView<XLLViewModelProtocol>

@property (nonatomic, weak) id<XLLViewModelProtocol> viewDelegate;
- (void)protocolCallbackValue:(id)value;

@end
