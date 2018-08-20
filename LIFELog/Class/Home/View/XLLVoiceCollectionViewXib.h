//
//  XLLVoiceCollectionViewXib.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseView.h"

@protocol XLLVoiceCollectionViewDelegate <NSObject>

//开始
- (void)stateBeganAction;

//结束
- (void)stateEndedAction;

@end

typedef void(^BanckActionBlock)(void);

@interface XLLVoiceCollectionViewXib : XLLBaseView

@property (nonatomic, weak) id<XLLVoiceCollectionViewDelegate>  voiceCollectionViewDelegate;

@property (nonatomic, copy) BanckActionBlock                    banckActionBlock;

+ (XLLVoiceCollectionViewXib *)initWithXib;

- (void)loadUIlayout;

@end
