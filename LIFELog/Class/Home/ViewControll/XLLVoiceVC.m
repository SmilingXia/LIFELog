//
//  XLLVoiceVC.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/16.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLVoiceVC.h"
#import "XLLVoiceViewModel.h"
#import "XLLVoiceViewCell.h"
#import "XLLEntryRecorDingInfoViewXib.h"
#import "XLLPlayRecordingVC.h"

@interface XLLVoiceVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) XLLVoiceViewModel             *voiceViewModel;

@property (nonatomic, strong) UITableView                   *voiceTableView;
@property (nonatomic, strong) NSMutableArray                *voiceTableViewDataSource;

@property (nonatomic, strong) XLLVoiceCollectionViewXib     *voiceCollectionView;

@property (nonatomic, strong) UIView                        *entryRecorDingInfoBackView;
@property (nonatomic, strong) XLLEntryRecorDingInfoViewXib  *entryRecorDingInfoView;

@end

@implementation XLLVoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"语音"];
    //修改右边item
    [self updateRightItemBarImageName:@"icon_yysr_image"];
    [self loadSubViews];
}

#pragma mark -
#pragma mark    NSNotificationDelegate -- 通知回调

#pragma mark -
#pragma mark    delegate
#pragma mark    tableview的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.voiceTableViewDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell的标识
    static NSString *voiceTableViewCellIdentifier = @"voiceTableViewCellIdentifier";
    XLLVoiceViewCell *voiceTableViewCell = [tableView dequeueReusableCellWithIdentifier:voiceTableViewCellIdentifier];
    [voiceTableViewCell setVoiceViewCellModelValue:self.voiceTableViewDataSource[indexPath.row]];
    return voiceTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XLLPlayRecordingVC *vc = [[XLLPlayRecordingVC alloc] init];
    [vc setViewModelArray:self.voiceTableViewDataSource andSelectIndexPathRow:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 视图模型代理
- (void)protocolCallbackValue:(id)value {
    
    if ([value isKindOfClass:[NSString class]]) {
        
        NSString *valueString = (NSString *)value;
        if ([valueString isEqualToString:@"显示信息弹窗"]) {
            
            [self isShowentryRecorDingInfoView:YES];
            NSString *coverName = [NSString stringWithFormat:@"timg-%d",[XLLManageCenter getRandomNumber:0 to:21]];
            [self.voiceViewModel setCoverName:coverName];
            UIImage *image = XLLIMAGECONTENTSFILE(coverName, @"jpeg");
            [self.entryRecorDingInfoView.coverImageView setImage:image];
        }
        else if ([valueString isEqualToString:@"保存"]) {
            
            [self.voiceViewModel saveFileWithTitle:_entryRecorDingInfoView.titleNameField.text andDescribe:_entryRecorDingInfoView.describeTextView.text isSave:YES];
        }
        else if ([valueString isEqualToString:@"不保存"]) {
            
            [self.voiceViewModel saveFileWithTitle:_entryRecorDingInfoView.titleNameField.text andDescribe:_entryRecorDingInfoView.describeTextView.text isSave:NO];
            [self isShowentryRecorDingInfoView:NO];
            [self.entryRecorDingInfoView  resetInfo];
        }
        else if ([valueString isEqualToString:@"添加图片"]) {
            
            NSString *coverName = [NSString stringWithFormat:@"timg-%d",[XLLManageCenter getRandomNumber:0 to:21]];
            [self.voiceViewModel setCoverName:coverName];
            UIImage *image = XLLIMAGECONTENTSFILE(coverName, @"jpeg");
            [self.entryRecorDingInfoView.coverImageView setImage:image];
        }
        else if ([valueString isEqualToString:@"清空录入信息"]) {
            
            [self isShowentryRecorDingInfoView:NO];
            [self.entryRecorDingInfoView resetInfo];
            //刷新数据
            self.voiceTableViewDataSource = [self.voiceViewModel getVoiceTableViewDataSourceArray];
            [self.voiceTableView beginUpdates];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.voiceTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            [self.voiceTableView endUpdates];
        }
        else{
            
        }
    }
    else{
        NSLog(@"用着再看");
    }
}


#pragma mark -
#pragma mark    event

- (void)rightButtonAction {
    [super rightButtonAction];
    [self.voiceCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.voiceCollectionView.frame.origin.y >= SCREEN_HEIGHT) {
            make.bottom.mas_equalTo(0);
            self.entryRecorDingInfoBackView.hidden = NO;
            self.entryRecorDingInfoBackView.alpha = 0.6;
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            [self.view bringSubviewToFront:self.voiceCollectionView];
        }
        else {
            make.bottom.mas_equalTo(200);
            self.entryRecorDingInfoBackView.hidden = YES;
            self.entryRecorDingInfoBackView.alpha = 0.0;
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)backViewTapAction:(UITapGestureRecognizer *)backViewTap {
    if (self.voiceCollectionView.frame.origin.y < SCREEN_HEIGHT) {
        [self rightButtonAction];
    }
    else {
        [self.view endEditing:YES];
    }
}

#pragma mark -
#pragma mark    method

- (void)loadSubViews {
    
    self.voiceViewModel = [[XLLVoiceViewModel alloc] init];
    self.voiceViewModel.viewModelDelegate = self;
    
    [self.view addSubview:self.voiceTableView];
    [self.voiceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    self.voiceTableViewDataSource = [self.voiceViewModel getVoiceTableViewDataSourceArray];
    [self.voiceTableView registerNib:[UINib nibWithNibName:@"XLLVoiceViewCell" bundle:nil] forCellReuseIdentifier:@"voiceTableViewCellIdentifier"];
    
    self.voiceCollectionView = [XLLVoiceCollectionViewXib initWithXib];
    [self.view addSubview:self.voiceCollectionView];
    [self.voiceCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
        make.bottom.mas_equalTo(200);
    }];
    self.voiceCollectionView.voiceCollectionViewDelegate = self.voiceViewModel;
    [self.voiceCollectionView loadUIlayout];
    __weak typeof(self)weakSelf = self;
    self.voiceCollectionView.banckActionBlock = ^{
        [weakSelf rightButtonAction];
    };
    
    //背景 - 录入信息
    [self.view addSubview:self.entryRecorDingInfoBackView];
    [self.view addSubview:self.entryRecorDingInfoView];
    [self.entryRecorDingInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(500);
    }];
}

- (void)isShowentryRecorDingInfoView:(BOOL)isShow {
    
    if (isShow) {
        
        self.entryRecorDingInfoView.hidden = NO;
        self.entryRecorDingInfoBackView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.entryRecorDingInfoBackView.alpha = 0.6;
            self.entryRecorDingInfoView.alpha = 1.0f;
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }];
    }
    else{
        
        self.entryRecorDingInfoView.hidden = YES;
        self.entryRecorDingInfoBackView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.entryRecorDingInfoBackView.alpha = 0.0f;
            self.entryRecorDingInfoView.alpha = 0.0f;
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        }];
    }
}

#pragma mark -
#pragma mark    getter/setter

- (UITableView *)voiceTableView {
    if (_voiceTableView) {
        return _voiceTableView;
    }
    _voiceTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _voiceTableView.delegate     = self;
    _voiceTableView.dataSource   = self;
    _voiceTableView.rowHeight    = 150.0f;
    _voiceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _voiceTableView.backgroundColor = XLLCOLORALPHA(168, 168, 168, 0.5);
    return _voiceTableView;
}

- (UIView *)entryRecorDingInfoBackView {
    if (_entryRecorDingInfoBackView) {
        return _entryRecorDingInfoBackView;
    }
    _entryRecorDingInfoBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _entryRecorDingInfoBackView.alpha = 0.0f;
    _entryRecorDingInfoBackView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *backViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewTapAction:)];
    [_entryRecorDingInfoBackView addGestureRecognizer:backViewTap];
    _entryRecorDingInfoBackView.hidden = YES;
    return _entryRecorDingInfoBackView;
}

- (XLLEntryRecorDingInfoViewXib *)entryRecorDingInfoView {
    if (_entryRecorDingInfoView) {
        return _entryRecorDingInfoView;
    }
    _entryRecorDingInfoView = [XLLEntryRecorDingInfoViewXib initWithXib];
    _entryRecorDingInfoView.alpha = 0.0f;
    _entryRecorDingInfoView.backgroundColor = [UIColor whiteColor];
    _entryRecorDingInfoView.layer.cornerRadius = 6.0f;
    _entryRecorDingInfoView.clipsToBounds = YES;
    _entryRecorDingInfoView.viewDelegate = self;
    [_entryRecorDingInfoView loadUIlayout];
    _entryRecorDingInfoView.hidden = YES;
    return _entryRecorDingInfoView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
