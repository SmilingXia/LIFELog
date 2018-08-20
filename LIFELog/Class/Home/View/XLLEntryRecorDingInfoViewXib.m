//
//  XLLEntryRecorDingInfoViewXib.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLEntryRecorDingInfoViewXib.h"

@interface XLLEntryRecorDingInfoViewXib()<UITextViewDelegate,UITextFieldDelegate>

@end


@implementation XLLEntryRecorDingInfoViewXib

+ (XLLEntryRecorDingInfoViewXib *)initWithXib {
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"XLLEntryRecorDingInfoViewXib" owner:self options:nil];
    return xibArray[0];
}

- (void)loadUIlayout {
    
    self.describeTextView.delegate              = self;
    self.titleNameField.delegate                = self;
    self.coverImageView.userInteractionEnabled  = YES;
    UITapGestureRecognizer *coverImageViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageViewAction:)];
    [self.coverImageView addGestureRecognizer:coverImageViewTapGesture];
    
    CALayer *imageLayer         = [self.coverImageView layer];
    imageLayer.borderColor      = [XLLCOLOR(245, 245, 245) CGColor];
    
    CALayer *textViewLayer      = [self.describeTextView layer];
    textViewLayer.borderColor      = [XLLCOLOR(245, 245, 245) CGColor];
}

- (void)resetInfo {
    self.describeTextView.text  = @"描述";
    self.titleNameField.text    = @"";
    self.coverImageView.image   = [UIImage imageNamed:@"icon_tjtp_image"];
    [self.titleNameField resignFirstResponder];
    [self.describeTextView resignFirstResponder];
}

- (void)coverImageViewAction:(UITapGestureRecognizer *)coverImageViewTapGesture {
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(protocolCallbackValue:)]) {
        [self.viewDelegate protocolCallbackValue:@"添加图片"];
    }
}

- (IBAction)saveButtonAction:(id)sender {
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(protocolCallbackValue:)]) {
        [self.viewDelegate protocolCallbackValue:@"保存"];
    }
}

- (IBAction)noSaveButtonAction:(id)sender {
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(protocolCallbackValue:)]) {
        [self.viewDelegate protocolCallbackValue:@"不保存"];
    }
}

@end
