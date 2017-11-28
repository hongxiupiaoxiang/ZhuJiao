//
//  QHPersonInfoViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPersonInfoViewController.h"
#import "QHSubTitleCell.h"
#import "QHBaseLabelCell.h"
#import "QHPopRightButtonView.h"
#import "QHTextFieldAlertView.h"

@interface QHPersonInfoViewController ()

@property (nonatomic, strong) UIButton *chatBtn;
@property (nonatomic, strong) QHPopRightButtonView *popView;
@property (nonatomic, strong) QHTextFieldAlertView *alertView;

@end

@implementation QHPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"用户信息", nil);
    
    self.tableView.backgroundColor = WhiteColor;
    [self.tableView registerClass:[QHSubTitleCell class] forCellReuseIdentifier:[QHSubTitleCell reuseIdentifier]];
    [self.tableView registerClass:[QHBaseLabelCell class] forCellReuseIdentifier:[QHBaseLabelCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn addTarget:self action:@selector(deleteFriend) forControlEvents:(UIControlEventTouchUpInside)];
    [rightBtn setImage:IMAGENAMED(@"Chat_more") forState:(UIControlStateNormal)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    // Do any additional setup after loading the view.
}

- (void)deleteFriend {
    [self.popView show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 70 : 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1f : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? 0.1f : 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view;
    if (section == 0) {
        view = [UIView new];
    } else {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = RGBF5F6FA;
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view;
    if (section == 0) {
        view = [UIView new];
    } else {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        view.backgroundColor = WhiteColor;
        [view addSubview:self.chatBtn];
    }
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.alertView show];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseTableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHSubTitleCell reuseIdentifier]];
        UIImageView *headView = cell.contentView.subviews[0];
        [headView loadImageWithUrl:self.contactModel.imgurl placeholder:ICON_IMAGE];
        UILabel *nameLabel = cell.contentView.subviews[1];
        nameLabel.text = self.contactModel.nickname;
        UILabel *phoneLabel = cell.contentView.subviews[2];
        phoneLabel.text = [NSString stringWithFormat:@"+%@ %@",self.contactModel.phoneCode,[NSString getPhoneHiddenStringWithPhone:self.contactModel.phone]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        if (indexPath.row == 0) {
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"备注", nil);
            ((QHBaseLabelCell *)cell).detailLabel.text = QHLocalizedString(@"撒打开了", nil);
        } else {
            ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"地区", nil);
            [[QHTools toolsDefault] getZoneCodeWithCallback:^(id params) {
                ((QHBaseLabelCell *)cell).detailLabel.text = params;
            }];
            ((QHBaseLabelCell *)cell).arrowView.hidden = YES;
            [((QHBaseLabelCell *)cell).detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(((QHBaseLabelCell *)cell).arrowView.mas_left).mas_offset(8);
            }];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIButton *)chatBtn {
    if (_chatBtn == nil) {
        _chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 50)];
        [_chatBtn setTitle:QHLocalizedString(@"聊天", nil) forState:(UIControlStateNormal)];
        _chatBtn.backgroundColor = MainColor;
        _chatBtn.titleLabel.font = FONT(16);
        _chatBtn.layer.cornerRadius = 3.0f;
        [_chatBtn addTarget:self action:@selector(chat) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _chatBtn;
}

- (QHPopRightButtonView *)popView {
    if (_popView == nil) {
        WeakSelf
        _popView = [[QHPopRightButtonView alloc] initWithTitleArray:@[QHLocalizedString(@"删除好友", nil)] point:CGPointMake(SCREEN_WIDTH-135, 64) selectIndexBlock:^(id params) {
            [weakSelf deleteContactModel];
        }];
        _popView.titleColor = MainColor;
    }
    return _popView;
}

- (void)deleteContactModel {
    WeakSelf
    [[QHSocketManager manager] deleteFriendsWithUserId:self.contactModel.openid completion:^(id response) {
        RLMResults *result = [QHRealmContactModel objectsInRealm:[QHRealmDatabaseManager currentRealm] where:@"openid =%@",self.contactModel.openid];
        QHRealmContactModel *model = result[0];
        [QHRealmDatabaseManager deleteRecord:model];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } failure:nil];
}

- (QHTextFieldAlertView *)alertView {
    if (_alertView == nil) {
        _alertView = [[QHTextFieldAlertView alloc] initWithTitle:QHLocalizedString(@"修改备注", nil) placeholder:@"fuck" content:nil sureBlock:^(id params) {
            
        } failureBlock:nil];
    }
    return _alertView;
}

- (void)chat {
    NSLog(@"chat");
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
