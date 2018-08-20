//
//  XLLPlayRecordingVC.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/17.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLPlayRecordingVC.h"
#import "XLLPlayRecordingView.h"
#import "XLLRecordingModel.h"

@interface XLLPlayRecordingVC ()

@property (nonatomic, strong) XLLPlayRecordingView      *playRecordingView;

/**
 数据源
 */
@property (nonatomic, strong) NSArray                   *modelArray;

/**
 选择播放的下标
 */
@property (nonatomic, assign) NSInteger                 selectIndexPathRow;

@end

@implementation XLLPlayRecordingVC

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *image = [XLLManageCenter createImageWithColor:XLLCOLORALPHA(255, 255, 255, 0.4)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewLayout];
}

#pragma mark -
#pragma mark    NSNotificationDelegate -- 通知回调

#pragma mark -
#pragma mark    delegate

- (void)protocolCallbackValue:(id)value {
    
    if ([value isKindOfClass:[NSString class]]) {
        
        NSString *valueString = (NSString *)value;
        if ([valueString isEqualToString:@"上一首"]) {
            _selectIndexPathRow -= 1;
            if (_selectIndexPathRow < 0) {
                _selectIndexPathRow = _modelArray.count - 1;
            }
            [self setViewLayout];
        }
        else if ([valueString isEqualToString:@"下一首"]) {
            _selectIndexPathRow += 1;
            if (_selectIndexPathRow >= _modelArray.count) {
                _selectIndexPathRow = 0;
            }
            [self setViewLayout];
        }
        else {
            NSLog(@"不知道");
        }
    }
    else{
        NSLog(@"用着再看");
    }
}


#pragma mark -
#pragma mark    event


#pragma mark -
#pragma mark    method

- (void)setViewLayout {
    NSDictionary *dict = _modelArray[_selectIndexPathRow];
    XLLRecordingModel *modelValue = [XLLRecordingModel mj_objectWithKeyValues:dict];
    //得到 - 对象 - 设置标题 - 加载视图
    [self setNavigationTitle:modelValue.recordingFileTitle];
    if (!_playRecordingView) {
        self.playRecordingView = [XLLPlayRecordingView initWithXib];
        [self.view addSubview:self.playRecordingView];
        [self.playRecordingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        self.playRecordingView.viewDelegate = self;
    }
    [self.playRecordingView updateModelValue:modelValue];
}


/* 设置数据源 - 首次的下标 */
- (void)setViewModelArray:(NSArray *)modelArray andSelectIndexPathRow:(NSInteger)selectIndexPathRow{
    _modelArray         = modelArray;
    _selectIndexPathRow = selectIndexPathRow;
}

#pragma mark -
#pragma mark    getter/setter

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
