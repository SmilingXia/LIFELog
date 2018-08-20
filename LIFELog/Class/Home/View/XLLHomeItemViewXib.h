//
//  XLLHomeItemViewXib.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseView.h"
#import "XLLHomeCellModel.h"

@interface XLLHomeItemViewXib : XLLBaseView

@property (nonatomic, strong) XLLHomeCellModel *modelValue;

+ (XLLHomeItemViewXib *)initWithXib;

- (void)setCellItemViewModel:(id)cellItemModel;

@end
