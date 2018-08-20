//
//  XLLBaseVM.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseVM.h"

@implementation XLLBaseVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)protocolCallbackValue:(id)value {
    if (self.viewModelDelegate && [self.viewModelDelegate respondsToSelector:@selector(protocolCallbackValue:)]) {
        [self.viewModelDelegate protocolCallbackValue:value];
    }
}

- (void)protocolCallbackOneValue:(id)onevalue twoValue:(id)twoValue {
    if (self.viewModelDelegate && [self.viewModelDelegate respondsToSelector:@selector(protocolCallbackOneValue:twoValue:)]) {
        [self.viewModelDelegate protocolCallbackOneValue:onevalue twoValue:twoValue];
    }
}


- (void)showAlertViewWithMessige:(NSString *)messige{
    [self.alertView setMessage:messige];
    [self.alertView show];
}

- (UIAlertView *)alertView{
    if (_alertView) {
        return _alertView;
    }
    _alertView  = [[UIAlertView alloc] initWithTitle:@""
                                             message:@""
                                            delegate:self
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@"确认", nil];
    return _alertView;
}

@end
