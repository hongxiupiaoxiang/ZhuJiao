//
//  QHShopCarViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHShopCarViewController.h"
#import "QHPepperShopCell.h"
#import "QHAmountCell.h"

@interface QHShopCarViewController ()

@property (nonatomic, strong) NSMutableArray *testArr;

@end

@implementation QHShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"购物车", nil);
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:IMAGENAMED(@"Shop_trash") forState:(UIControlStateNormal)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    [rightBtn addTarget:self action:@selector(shopTrash:) forControlEvents:(UIControlEventTouchUpInside)];

    [self.tableView registerClass:[QHPepperShopCell class] forCellReuseIdentifier:[QHPepperShopCell reuseIdentifier]];
    [self.tableView registerClass:[QHAmountCell class] forCellReuseIdentifier:[QHAmountCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *commitOrderBtn = [[UIButton alloc] init];
    [commitOrderBtn addTarget:self action:@selector(commitOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    [commitOrderBtn setTitle:QHLocalizedString(@"提交订单", nil) forState:(UIControlStateNormal)];
    commitOrderBtn.titleLabel.font = FONT(16);
    [self.view addSubview:commitOrderBtn];
    commitOrderBtn.backgroundColor = MainColor;
    [commitOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-50);
    }];
    
    _testArr = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@""]];
    // Do any additional setup after loading the view.
}

- (void)commitOrder: (UIButton *)sender {
    WeakSelf
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:QHLocalizedString(@"提交订单", nil) message:QHLocalizedString(@"是否提交订单?", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"取消", nil) style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"oh~yeah");
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)shopTrash: (UIButton *)sender {
    WeakSelf
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:QHLocalizedString(@"清空购物车", nil) message:QHLocalizedString(@"是否删除所有商品?", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"取消", nil) style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *emptyAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"清空", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.testArr removeAllObjects];
        [weakSelf.tableView reloadData];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:emptyAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.testArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 60 : 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHAmountCell reuseIdentifier]];
        ((QHAmountCell *)cell).amount = @"20000.00";
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHPepperShopCell reuseIdentifier]];
        ((QHPepperShopCell *)cell).isBuy = YES;
        ((QHPepperShopCell *)cell).callback = ^(id prama) {
            [weakSelf.testArr removeObjectAtIndex:indexPath.row];
            [weakSelf.tableView reloadData];
        };
    }
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
