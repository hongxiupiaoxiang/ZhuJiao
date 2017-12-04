//
//  QHAddAccountViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHWalletAddAccountViewController.h"
#import "QHTextFieldCell.h"
#import "QHBankModel.h"

#define BASE_TAG 666

@interface QHWalletAddAccountViewController ()<UITextFieldDelegate>

@end

@implementation QHWalletAddAccountViewController {
    NSMutableArray<UITextField *> *_textFields;
    NSArray *_titles;
    NSArray *_placeholders;
    UIButton *_completeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"添加交易账户", nil);
    
    _textFields = [[NSMutableArray alloc] init];
    
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QHTextFieldCell class] forCellReuseIdentifier:[QHTextFieldCell reuseIdentifier]];
    
    _titles = @[QHLocalizedString(@"持卡人姓名", nil),QHLocalizedString(@"身份证号", nil),QHLocalizedString(@"银行卡号", nil),QHLocalizedString(@"手机号码", nil)];
    _placeholders = @[QHLocalizedString(@"请输入持卡人姓名", nil),QHLocalizedString(@"请输入身份证号", nil),QHLocalizedString(@"请输入银行卡号", nil),QHLocalizedString(@"请输入手机号码", nil)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkDataValid) name:UITextFieldTextDidChangeNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resiginTextfield)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)resiginTextfield {
    for (UITextField *textField in _textFields) {
        [textField resignFirstResponder];
    }
}

- (void)checkDataValid {
    for (UITextField *textField in _textFields) {
        if (!textField.text.length) {
            _completeBtn.enabled = NO;
            return;
        }
    }
    _completeBtn.enabled = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    
    _completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 120, SCREEN_WIDTH-30, 50)];
    [_completeBtn setBackgroundImage:[UIImage imageWithColor:MainColor] forState:UIControlStateNormal];
    [_completeBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf5f6fa)] forState:UIControlStateDisabled];
    [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_completeBtn setTitleColor:UIColorFromRGB(0xc8c9cc) forState:(UIControlStateDisabled)];
    _completeBtn.layer.cornerRadius = 3.0f;
    [_completeBtn setTitle:QHLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [_completeBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_completeBtn];
    _completeBtn.enabled = NO;
    
    return footerView;
}

- (void)confirmBtnPressed {
    [QHBankModel addBankAccountWithPhoneNumber:_textFields[3].text idNo:_textFields[1].text accountNumber:_textFields[2].text realName:_textFields[0].text currency:@"CNY" successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        QHBankModel *bankModel = [QHBankModel modelWithJSON:responseObject[@"data"]];
        if ([self.delegate respondsToSelector:@selector(addBankAccount:)]) {
            [self.delegate addBankAccount:bankModel];
        }
        [self showHUDOnlyTitle:QHLocalizedString(@"添加银行卡成功", nil)];
        PerformOnMainThreadDelay(1.5, [self.navigationController popViewControllerAnimated:YES];);
    } failureBlock:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHTextFieldCell reuseIdentifier]];
    cell.titleLabel.text = _titles[indexPath.row];
    cell.textFileld.placeholder = _placeholders[indexPath.row];
    [self configTextField:cell.textFileld atIndex:indexPath.row];
    return cell;
}

- (void)configTextField: (UITextField *)textField atIndex: (NSInteger)index {
    textField.delegate = self;
    [_textFields addObject:textField];
    if (index < 3) {
        textField.returnKeyType = UIReturnKeyNext;
    } else {
        textField.returnKeyType = UIReturnKeyDone;
    }
    if (index > 0) {
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    
    if (!self.isFirstCard && (index == 0 || index == 1)) {
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 60)];
        [rightBtn setImage:IMAGENAMED(@"Wallet_edit") forState:(UIControlStateNormal)];
        textField.rightView = rightBtn;
        textField.rightViewMode = UITextFieldViewModeAlways;
        rightBtn.tag = BASE_TAG+index;
        [rightBtn addTarget:self action:@selector(clearText:) forControlEvents:(UIControlEventTouchUpInside)];
        
        if (index == 0 && self.realName) {
            textField.text = [NSString getNameHiddenStringWithName:self.realName];
        } else if (index == 1 && self.accountNumber) {
            textField.text = [NSString getIdCardHiddenStringWithIdCard:self.accountNumber];
        }
    }
}

- (void)clearText: (UIButton *)sender {
    NSInteger index = sender.tag - BASE_TAG;
    UITextField *textField = _textFields[index];
    textField.text = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger i = [_textFields indexOfObject:textField];
    if (i < 3) {
        [[_textFields objectAtIndex:i+1] becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)keyboardWillShow:(NSDictionary *)keyboardFrameInfo {
    CGRect textFieldFrame = CGRectZero, keyboardFrame = [keyboardFrameInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    for (NSInteger i = 0; i < _textFields.count; i++) {
        if ([_textFields[i] isFirstResponder]) {
            QHTextFieldCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            textFieldFrame = cell.frame;
            break;
        }
    }
    
    if(textFieldFrame.origin.y + 124 >= keyboardFrame.origin.y) {
        [UIView animateWithDuration:[keyboardFrameInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            CGRect frame = CGRectMake(0, 0, self.view.width, self.view.height);
            frame.origin.y += (keyboardFrame.origin.y - textFieldFrame.origin.y - 124);
            self.view.frame = frame;
        }];
    } else {
        [UIView animateWithDuration:[keyboardFrameInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 65;
            self.view.frame = frame;
        }];
    }
}

-(void)keyboardWillHide:(NSDictionary *)keyboardFrameInfo {
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    self.view.frame = frame;
    
    [UIView animateWithDuration:[keyboardFrameInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        [self.view layoutIfNeeded];
    }];
    return ;
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
