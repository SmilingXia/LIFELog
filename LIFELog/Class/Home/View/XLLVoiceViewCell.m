//
//  XLLVoiceViewCell.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/17.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLVoiceViewCell.h"
#import "XLLRecordingModel.h"

@interface XLLVoiceViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionHeight;

@property (nonatomic, strong) XLLRecordingModel   *voiceCellMoel;

@end

@implementation XLLVoiceViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVoiceViewCellModelValue:(id)cellModel {
    
    self.voiceCellMoel  = [XLLRecordingModel mj_objectWithKeyValues:(NSDictionary *)cellModel];
    UIImage *image      = XLLIMAGECONTENTSFILE(self.voiceCellMoel.recordingFileCoverName, @"jpeg");
    //模糊图片
    //self.backgroundView = [[UIImageView alloc] initWithImage:[XLLManageCenter blurryImage:image withBlurLevel:100]];
    //self.backgroundView.backgroundColor = XLLCOLORALPHA(0, 0, 0, 0.3);
    //计算描述内容高度
    CGFloat heightValue = [XLLManageCenter labHeigthString:self.voiceCellMoel.recordingFileDescribe andFont:[UIFont systemFontOfSize:15.0] andWidth:self.descriptionLabel.frame.size.width] + 10;
    self.descriptionLabel.numberOfLines     = 0;
    self.descriptionHeight.constant         = heightValue;
    self.coverImageView.image               = image;
    self.titleLabel.text                    = self.voiceCellMoel.recordingFileTitle;
    self.descriptionLabel.text              = self.voiceCellMoel.recordingFileDescribe;
    
}

@end
