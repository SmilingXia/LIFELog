//
//  XLLPlayRecordingView.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/17.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLPlayRecordingView.h"
#import "XLLRecordingModel.h"
#import "XLLAVAudioPlayer.h"

@interface XLLPlayRecordingView()

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *bigRoundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallRoundImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *playProgressLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalProgressLabel;

@property (nonatomic, strong) XLLAVAudioPlayer      *aVAudioPlayer;
@property (nonatomic, strong) NSString              *durationString;    //总时间

@end

@implementation XLLPlayRecordingView

+ (XLLPlayRecordingView *)initWithXib {
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"XLLPlayRecordingView" owner:self options:nil];
    return xibArray[0];
}


- (void)updateModelValue:(XLLRecordingModel *)modelValue {
    
    UIImage *image = XLLIMAGECONTENTSFILE(modelValue.recordingFileCoverName, @"jpeg");
    dispatch_queue_t myimageQueue = dispatch_queue_create("com.myimagemohu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(myimageQueue, ^{
        UIImage *imageMohu = [XLLManageCenter blurryImage:image withBlurLevel:1.0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.backGroundImage setImage:imageMohu];
        });
    });
    self.bigRoundImageView.alpha    = 0.5;
    [self.smallRoundImageView setImage:image];
    self.progressView.progress      = 0.0f;
    self.playProgressLabel.text     = @"00:00";
    self.totalProgressLabel.text    = @"00:00";
    //得到播放路径
    NSString *filePath = [NSString stringWithFormat:@"%@%@",[[XLLFilePathManage instanceFilePathManage] getRecordingFilePath],modelValue.recordingFileName];
    [self.aVAudioPlayer audioPlayerPlay:filePath];
    self.playButton.selected = YES;
}

//播放暂停
- (IBAction)playButtonAction:(UIButton *)sender {
    self.playButton.selected = !self.playButton.selected;
    if (self.playButton.selected) {
        //播放
        [self protocolCallbackValue:@"播放"];
        [self.aVAudioPlayer play];
    }
    else{
        //暂停
        [self protocolCallbackValue:@"暂停"];
        [self.aVAudioPlayer pause];
    }
}
//上一首
- (IBAction)upButtonAction:(UIButton *)sender {
    [self protocolCallbackValue:@"上一首"];
}

//下一首
- (IBAction)nextButtonAction:(UIButton *)sender {
    [self protocolCallbackValue:@"下一首"];
}


#pragma mark -
#pragma mark    delegate

- (void)protocolCallbackOneValue:(id)onevalue twoValue:(id)twoValue {
    
    if ([onevalue isKindOfClass:[NSString class]]) {
        
        NSString *onevalueString = (NSString *)onevalue;
        NSString *twoValueString = (NSString *)twoValue;
        if ([onevalueString isEqualToString:@"总时间"]) {
            self.durationString = twoValueString;
            self.totalProgressLabel.text = [XLLManageCenter getTimeValueString:self.durationString];
        }
        else if ([onevalueString isEqualToString:@"进度时间"]) {
            //修改 - 播放进度 - 计算
            self.playProgressLabel.text = [XLLManageCenter getTimeValueString:twoValueString];
            self.progressView.progress = [twoValueString floatValue]/[self.durationString floatValue];
        }
        else if ([onevalueString isEqualToString:@"播放完毕"]) {
            [self protocolCallbackValue:@"下一首"];
        }
        else{
            NSLog(@"不知道");
        }
    }
    else {
        NSLog(@"不知道");
    }
}

- (void)dealloc {
    [_aVAudioPlayer stop];
    _aVAudioPlayer = nil;
}

#pragma mark -
#pragma mark    getter/setter

- (XLLAVAudioPlayer *)aVAudioPlayer {
    if (_aVAudioPlayer) {
        return _aVAudioPlayer;
    }
    _aVAudioPlayer = [[XLLAVAudioPlayer alloc] init];
    _aVAudioPlayer.viewModelDelegate = self;
    return _aVAudioPlayer;
}

@end
