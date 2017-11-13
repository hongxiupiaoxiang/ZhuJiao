//
//  QHSettleOrderViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSettleOrderViewController.h"

@interface QHSettleOrderViewController ()

@end

@implementation QHSettleOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"结算订单", nil);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *orderBtn = [[UIButton alloc] init];
    [orderBtn addTarget:self action:@selector(order:) forControlEvents:(UIControlEventTouchUpInside)];
    [orderBtn setTitle:QHLocalizedString(@"支付", nil) forState:(UIControlStateNormal)];
    orderBtn.titleLabel.font = FONT(16);
    [self.view addSubview:orderBtn];
    orderBtn.backgroundColor = MainColor;
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-50);
    }];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 3 : 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    [[QHTools toolsDefault] addLineView:backView :CGRectMake(0, 100, SCREEN_WIDTH, 10)];
    
    UILabel *titleLabel = [UILabel labelWithFont:15 color:RGB52627C];
    [backView addSubview:titleLabel];
    titleLabel.text = QHLocalizedString(@"订单总价", nil);
    
    return backView;
}

- (void)order: (UIButton *)sender {
    
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
