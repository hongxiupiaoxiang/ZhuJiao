//
//  QHSaleDetailViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/18.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSaleDetailViewController.h"
#import "QHBaseContentCell.h"

@interface QHSaleDetailViewController ()

@end

@implementation QHSaleDetailViewController {
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"记录详情", nil);
    
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *withdrawlBtn = [[UIButton alloc] init];
    [withdrawlBtn setTitle:QHLocalizedString(@"重新提现", nil) forState:(UIControlStateNormal)];
    withdrawlBtn.backgroundColor = MainColor;
    withdrawlBtn.titleLabel.font = FONT(16);
    [self.view addSubview:withdrawlBtn];
    [withdrawlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    _titleArr = @[QHLocalizedString(@"交易编号", nil), QHLocalizedString(@"交易时间", nil), QHLocalizedString(@"交易状态", nil), QHLocalizedString(@"交易账户", nil), QHLocalizedString(@"失败原因", nil)];
    
    [self.tableView registerClass:[QHBaseContentCell class] forCellReuseIdentifier:[QHBaseContentCell reuseIdentifier]];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    
    UILabel *titleLabel = [UILabel defalutLabel];
    titleLabel.text = QHLocalizedString(@"订单总价", nil);
    [bgView addSubview:titleLabel];
    
    UILabel *amountLabel = [UILabel labelWithFont:28 color:RGB52627C];
    [bgView addSubview:amountLabel];
    amountLabel.attributedText = [NSMutableAttributedString getAttr:@"$2000.00" color:MainColor targetStr:@"$"];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(bgView).mas_offset(30);
    }];
    
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(15);
        make.centerX.equalTo(bgView);
    }];
    
    UIView *bottomView = [[QHTools toolsDefault] addLineView:bgView :CGRectZero];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).mas_offset(15);
        make.right.equalTo(bgView).mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
    
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:[QHBaseContentCell reuseIdentifier]];
    contentCell.titleLabel.text = _titleArr[indexPath.row];
    return contentCell;
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
