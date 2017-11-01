//
//  QHCallStatusViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHCallStatusViewController.h"
#import "QHMessageSettingModel.h"

#define SWITCHBTN_TAG 666

static NSString *reuseID = @"simplecell";

@interface QHCallStatusViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHCallStatusViewController {
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"设置", nil);
    _titleArr = @[QHLocalizedString(@"新消息提醒", nil), QHLocalizedString(@"声音提醒", nil), QHLocalizedString(@"震动提醒", nil)];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    UITableView *mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.backgroundColor = WhiteColor;
    [self.view addSubview:mainView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseID];
    [cell.contentView removeAllSubviews];
    
    UILabel *titleLabel = [UILabel labelWithFont:15 color:UIColorFromRGB(0x4a5970)];
    [cell.contentView addSubview:titleLabel];
    titleLabel.text = _titleArr[indexPath.row];
    
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 48, 24)];
    switchBtn.backgroundColor = UIColorFromRGB(0xc5c6c1);
    switchBtn.tintColor = UIColorFromRGB(0xc5c6c1);
    switchBtn.onTintColor = UIColorFromRGB(0xff4c79);
    switchBtn.thumbTintColor = WhiteColor;
    switchBtn.layer.cornerRadius = 15.5;
    switchBtn.layer.masksToBounds = YES;
    switchBtn.tag = SWITCHBTN_TAG + indexPath.row;
    [switchBtn addTarget:self action:@selector(changeStates:) forControlEvents:(UIControlEventValueChanged)];
    cell.accessoryView = switchBtn;
    if (indexPath.row == 0) {
        switchBtn.on = [[QHPersonalInfo sharedInstance].userInfo.messagecall isEqualToString:@"1"];
    } else if (indexPath.row == 1) {
        switchBtn.on = [[QHPersonalInfo sharedInstance].userInfo.voicecall isEqualToString:@"1"];
    } else if (indexPath.row == 2) {
        switchBtn.on = [[QHPersonalInfo sharedInstance].userInfo.shockcall isEqualToString:@"1"];
    }
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).mas_offset(15);
    }];
    
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    return cell;
}

- (void)changeStates: (UISwitch *)sender {
    WeakSelf
    
    NSString *messageState = [QHPersonalInfo sharedInstance].userInfo.messagecall;
    NSString *voiceState = [QHPersonalInfo sharedInstance].userInfo.voicecall;
    NSString *shockState = [QHPersonalInfo sharedInstance].userInfo.shockcall;
    
    switch (sender.tag - SWITCHBTN_TAG) {
        case 0:
        {messageState = [self changeValue:messageState];}
            break;
        case 1:
        {voiceState = [self changeValue:voiceState];}
            break;
        case 2:
        {shockState = [self changeValue:shockState];}
            break;
        default:
            break;
    }
    
    [QHMessageSettingModel updateCallStatusWithMessagecall:messageState voicecall:voiceState shockcall:shockState successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [QHPersonalInfo sharedInstance].userInfo.messagecall = messageState;
        [QHPersonalInfo sharedInstance].userInfo.voicecall = voiceState;
        [QHPersonalInfo sharedInstance].userInfo.shockcall = shockState;
        [weakSelf showHUDOnlyTitle:QHLocalizedString(@"设置成功", nil)];
    } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
        sender.on = !sender.isOn;
    }];
}

- (NSString *)changeValue: (NSString *)value {
    return [value isEqualToString:@"1"] ? @"2" : @"1";
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
