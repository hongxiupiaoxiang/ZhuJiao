//
//  QHSearchResultViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSearchResultViewController.h"
#import "QHSubTitleCell.h"
#import "QHFriendInfoViewController.h"

@interface QHSearchResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHSearchResultViewController {
    UITableView *_mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"添加好友", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    _mainView.backgroundColor = WhiteColor;
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainView registerClass:[QHSubTitleCell class] forCellReuseIdentifier:[QHSubTitleCell reuseIdentifier]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QHFriendInfoViewController *friendInfoVC = [[QHFriendInfoViewController alloc] init];
    QHSearchFriendModel *model = [[QHSearchFriendModel alloc] init];
    model.nickname = @"小辣椒";
    model.phoneCode = @"86";
    model.phonenumber = @"123123123";
    model.isFriend = [NSString stringWithFormat:@"%zd",indexPath.row];
    friendInfoVC.model = model;
    [self.navigationController pushViewController:friendInfoVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    backView.backgroundColor = UIColorFromRGB(0xf5f6fa);
    
    NSString *originStr = [[NSString alloc] initWithFormat:QHLocalizedString(@"%@ 的搜索结果", nil), self.searchContent];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:originStr];
    [attr addAttribute:NSForegroundColorAttributeName value:MainColor range:[originStr rangeOfString:self.searchContent]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = FONT(14);
    titleLabel.attributedText = attr;
    
    [backView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).mas_offset(15);
        make.centerY.equalTo(backView);
    }];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHSubTitleCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QHSearchFriendModel *model = [[QHSearchFriendModel alloc] init];
    model.nickname = @"小辣椒";
    model.phoneCode = @"86";
    model.phonenumber = @"123123123";
    model.isFriend = [NSString stringWithFormat:@"%zd",indexPath.row];
    cell.model = model;
    cell.addFriendBlock = ^{
        NSLog(@"哈哈");
    };
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