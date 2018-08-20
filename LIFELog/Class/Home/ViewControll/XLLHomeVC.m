//
//  XLLHomeVC.m
//  LIFELog
//
//  Created by 夏江福 on 2018/8/15.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLHomeVC.h"
#import "XLLHomeItemCell.h"
#import "XLLHomeViewModel.h"
#import "XLLVoiceVC.h"

@interface XLLHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) XLLHomeViewModel      *viewModel;

@property (nonatomic, strong) UITableView           *itemTableView;


@end

@implementation XLLHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"日志"];
    self.viewModel = [[XLLHomeViewModel alloc] init];
    [self loadItemTableView];
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
    return [self.viewModel getHomeCellModelArray].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //cell的标识
    static NSString *homeItemCellIdentifier = @"homeItemCellIdentifier";
    XLLHomeItemCell *homeItemCell = [tableView dequeueReusableCellWithIdentifier:homeItemCellIdentifier];
    if (!homeItemCell) {
        homeItemCell = [[XLLHomeItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeItemCellIdentifier];
    }
    [homeItemCell.homeItemView setCellItemViewModel:[self.viewModel getHomeCellModelArray][indexPath.row]];
    return homeItemCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XLLHomeItemCell *homeItemCell = [tableView cellForRowAtIndexPath:indexPath];
    //得到类型 - 进入模块
    NSLog(@"%@",homeItemCell);
    if ([homeItemCell.homeItemView.modelValue.itemType isEqualToString:@"0"]) {
        //语音日志
        XLLVoiceVC *vc = [[XLLVoiceVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark -
#pragma mark    event


#pragma mark -
#pragma mark    method

- (void)loadItemTableView {
    [self.view addSubview:self.itemTableView];
    [self.itemTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}


#pragma mark -
#pragma mark    getter/setter

- (UITableView *)itemTableView {
    if (_itemTableView) {
        return _itemTableView;
    }
    _itemTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _itemTableView.delegate     = self;
    _itemTableView.dataSource   = self;
    _itemTableView.rowHeight    = 550.0f;
    _itemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _itemTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
