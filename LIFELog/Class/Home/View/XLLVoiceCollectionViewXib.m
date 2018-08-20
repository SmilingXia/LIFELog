//
//  XLLVoiceCollectionViewXib.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLVoiceCollectionViewXib.h"

@interface XLLVoiceCollectionViewXib ()

@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end

@implementation XLLVoiceCollectionViewXib

+ (XLLVoiceCollectionViewXib *)initWithXib {
    
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"XLLVoiceCollectionViewXib" owner:self options:nil];
    return xibArray[0];
}

#pragma mark -
#pragma mark    NSNotificationDelegate -- 通知回调

#pragma mark -
#pragma mark    delegate

#pragma mark -
#pragma mark    event

- (void)longPressGestureAction:(UILongPressGestureRecognizer *)longPressGesture {
    
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按开始了 - 开始录音");
        self.voiceImageView.tintColor   = XLLRandomColor;
        self.titleLabel.text            = @"正在录音";
        
        if (self.voiceCollectionViewDelegate && [self.voiceCollectionViewDelegate respondsToSelector:@selector(stateBeganAction)]) {
            [self.voiceCollectionViewDelegate stateBeganAction];
        }
    }
    else if (longPressGesture.state == UIGestureRecognizerStateEnded){
        NSLog(@"长按结束了 - 结束录音");
        self.titleLabel.text            = @"录音结束";
        self.voiceImageView.tintColor = XLLCOLOR(138, 138, 138);
        if (self.voiceCollectionViewDelegate && [self.voiceCollectionViewDelegate respondsToSelector:@selector(stateEndedAction)]) {
            [self.voiceCollectionViewDelegate stateEndedAction];
        }
        if (_banckActionBlock) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.titleLabel.text    = @"长按开始录音";
            });
            self.banckActionBlock();
        }
    }
    else{
        //录音进行中
    }
}

#pragma mark -
#pragma mark    method

- (void)loadUIlayout {
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
    self.voiceImageView.userInteractionEnabled = YES;
    [self.voiceImageView addGestureRecognizer:longPressGesture];
}


#pragma mark -
#pragma mark    getter/setter


@end
