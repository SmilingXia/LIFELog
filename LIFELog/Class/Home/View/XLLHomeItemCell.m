//
//  XLLHomeItemCell.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLHomeItemCell.h"

@interface XLLHomeItemCell ()

@end

@implementation XLLHomeItemCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle             = UITableViewCellSelectionStyleNone;
        self.homeItemView               = [XLLHomeItemViewXib initWithXib];
        [self.contentView addSubview:self.homeItemView];
        [self.homeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(20);
            make.right.bottom.mas_equalTo(-20);
        }];
        self.homeItemView.backgroundColor       = XLLRandomColor;
    }
    return self;
}

- (void)setCellModel:(id)cellModel {
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
