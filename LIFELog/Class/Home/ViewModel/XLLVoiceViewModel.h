//
//  XLLVoiceViewModel.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseVM.h"
#import "XLLVoiceCollectionViewXib.h"

@interface XLLVoiceViewModel : XLLBaseVM <XLLVoiceCollectionViewDelegate>

- (void)setCoverName:(NSString *)coverName;
- (void)saveFileWithTitle:(NSString *)titleString andDescribe:(NSString *)describe isSave:(BOOL)isSave;
- (NSMutableArray *)getVoiceTableViewDataSourceArray;

@end
