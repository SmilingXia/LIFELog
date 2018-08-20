//
//  XLLBaseView.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseView.h"

@interface XLLBaseView()

@end

@implementation XLLBaseView

- (void)protocolCallbackValue:(id)value {
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(protocolCallbackValue:)]) {
        [self.viewDelegate protocolCallbackValue:value];
    }
}

@end
