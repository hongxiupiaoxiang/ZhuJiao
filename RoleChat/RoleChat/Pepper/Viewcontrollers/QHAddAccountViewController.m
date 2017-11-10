//
//  QHAddAccountViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHAddAccountViewController.h"
#import "QHBaseViewCell.h"

@interface QHAddAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHAddAccountViewController {
    UITableView *_mainView;
    NSArray *_picArr;
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"绑定新账户", nil);
    _titleArr = @[@"QQ", @"Wechat", @"Facebook", @"whatsapp", @"Line"];
    _picArr = @[@"Account_qq", @"Account_wechat", @"Account_facebook", @"Account_whatsapp", @"Account_line"];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [self.view addSubview:_mainView];
    _mainView.backgroundColor = WhiteColor;
    [_mainView registerClass:[QHBaseViewCell class] forCellReuseIdentifier:[QHBaseViewCell reuseIdentifier]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseViewCell reuseIdentifier]];
    cell.leftView.image = IMAGENAMED(_picArr[indexPath.row]);
    cell.titleLabel.text = _titleArr[indexPath.row];
    return cell;
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
