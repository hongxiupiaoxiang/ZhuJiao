//
//  QHChatAutoViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatAutoViewController.h"
#import "QHBaseViewCell.h"
#import "QHManagerModeViewController.h"

@interface QHChatAutoViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHChatAutoViewController {
    UITableView *_mainView;
    NSArray *_titleArr;
    NSArray *_picArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"聊天托管", nil);
    
    _titleArr = @[@"QQ", @"Wechat", @"Facebook", @"whatsapp", @"Line"];
    _picArr = @[@"Account_qq", @"Account_wechat", @"Account_facebook", @"Account_whatsapp", @"Account_line"];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [self.view addSubview:_mainView];
    _mainView.backgroundColor = WhiteColor;
    [_mainView registerClass:[QHBaseViewCell class] forCellReuseIdentifier:[QHBaseViewCell reuseIdentifier]];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseViewCell reuseIdentifier]];
    cell.leftView.image = IMAGENAMED(_picArr[indexPath.row]);
    cell.titleLabel.text = _titleArr[indexPath.row];
    if (indexPath.row == 4) {
        cell.detailLabel.text = QHLocalizedString(@"自荐-伪装模式", nil);
        cell.detailLabel.textColor = MainColor;
    } else {
        cell.detailLabel.text = QHLocalizedString(@"已关闭", nil);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QHManagerModeViewController *modeVC = [[QHManagerModeViewController alloc] init];
    [self.navigationController pushViewController:modeVC animated:YES];
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
