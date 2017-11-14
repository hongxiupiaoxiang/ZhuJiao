//
//  QHWalletAccountViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHWalletAccountViewController.h"
#import "QHAccountCell.h"
#import "QHWalletAddAccountViewController.h"

@interface QHWalletAccountViewController ()

@end

@implementation QHWalletAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"交易账户", nil);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QHAccountCell class] forCellReuseIdentifier:[QHAccountCell reuseIdentifier]];
    self.tableView.backgroundColor = WhiteColor;
    
    UIButton *addAccount = [[UIButton alloc] init];
    [addAccount addTarget:self action:@selector(addAccount:) forControlEvents:(UIControlEventTouchUpInside)];
    [addAccount setTitle:QHLocalizedString(@"添加交易账户", nil) forState:(UIControlStateNormal)];
    addAccount.titleLabel.font = FONT(16);
    [self.view addSubview:addAccount];
    addAccount.backgroundColor = WhiteColor;
    addAccount.layer.borderColor = UIColorFromRGB(0xf0f1f5).CGColor;
    addAccount.layer.borderWidth = 1.0f;
    [addAccount setTitleColor:MainColor forState:(UIControlStateNormal)];
    [addAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-50);
    }];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     QHAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHAccountCell reuseIdentifier]];
    return cell;
}

- (void)addAccount: (UIButton *)sender {
    QHWalletAddAccountViewController *addAccountVC = [[QHWalletAddAccountViewController alloc] init];
    [self.navigationController pushViewController:addAccountVC animated:YES];
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
