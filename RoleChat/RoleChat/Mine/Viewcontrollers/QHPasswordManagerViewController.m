//
//  QHPasswordManagerViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPasswordManagerViewController.h"
#import "QHPasswordManageCell.h"
#import "QHPasswordModel.h"
#import "QHGetCodeButton.h"
#import "QHLoginModel.h"

@interface QHPasswordManagerViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@end

@implementation QHPasswordManagerViewController {
    UITableView *_mainView;
    NSMutableArray *_titleArr;
    NSMutableArray *_placeholderArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.passwordType == Password_Login ? QHLocalizedString(@"登录密码管理", nil) : QHLocalizedString(@"支付密码管理", nil);
    _titleArr = [NSMutableArray arrayWithObjects:@"登录密码", @"新的密码", @"确认密码", @"短信验证码", nil];
    _placeholderArr = [NSMutableArray arrayWithObjects:@"请输入登录密码", @"请输入新的密码", @"再次输入新密码", @"请输入验证码", nil];
    
    if (self.passwordType == Password_Pay) {
        [_titleArr replaceObjectAtIndex:0 withObject:@"支付密码"];
        [_placeholderArr replaceObjectAtIndex:0 withObject:@"请输入支付密码"];
    }
    
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
    [_mainView registerClass:[QHPasswordManageCell class] forCellReuseIdentifier:[QHPasswordManageCell reuseIdentifier]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    backView.backgroundColor = WhiteColor;
    
    UIButton *comfirnBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 60, SCREEN_WIDTH-30, 50)];
    comfirnBtn.layer.cornerRadius = 3;
    [comfirnBtn setTitle:QHLocalizedString(@"确认", nil) forState:(UIControlStateNormal)];
    [comfirnBtn setBackgroundColor:MainColor];
    [comfirnBtn addTarget:self action:@selector(changePassword) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:comfirnBtn];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHPasswordManageCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHPasswordManageCell reuseIdentifier]];
    cell.titleLabel.text = [NSString stringWithFormat:QHLocalizedString(@"%@", nil), _titleArr[indexPath.row]];
    cell.inputTextField.placeholder = [NSString stringWithFormat:QHLocalizedString(@"%@", nil), _placeholderArr[indexPath.row]];
    cell.inputTextField.delegate = self;
    cell.inputTextField.returnKeyType = UIReturnKeyDone;
    if (indexPath.row == 3) {
        QHGetCodeButton *getCodeBtn = [[QHGetCodeButton alloc] init];
        getCodeBtn.action = ^BOOL{
            return [self getCode:indexPath];
        };
        cell.inputTextField.rightViewMode = UITextFieldViewModeAlways;
        cell.inputTextField.rightView = getCodeBtn;
    } else {
        cell.inputTextField.secureTextEntry = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(BOOL)getCode:(NSIndexPath *)indexPath {
    WeakSelf
    [QHLoginModel sendSmsCodeWithCodeJson:[@{@"phoneCode" : [QHPersonalInfo sharedInstance].userInfo.phoheCode, @"phoneNumber" : [QHPersonalInfo sharedInstance].userInfo.phone, @"type" : @"code"} mj_JSONString] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf showHUDOnlyTitle:QHLocalizedString(@"验证码已发送", nil)];
    } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
    }];
    
    return YES;
}

- (void)changePassword {
    QHPasswordManageCell *oldPassCell = [_mainView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [oldPassCell.inputTextField resignFirstResponder];
    NSString *oldPass = oldPassCell.inputTextField.text;
    
    QHPasswordManageCell *newPassCell1 = [_mainView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [newPassCell1.inputTextField resignFirstResponder];
    NSString *newPass1 = newPassCell1.inputTextField.text;
    
    QHPasswordManageCell *newPassCell2 = [_mainView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [newPassCell2.inputTextField resignFirstResponder];
    NSString *newPass2 = newPassCell2.inputTextField.text;
    
    QHPasswordManageCell *codeCell = [_mainView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [codeCell.inputTextField resignFirstResponder];
    NSString *code = codeCell.inputTextField.text;
    
    if (oldPass.length && newPass1.length && newPass2.length && code.length) {
        if (![newPass1 isEqualToString:newPass2]) {
            [self showHUDOnlyTitle:QHLocalizedString(@"新密码输入不一致", nil)];
        } else {
            // 符合要求,请求接口
            WeakSelf
            if (self.passwordType == Password_Login) {
                [QHPasswordModel updatePasswordWithOldpassword:oldPass code:code newpassword:newPass1 successBlock:^(NSURLSessionDataTask *task, id responseObject) {
                    [self showHUDOnlyTitle:QHLocalizedString(@"密码修改成功", nil)];
                    PerformOnMainThreadDelay(1.5, [weakSelf.navigationController popViewControllerAnimated:YES];);
                } failure:nil];
            } else {
                [QHPasswordModel updateTradePasswordWithTradePwd:oldPass phoneCode:code newTradePwd:newPass1 successBlock:^(NSURLSessionDataTask *task, id responseObject) {
                    [self showHUDOnlyTitle:QHLocalizedString(@"密码修改成功", nil)];
                    PerformOnMainThreadDelay(1.5, [weakSelf.navigationController popViewControllerAnimated:YES];);
                } failureBlock:nil];
            }
        }
    } else {
        [self showHUDOnlyTitle:QHLocalizedString(@"请完善信息", nil)];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
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
