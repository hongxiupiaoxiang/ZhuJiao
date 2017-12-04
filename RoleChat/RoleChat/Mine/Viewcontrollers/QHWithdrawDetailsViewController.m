//
//  QHWithdrawDetailsViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHWithdrawDetailsViewController.h"
#import "QHBaseContentCell.h"

@interface QHWithdrawDetailsViewController ()

@end

@implementation QHWithdrawDetailsViewController {
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"提现详情", nil);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[QHBaseContentCell class] forCellReuseIdentifier:[QHBaseContentCell reuseIdentifier]];
    self.tableView.backgroundColor = WhiteColor;
    
    _titleArr = @[QHLocalizedString(@"交易编号", nil), QHLocalizedString(@"交易时间", nil), QHLocalizedString(@"交易状态", nil), QHLocalizedString(@"交易账户", nil)];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    
    UILabel *titleLabel = [UILabel defalutLabel];
    titleLabel.text = QHLocalizedString(@"提现金额", nil);
    [headerView addSubview:titleLabel];
    
    UILabel *amountLabel = [UILabel labelWithFont:28 color:RGB52627C];
    [headerView addSubview:amountLabel];
    amountLabel.attributedText = [NSMutableAttributedString getAttr:[NSString stringWithFormat:@"$ %.2f",[self.orderModel.amount floatValue]] color:MainColor targetStr:@"$"];
//    if ([self.orderModel.currency isEqualToString:@"USD"]) {
//        amountLabel.attributedText = [NSMutableAttributedString getAttr:[NSString stringWithFormat:@"$ %.2f",[self.orderModel.amount floatValue]] color:MainColor targetStr:@"$"];
//    } else {
//        amountLabel.attributedText = [NSMutableAttributedString getAttr:[NSString stringWithFormat:@"¥ %.2f",[self.orderModel.amount floatValue]] color:MainColor targetStr:@"¥"];
//    }
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(headerView).mas_offset(30);
    }];
    
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(15);
        make.centerX.equalTo(headerView);
    }];
    
    UIView *bottomView = [[QHTools toolsDefault] addLineView:headerView :CGRectZero];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).mas_offset(15);
        make.right.equalTo(headerView).mas_offset(-15);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(headerView);
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:[QHBaseContentCell reuseIdentifier]];
    contentCell.titleLabel.text = _titleArr[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {contentCell.contentLabel.text = self.orderModel.orderId;}
            break;
        case 1:
        {contentCell.contentLabel.text = [NSObject timechange:self.orderModel.createAt withFormat:@"yyyy/MM/dd HH:mm"];}
            break;
        case 2:
        {
            NSString *str;
            if ([self.orderModel.orderState isEqualToString:@"-1"]) {
                str = QHLocalizedString(@"删除", nil);
            } else if ([self.orderModel.orderState isEqualToString:@"1"]) {
                str = QHLocalizedString(@"创建订单", nil);
            } else if ([self.orderModel.orderState isEqualToString:@"2"]) {
                str = QHLocalizedString(@"确认打款", nil);
            } else if ([self.orderModel.orderState isEqualToString:@"3"]) {
                str = QHLocalizedString(@"订单完成", nil);
            } else if ([self.orderModel.orderState isEqualToString:@"4"]) {
                str = QHLocalizedString(@"取消订单", nil);
            }
            contentCell.contentLabel.text = str;
        }
            break;
        case 3:
        {contentCell.contentLabel.text = [NSString stringWithFormat:@"%@ (%@)",self.orderModel.bankAccount.bankName,[self.orderModel.drawAccount substringWithRange:NSMakeRange(self.orderModel.drawAccount.length-4, 4)]];
        }
            break;
        default:
            break;
    }
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
