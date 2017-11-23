//
//  QHGroupSettingViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/23.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHGroupSettingViewController.h"
#import "QHBaseLabelCell.h"
#import "QHSwitchBtnCell.h"
#import "QHGroupMemberCell.h"

@interface QHGroupSettingViewController ()<QHGroupMemberDelegate>

@property (nonatomic, strong) UIButton *exitGroupBtn;
@property (nonatomic, assign) CGFloat memberCellHeight;

@end

@implementation QHGroupSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"群聊设置", nil);
    
    [self.tableView registerClass:[QHBaseLabelCell class] forCellReuseIdentifier:[QHBaseLabelCell reuseIdentifier]];
    [self.tableView registerClass:[QHSwitchBtnCell class] forCellReuseIdentifier:[QHSwitchBtnCell reuseIdentifier]];
    [self.tableView registerClass:[QHGroupMemberCell class] forCellReuseIdentifier:[QHGroupMemberCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.memberCellHeight = 200;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseTableViewCell *cell;
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        ((QHBaseLabelCell *)cell).arrowView.hidden = NO;
        ((QHBaseLabelCell *)cell).rightView.hidden = YES;
        ((QHBaseLabelCell *)cell).detailLabel.text = @"";
        if (indexPath.row == 0) {
            ((QHBaseLabelCell *)cell).rightView.hidden = NO;
            ((QHBaseLabelCell *)cell).arrowView.hidden = YES;
            [((QHBaseLabelCell *)cell).rightView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(((QHBaseLabelCell *)cell).arrowView.mas_left).mas_offset(8);
                make.width.height.mas_equalTo(40);
            }];
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"群头像", nil);
            ((QHBaseLabelCell *)cell).rightView.image = IMAGENAMED(@"QQ");
        } else if (indexPath.row == 1) {
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"群名称", nil);
            ((QHBaseLabelCell *)cell).detailLabel.text = @"好友群";
        } else {
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"我的群昵称", nil);
            ((QHBaseLabelCell *)cell).detailLabel.text = @"piaa99";
        }
    } else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHSwitchBtnCell reuseIdentifier]];
        if (indexPath.row == 0) {
            ((QHSwitchBtnCell *)cell).titleLabel.text = QHLocalizedString(@"置顶聊天", nil);
        } else {
            ((QHSwitchBtnCell *)cell).titleLabel.text = QHLocalizedString(@"消息提醒", nil);
        }
    } else if (indexPath.section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        ((QHBaseLabelCell *)cell).arrowView.hidden = NO;
        ((QHBaseLabelCell *)cell).rightView.hidden = YES;
        ((QHBaseLabelCell *)cell).detailLabel.text = @"";
        if (indexPath.row == 0) {
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"聊天记录", nil);
        } else {
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"清空聊天记录", nil);
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHGroupMemberCell reuseIdentifier]];
        ((QHGroupMemberCell *)cell).delegate = self;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? self.memberCellHeight : 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 3 ? 110 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView;
    if (section == 3) {
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        footerView.backgroundColor = WhiteColor;
        [footerView addSubview:self.exitGroupBtn];
    } else {
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        footerView.backgroundColor = RGBF5F6FA;
    }
    return footerView;
}

#pragma mark QHGroupMemberCell
- (void)showAllMember:(BOOL)ture {
    self.memberCellHeight = ture ? 320 : 200;
    [self.tableView reloadData];
}

- (void)tapHeadInView:(UICollectionViewCell *)cell userModel:(QHRealmContactModel *)model {
    NSLog(@"%@",model);
}

- (UIButton *)exitGroupBtn {
    if (_exitGroupBtn == nil) {
        _exitGroupBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 50)];
        _exitGroupBtn.layer.cornerRadius = 3.0f;
        [_exitGroupBtn setTitle:QHLocalizedString(@"退出群聊", nil) forState:(UIControlStateNormal)];
        _exitGroupBtn.titleLabel.font = FONT(16);
        _exitGroupBtn.backgroundColor = MainColor;
        [_exitGroupBtn addTarget:self action:@selector(exitGroup) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _exitGroupBtn;
}

- (void)exitGroup {
    
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

