//
//  QHPersonalInfoViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPersonalInfoViewController.h"
#import "QHSimplePersoninfoCell.h"
#import "QHBaseLabelCell.h"
#import "QHAddFriendCodeView.h"
#import "QHTextFieldAlertView.h"
#import "QHGenderAlertView.h"

@interface QHPersonalInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation QHPersonalInfoViewController {
    UITableView *_mainView;
    NSArray *_mainTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"个人信息", nil);
    
    _mainTitles = @[@"二维码", @"昵称", @"地区", @"性别"];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    _mainView.backgroundColor = WhiteColor;
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(_mainView)weakView = _mainView;
    _mainView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakView reloadData];
    }];
    
    [_mainView registerClass:[QHSimplePersoninfoCell class] forCellReuseIdentifier:[QHSimplePersoninfoCell reuseIdentifier]];
    [_mainView registerClass:[QHBaseLabelCell class] forCellReuseIdentifier:[QHBaseLabelCell reuseIdentifier]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 140 : 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = UIColorFromRGB(0xf5f6fa);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1f : 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHSimplePersoninfoCell reuseIdentifier]];
        [((QHSimplePersoninfoCell *)cell).headView loadImageWithUrl:@"" placeholder:ICON_IMAGE];
        ((QHSimplePersoninfoCell *)cell).nameLabel.text = [QHPersonalInfo sharedInstance].userInfo.nickname;
        ((QHSimplePersoninfoCell *)cell).phoneLabel.text = [NSString stringWithFormat:@"+%@ %@",[QHPersonalInfo sharedInstance].userInfo.phoheCode, [QHPersonalInfo sharedInstance].userInfo.phone];
        UIImage *img = [[QHPersonalInfo sharedInstance].userInfo.gender isEqualToString:@"1"] ? IMAGENAMED(@"gender_male") : IMAGENAMED(@"gender_female");
        [((QHSimplePersoninfoCell *)cell).genderView setImage:img forState:(UIControlStateNormal)];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        ((QHBaseLabelCell *)cell).titleLabel.text = [NSString stringWithFormat:QHLocalizedString(@"%@", nil),_mainTitles[indexPath.row]];
        if (indexPath.row == 0) {
            ((QHBaseLabelCell *)cell).rightView.image = IMAGENAMED(@"qrcode");
        } else if(indexPath.row == 1) {
            ((QHBaseLabelCell *)cell).detailLabel.text = [QHPersonalInfo sharedInstance].userInfo.nickname;
        } else if (indexPath.row == 2) {
            ((QHBaseLabelCell *)cell).detailLabel.text = QHLocalizedString(@"中国", nil);
        } else if (indexPath.row == 3) {
            ((QHBaseLabelCell *)cell).detailLabel.text = [[QHPersonalInfo sharedInstance].userInfo.gender isEqualToString:@"1"] ? QHLocalizedString(@"男", nil) : QHLocalizedString(@"女", nil);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(_mainView)weakView = _mainView;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [[QHAddFriendCodeView manager] show];
        } else if (indexPath.row == 1) {
            QHTextFieldAlertView *textFieldAlertView = [[QHTextFieldAlertView alloc] initWithTitle:QHLocalizedString(@"昵称", nil) placeholder:[QHPersonalInfo sharedInstance].userInfo.nickname sureBlock:^{
                
            } failureBlock:nil];
            [textFieldAlertView show];
        } else if (indexPath.row == 3) {
            QHGenderAlertView *genderAlertView = [[QHGenderAlertView alloc] initWithGender:[QHPersonalInfo sharedInstance].userInfo.gender callbackBlock:^{
                [weakView reloadData];
            }];
            [genderAlertView show];
        }
    }
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
