//
//  QHSocialAccountViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocialAccountViewController.h"
#import "QHEditBaseViewCell.h"
#import "QHAddAccountViewController.h"

@interface QHSocialAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *picArr;
@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, assign) BOOL isEdit;

@end

@implementation QHSocialAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"社交账户", nil);
    
    UIButton *editBtn = [[UIButton alloc] init];
    [editBtn setTitle:QHLocalizedString(@"保存", nil) forState:(UIControlStateNormal)];
    [editBtn setTitle:QHLocalizedString(@"编辑", nil) forState:(UIControlStateSelected)];
    [editBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [editBtn addTarget:self action:@selector(edit:) forControlEvents:(UIControlEventTouchUpInside)];
    editBtn.titleLabel.font = FONT(14);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    [self addRightItem:rightItem complete:nil];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)edit: (UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.isEdit = sender.isSelected;
    [self.mainView reloadData];
}

- (void)setupUI {
    self.mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    [self.view addSubview:self.mainView];
    self.mainView.backgroundColor = WhiteColor;
    self.mainView.delegate = self;
    self.mainView.dataSource = self;
    [self.mainView registerClass:[QHEditBaseViewCell class] forCellReuseIdentifier:[QHEditBaseViewCell reuseIdentifier]];
    self.mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.titleArr = [[NSMutableArray alloc] initWithArray:@[@"QQ", @"Wechat", @"Facebook"]];
    self.picArr = [[NSMutableArray alloc] initWithArray:@[@"Account_qq", @"Account_wechat", @"Account_facebook"]];
    self.isEdit = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    backView.backgroundColor = WhiteColor;
    
    UIButton *addAccountBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 60, SCREEN_WIDTH-30, 50)];
    addAccountBtn.titleLabel.font = FONT(16);
    [addAccountBtn setBackgroundImage:IMAGENAMED(@"Account_btn") forState:(UIControlStateNormal)];
    [addAccountBtn setImage:IMAGENAMED(@"add") forState:(UIControlStateNormal)];
    addAccountBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [addAccountBtn setTitle:QHLocalizedString(@"绑定新账户", nil) forState:(UIControlStateNormal)];
    [addAccountBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [backView addSubview:addAccountBtn];
    [addAccountBtn addTarget:self action:@selector(addAccount) forControlEvents:(UIControlEventTouchUpInside)];
    
    return backView;
}

- (void)addAccount {
    QHAddAccountViewController *addAccountVC = [[QHAddAccountViewController alloc] init];
    [self.navigationController pushViewController:addAccountVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHEditBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHEditBaseViewCell reuseIdentifier]];
    cell.leftView.image = IMAGENAMED(_picArr[indexPath.row]);
    cell.titleLabel.text = _titleArr[indexPath.row];
    
    WeakSelf
    cell.callback = ^(id params) {
        [weakSelf.titleArr removeObjectAtIndex:indexPath.row];
        [weakSelf.picArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowAtIndexPath:indexPath withRowAnimation:(UITableViewRowAnimationFade)];
    };
    cell.isEdit = self.isEdit;
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
