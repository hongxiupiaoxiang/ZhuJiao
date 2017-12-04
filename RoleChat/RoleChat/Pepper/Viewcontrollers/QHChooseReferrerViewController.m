//
//  QHChooseReferrerViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChooseReferrerViewController.h"
#import "QHAddFriendCell.h"

@interface QHChooseReferrerViewController ()

@property (nonatomic, assign) NSInteger seletedIndex;

@end

@implementation QHChooseReferrerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"选择推荐人", nil);
    
    self.seletedIndex = -1;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:QHLocalizedString(@"确定", nil) forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    rightBtn.titleLabel.font = FONT(14);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    
    self.tableView.backgroundColor = WhiteColor;
    [self.tableView registerClass:[QHAddFriendCell class] forCellReuseIdentifier:[QHAddFriendCell reuseIdentifier]];
    // Do any additional setup after loading the view.
}

- (void)btnClick: (UIButton *)sender {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.seletedIndex = indexPath.row;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHAddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHAddFriendCell reuseIdentifier]];
    if (self.seletedIndex == indexPath.row) {
        cell.isAdd = YES;
    } else {
        cell.isAdd = NO;
    }
    QHRealmContactModel *model = [[QHRealmContactModel alloc] init];
    model.nickname = @"Pepper";
    cell.model = model;
    cell.separatorInset = UIEdgeInsetsMake(0, 70, 0, 15);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
