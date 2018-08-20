//
//  XLLHomeItemViewXib.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLHomeItemViewXib.h"

@interface XLLHomeItemViewXib ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UILabel *itemTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel;

@end


@implementation XLLHomeItemViewXib


+ (XLLHomeItemViewXib *)initWithXib {
    
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"XLLHomeItemViewXib" owner:self options:nil];
    XLLHomeItemViewXib *xibView = xibArray[0];
    xibView.clipsToBounds         = YES;
    xibView.layer.cornerRadius    = 10.0f;
    return xibView;
}


- (void)setCellItemViewModel:(id)cellItemModel {
    
    if ([cellItemModel isKindOfClass:[XLLHomeCellModel class]]) {
        self.modelValue = (XLLHomeCellModel *)cellItemModel;
        self.itemTypeLabel.text = self.modelValue.itemName;
        self.itemDescriptionLabel.text = self.modelValue.itemDescription;
        UIImage *image = XLLIMAGECONTENTSFILE(self.modelValue.itemBackgroundImageName, @"jpeg");
        [self.backgroundImageView setImage:image];
    }
}

@end
