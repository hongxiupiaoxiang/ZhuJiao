//
//  QHChatSettingViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/19.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatSettingViewController.h"
#import "QHBaseViewCell.h"
#import "QHBaseLabelCell.h"
#import "QHSwitchBtnCell.h"
#import "QHTextFieldAlertView.h"

@interface QHChatSettingViewController ()

@property (nonatomic, strong) QHTextFieldAlertView *remarkAlertView;
@property (nonatomic, strong) UIAlertController *clearChatAlertVC;

@end

@implementation QHChatSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"聊天设置", nil);
    
    self.tableView.backgroundColor = WhiteColor;
    [self.tableView registerClass:[QHBaseViewCell class] forCellReuseIdentifier:[QHBaseViewCell reuseIdentifier]];
    [self.tableView registerClass:[QHBaseLabelCell class] forCellReuseIdentifier:[QHBaseLabelCell reuseIdentifier]];
    [self.tableView registerClass:[QHSwitchBtnCell class] forCellReuseIdentifier:[QHSwitchBtnCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1f : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 70 : 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView;
    if (section == 0) {
        headerView = [UIView new];
    } else {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        headerView.backgroundColor = RGBF5F6FA;
    }
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseTableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseViewCell reuseIdentifier]];
        [((QHBaseViewCell *)cell).leftView loadImageWithUrl:self.contactModel.imgurl placeholder:ICON_IMAGE];
        ((QHBaseViewCell *)cell).titleLabel.text = self.contactModel.nickname;
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"备注", nil);
        ((QHBaseLabelCell *)cell).detailLabel.text = @"Pepper";
    } else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHSwitchBtnCell reuseIdentifier]];
        if (indexPath.row == 0) {
            ((QHSwitchBtnCell *)cell).titleLabel.text = QHLocalizedString(@"置顶聊天", nil);
        } else {
            ((QHSwitchBtnCell *)cell).titleLabel.text = QHLocalizedString(@"消息提醒", nil);
        }
    } else if (indexPath.section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        if (indexPath.row == 0) {
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"聊天记录", nil);
        } else {
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"清空聊天记录", nil);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self.remarkAlertView show];
    } else if (indexPath.section == 3) {
        if (indexPath.row == 1) {
            [self presentViewController:self.clearChatAlertVC animated:YES completion:nil];
        }
    }
}

- (UIAlertController *)clearChatAlertVC {
    if (_clearChatAlertVC == nil) {
        _clearChatAlertVC = [UIAlertController alertControllerWithTitle:QHLocalizedString(@"清除聊天记录", nil) message:QHLocalizedString(@"确认清除聊天记录?", nil) preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"取消", nil) style:(UIAlertActionStyleCancel) handler:nil];
        [_clearChatAlertVC addAction:cancelAction];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"确定", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [_clearChatAlertVC addAction:sureAction];
    }
    return _clearChatAlertVC;
}

- (QHTextFieldAlertView *)remarkAlertView {
    if (_remarkAlertView == nil) {
        _remarkAlertView = [[QHTextFieldAlertView alloc] initWithTitle:QHLocalizedString(@"修改备注", nil) placeholder:nil content:@"Pepper" sureBlock:^(id params) {
            
        } failureBlock:nil];
    }
    return _remarkAlertView;
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
