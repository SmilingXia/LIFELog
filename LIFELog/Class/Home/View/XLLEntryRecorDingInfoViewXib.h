//
//  XLLEntryRecorDingInfoViewXib.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseView.h"

@interface XLLEntryRecorDingInfoViewXib : XLLBaseView

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UITextField *titleNameField;
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *noSaveButton;
- (IBAction)saveButtonAction:(id)sender;
- (IBAction)noSaveButtonAction:(id)sender;

+ (XLLEntryRecorDingInfoViewXib *)initWithXib;
- (void)loadUIlayout;
- (void)resetInfo;

@end
