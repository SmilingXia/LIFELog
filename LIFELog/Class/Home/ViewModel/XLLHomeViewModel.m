//
//  XLLHomeViewModel.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLHomeViewModel.h"

@interface XLLHomeViewModel ()

@property (nonatomic, strong) NSArray   *homeCellModelArray;

@end

@implementation XLLHomeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


/**
 得到cell模型数组
 */
- (NSArray *)getHomeCellModelArray {
    if (!_homeCellModelArray) {
        _homeCellModelArray = [XLLHomeCellModel getHomeCellModelList];
    }
    return _homeCellModelArray;
}


@end
