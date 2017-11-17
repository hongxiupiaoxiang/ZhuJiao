//
//  QHWalletViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHWalletViewController.h"
#import "QHBaseViewCell.h"
#import "QHWalletAccountViewController.h"

@interface QHWalletViewController ()

@end

@implementation QHWalletViewController {
    NSArray *_titleArr;
    NSArray *_picArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"钱包", nil);
    
    [self.tableView registerClass:[QHBaseViewCell class] forCellReuseIdentifier:[QHBaseViewCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *withdrawalBtn = [[UIButton alloc] init];
    [withdrawalBtn addTarget:self action:@selector(withdrawal:) forControlEvents:(UIControlEventTouchUpInside)];
    [withdrawalBtn setTitle:QHLocalizedString(@"提现", nil) forState:(UIControlStateNormal)];
    withdrawalBtn.titleLabel.font = FONT(16);
    [self.view addSubview:withdrawalBtn];
    withdrawalBtn.backgroundColor = WhiteColor;
    withdrawalBtn.layer.borderColor = UIColorFromRGB(0xf0f1f5).CGColor;
    withdrawalBtn.layer.borderWidth = 1.0f;
    [withdrawalBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-50);
    }];
    
    _picArr = @[@"Wallet_account", @"Wallet_sale", @"Wallet_withdrawal"];
    _titleArr = @[QHLocalizedString(@"交易账户", nil), QHLocalizedString(@"销售记录", nil), QHLocalizedString(@"提现记录", nil)];
    // Do any additional setup after loading the view.
}

- (void)withdrawal: (UIButton *)sender {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QHWalletAccountViewController *accountVC = [[QHWalletAccountViewController alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    [self.navigationController pushViewController:accountVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 170;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    backView.backgroundColor = WhiteColor;
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 140)];
    bgView.image = IMAGENAMED(@"Wallet_green");
    [backView addSubview:bgView];
    
    UILabel *balance = [UILabel labelWithFont:15 color:WhiteColor];
    [bgView addSubview:balance];
    balance.text = QHLocalizedString(@"钱包余额", nil);
    
    UILabel *money = [UILabel labelWithFont:20 color:WhiteColor];
    [bgView addSubview:money];
    money.text = @"$50000.00";
    
    UILabel *description = [UILabel labelWithFont:12 color:WhiteColor];
    [bgView addSubview:description];
    description.text = QHLocalizedString(@"成功销售后获得的提成会放入钱包余额,您可以提取到您的交易账户中", nil);
    
    [balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).mas_offset(20);
        make.left.equalTo(bgView).mas_offset(15);
    }];
    
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balance.mas_bottom).mas_offset(15);
        make.left.equalTo(bgView).mas_offset(15);
    }];
    
    [description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(money.mas_bottom).mas_offset(15);
        make.left.equalTo(bgView).mas_offset(15);
    }];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseViewCell reuseIdentifier]];
    [cell.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18);
    }];
    UIView *bottomView = cell.contentView.subviews[3];
    [bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView).mas_offset(15);
    }];
    cell.leftView.image = IMAGENAMED(_picArr[indexPath.row]);
    cell.titleLabel.text = _titleArr[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end