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

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray<QHBankModel *> *bankModelArr;

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
    
    WeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf loadData];
    }];
    
    self.bankModelArr = [[NSMutableArray alloc] init];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex++;
        [weakSelf loadData];
    }];
    
    [self startRefresh];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    [QHBankModel queryBankAccountWithPageIndex:self.pageIndex pageSize:kDefaultPagesize successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [self stopRefresh];
        if (self.pageIndex==1) {
            [self.bankModelArr removeAllObjects];
        }
        NSArray *modelArr = [NSArray modelArrayWithClass:[QHBankModel class] json:responseObject[@"data"]];
        if (modelArr.count) {
            [self.bankModelArr addObjectsFromArray:modelArr];
            [self.tableView reloadData];
        }
    } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [self stopRefresh];
        self.pageIndex --;
        [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     QHAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHAccountCell reuseIdentifier]];
    cell.model = self.bankModelArr[indexPath.row];
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
