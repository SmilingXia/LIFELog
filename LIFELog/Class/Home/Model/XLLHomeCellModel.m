//
//  XLLHomeCellModel.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLHomeCellModel.h"

@implementation XLLHomeCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+ (NSArray<XLLHomeCellModel *> *)getHomeCellModelList {
    NSString *path                      = [[NSBundle mainBundle] pathForResource:@"HomeCellModel" ofType:@"plist"];
    NSArray *homeCellArray              = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *homeCellArrayDict   = [NSMutableArray array];
    for (NSDictionary *dictValue in homeCellArray) {
        XLLHomeCellModel *modelValue = [XLLHomeCellModel mj_objectWithKeyValues:dictValue];
        [homeCellArrayDict addObject:modelValue];
    }
    return homeCellArrayDict;
}

@end
