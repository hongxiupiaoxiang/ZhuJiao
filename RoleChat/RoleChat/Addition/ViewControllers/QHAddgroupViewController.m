//
//  QHAddgroupViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHAddgroupViewController.h"
#import "QHAddFriendCell.h"
#import "QHTextFieldAlertView.h"

@interface QHAddgroupViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHAddgroupViewController {
    UIButton *_rightBtn;
    NSMutableArray *_usernameArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"创建群聊", nil);
    
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
    _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_rightBtn setTitle:QHLocalizedString(@"创建", nil) forState:(UIControlStateNormal)];
    [_rightBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    _rightBtn.titleLabel.font = FONT(14);
    [_rightBtn addTarget:self action:@selector(addGroup) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    
    _usernameArrM = [[NSMutableArray alloc] init];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)addGroup {
    if (!_usernameArrM.count) {
        return  ;
    }
    QHTextFieldAlertView *alertView = [[QHTextFieldAlertView alloc] initWithTitle:QHLocalizedString(@"群名称", nil) placeholder:QHLocalizedString(@"请输入群名称", nil) content:nil sureBlock:^(id params) {
        NSLog(@"创建成功");
    } failureBlock:nil];

    [alertView show];
}

- (void)setupUI {
    UITableView *mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    [self.view addSubview:mainView];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.backgroundColor = WhiteColor;
    [mainView registerClass:[QHAddFriendCell class] forCellReuseIdentifier:[QHAddFriendCell reuseIdentifier]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QHAddFriendCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isAdd = !cell.isAdd;
    if (cell.isAdd) {
        [_usernameArrM addObject:cell.model.username];
    } else {
        [_usernameArrM removeObject:cell.model.username];
    }
    if (_usernameArrM.count) {
        [_rightBtn setTitle:[NSString stringWithFormat:QHLocalizedString(@"创建(%zd)", nil),_usernameArrM.count] forState:(UIControlStateNormal)];
    } else {
        [_rightBtn setTitle:QHLocalizedString(@"创建", nil) forState:(UIControlStateNormal)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHAddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHAddFriendCell reuseIdentifier]];
    QHRealmContactModel *model = [[QHRealmContactModel alloc] init];
    model.nickname = [NSString stringWithFormat:@"haha%zd",indexPath.row];
    cell.model = model;
    cell.isAdd = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    return cell;
}

- (void)gotoBack {
    [self dismissViewControllerAnimated:YES completion:nil];
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
