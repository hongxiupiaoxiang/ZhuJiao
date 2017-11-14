//
//  QHPerfectInfoViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/6.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPersonalInfo.h"
#import "QHGetCodeButton.h"
#import "QHTools.h"
#import "QHError.h"
#import "QHNewUserReigstTextInput.h"
#import "QHGetZoneCodeViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "QHPerfectInfoViewController.h"
#import "QHMainTabBarViewController.h"
#import "QHLoginModel.h"
#import "QHRealmLoginModel.h"

@interface QHPerfectInfoViewController () <UIScrollViewDelegate, QHNewUserRegistTextInputDelegate>

@property(nonatomic, copy) NSArray* placeHolders;
@property(nonatomic, strong) NSMutableArray* textInputCells;
@property(nonatomic, strong) UIButton* userZoneNoBtn;
@property(nonatomic, strong) UIButton* userRegistConfirmBtn;

@end

@implementation QHPerfectInfoViewController {
    NSString *internalPhoneCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _placeHolders = @[QHLocalizedString(@"请输入支付密码", nil), QHLocalizedString(@"请确认支付密码", nil), QHLocalizedString(@"请输入手机号码", nil), QHLocalizedString(@"手机验证码", nil)];
    _textInputCells = [NSMutableArray array];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20.0f, 0.0f, 0.0f, 0.0f);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [self footerView];
    self.tableView.tableHeaderView = [self headView];
    
    self.tableView.backgroundColor = WhiteColor;
    
    self.fd_prefersNavigationBarHidden = YES;
    
    return ;
}

-(UIView*)headView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    header.backgroundColor = [UIColor clearColor];
    
    UIImageView *signupView = [[UIImageView alloc] init];
    signupView.image = IMAGENAMED(@"information");
    [header addSubview:signupView];
    [signupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header).mas_offset(70);
        make.left.equalTo(header).mas_offset(15);
        make.width.mas_equalTo(258);
        make.height.mas_equalTo(100);
    }];
    
    UIImageView *rightView = [[UIImageView alloc] init];
    rightView.image = IMAGENAMED(@"Login circle-2");
    [header addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(header);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(86);
    }];
    
    return header;
}

-(UIView*)footerView {
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    footer.backgroundColor = [UIColor clearColor];
    
    _userRegistConfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userRegistConfirmBtn setBackgroundImage:[UIImage imageWithColor:MainColor] forState:UIControlStateNormal];
    [_userRegistConfirmBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf5f6fa)] forState:UIControlStateDisabled];
    [_userRegistConfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_userRegistConfirmBtn setTitleColor:UIColorFromRGB(0xc8c9cc) forState:(UIControlStateDisabled)];
    _userRegistConfirmBtn.layer.cornerRadius = 3.0f;
    _userRegistConfirmBtn.clipsToBounds = YES;
    _userRegistConfirmBtn.frame = CGRectMake(15.0f, 90.0f, footer.bounds.size.width - 30.0f, 50.0f);
    [_userRegistConfirmBtn setTitle:QHLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [_userRegistConfirmBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:_userRegistConfirmBtn];
    
    _userRegistConfirmBtn.enabled = NO;
    
    return footer;
}

-(NSString *)contentForTextInputIndex:(NSInteger)index {
    return ((QHNewUserReigstTextInput*)[((UITableViewCell*)[_textInputCells objectAtIndex:index]).contentView viewWithTag:1234]).inputTextInput.text;
}


- (BOOL)checkContentIsValid {
    BOOL isValid = YES;
    for (UITableViewCell* vCell in _textInputCells) {
        QHNewUserReigstTextInput* textInput = (QHNewUserReigstTextInput*)[vCell.contentView viewWithTag:1234];
        if(textInput.bDataValid == NO) {
            isValid = NO;
            return isValid;
        }
    }
    return isValid;
}

-(void)confirmBtnPressed {
    BOOL canSendReqeust = YES;
    
    for (UITableViewCell* vCell in _textInputCells) {
        QHNewUserReigstTextInput* textInput = (QHNewUserReigstTextInput*)[vCell.contentView viewWithTag:1234];
        if(textInput.bDataValid == NO) {
            canSendReqeust = NO;
            if (!textInput.inputTextInput.text.length) {
                [self showHUDOnlyTitle:QHLocalizedString(@"数据不完整", nil)];
            } else {
                [self showHUDOnlyTitle:QHLocalizedString(@"填写有误", nil)];
            }
            break ;
        }
    }
    
    if(canSendReqeust == YES) {
        WeakSelf
        [QHLoginModel bandPhoneWithPhone:[self contentForTextInputIndex:0] phoneCode:internalPhoneCode verifyCode:[self contentForTextInputIndex:1] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf showHUDOnlyTitle:QHLocalizedString(@"绑定手机号成功", nil)];
            PerformOnMainThreadDelay(1.5, [weakSelf login];);
        } failureBlock:nil];
    }
    
    return ;
}


- (void)login {
    QHMainTabBarViewController *mainTabbarVC = [[QHMainTabBarViewController alloc] init];
    [UIView transitionFromView:self.navigationController.view toView:mainTabbarVC.view duration:kDefaultAnimationIntervalKey options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        App_Delegate.window.rootViewController = mainTabbarVC;
    }];
}

-(void)keyboardWillShow:(NSDictionary *)keyboardFrameInfo {
    
    CGRect textFieldFrame = CGRectZero, keyboardFrame = [keyboardFrameInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    for (UITableViewCell* vCell in _textInputCells) {
        QHNewUserReigstTextInput* textInput = (QHNewUserReigstTextInput*)[vCell.contentView viewWithTag:1234];
        if(textInput.inputTextInput.isFirstResponder) {
            textFieldFrame= [textInput convertRect:textInput.frame toView:App_Delegate.window];
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
            frame.origin.y = 0;
            self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        }];
    }
}

-(void)keyboardWillHide:(NSDictionary *)keyboardFrameInfo {
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
    
    [UIView animateWithDuration:[keyboardFrameInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        [self.view layoutIfNeeded];
    }];
    return ;
}

-(void)configTextInput:(QHNewUserReigstTextInput*)textInput atIndex:(NSInteger)index {
    
    if(index == 0 || index == 1) {
        textInput.inputTextInput.secureTextEntry = YES;
    }
    
    textInput.tag = 1234;
    textInput.delegate = self;
    textInput.theIndex = index;
    textInput.inputTextInput.rightViewMode = UITextFieldViewModeWhileEditing;
    textInput.inputTextInput.attributedPlaceholder = AttributedPlaceHolder([_placeHolders objectAtIndex:index]);
    
    // 删除按钮
    UIImageView *deleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    deleView.userInteractionEnabled = YES;
    deleView.image = IMAGENAMED(@"cancel");
    deleView.contentMode = UIViewContentModeCenter;
    UIGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        textInput.inputTextInput.text = @"";
        [textInput removeColorLayer];
    }];
    [deleView addGestureRecognizer:ges];
    textInput.inputTextInput.rightView = deleView;
    
    if(index == 1 || index == 2 || index == 3) {
        textInput.inputTextInput.secureTextEntry = YES;
    }
    
    if(index == _placeHolders.count - 1) {
        textInput.inputTextInput.rightViewMode = UITextFieldViewModeAlways;
        textInput.inputTextInput.returnKeyType = UIReturnKeyDone;
        QHGetCodeButton* getCodeBtn = [[QHGetCodeButton alloc] init];
        
        WeakSelf
        getCodeBtn.action = ^BOOL{ return [weakSelf getCode:index];};
        textInput.inputTextInput.rightView = getCodeBtn;
    }
    else
        textInput.inputTextInput.returnKeyType = UIReturnKeyNext;
    
    return ;
}

-(BOOL)getCode:(NSInteger)index {
    QHNewUserReigstTextInput* preTextInput = (QHNewUserReigstTextInput*)[((UITableViewCell*)[_textInputCells objectAtIndex:index - 1]).contentView viewWithTag:1234];
    
    if(preTextInput.inputTextInput.text.length == 0) {
        [self showHUDOnlyTitle:QHLocalizedString(@"手机号码不能为空", nil)];
        return NO;
    }
    
    WeakSelf
    [QHLoginModel sendSmsCodeWithCodeJson:[@{@"phoneCode" : internalPhoneCode, @"phoneNumber" : [self contentForTextInputIndex:2], @"type" : @"nick", @"nickname" : [QHPersonalInfo sharedInstance].userInfo.username} mj_JSONString] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf showHUDOnlyTitle:QHLocalizedString(@"验证码已发送", nil)];
    } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
    }];
    return YES;
}

-(void)gotoZoneCode {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setZoneCode:) name:ZONECODE_CHANGE_NOTI object:nil];
    QHGetZoneCodeViewController* viewController = [[QHGetZoneCodeViewController alloc] init];
    [self.navigationController presentViewController:[[QHBaseNavigationController alloc] initWithRootViewController:viewController] animated:YES completion:nil];
}

-(void)setZoneCode:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ZONECODE_CHANGE_NOTI object:nil];
    internalPhoneCode = [notification.userInfo valueForKey:@"zoneCode"];
    [_userZoneNoBtn setTitle:[NSString stringWithFormat:@"+%@", internalPhoneCode] forState:UIControlStateNormal];
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_textInputCells.count > indexPath.row && [_textInputCells objectAtIndex:indexPath.row] != nil)
        return [_textInputCells objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    QHNewUserReigstTextInput* textInput = (QHNewUserReigstTextInput*)[[[NSBundle mainBundle]loadNibNamed:@"QHNewUserReigstTextInput" owner:nil options:nil] objectAtIndex:0];
    
    [cell.contentView addSubview:textInput];
    
    [textInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.top.and.bottom.mas_equalTo(cell.contentView);
    }];
    if(indexPath.row == 2) {
        _userZoneNoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _userZoneNoBtn.titleLabel.font = FONT(15.0f);
        [_userZoneNoBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        NSString *code;
        if ([[NSUserDefaults standardUserDefaults] valueForKey:kZonePhoneCode]) {
            code = [[NSUserDefaults standardUserDefaults] valueForKey:kZonePhoneCode];
        } else {
            code = @"86";
        }
        [_userZoneNoBtn setTitle:[NSString stringWithFormat:@"+%@",code] forState:UIControlStateNormal];
        internalPhoneCode = code;
        [_userZoneNoBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_userZoneNoBtn addTarget:self action:@selector(gotoZoneCode) forControlEvents:UIControlEventTouchUpInside];
        [textInput addSubview:_userZoneNoBtn];
        [_userZoneNoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(textInput);
            make.left.equalTo(textInput).mas_offset(15);
            make.width.mas_equalTo(50.0f);
            make.height.mas_equalTo(textInput.inputTextInput.mas_height);
        }];
        [textInput.inputTextInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(textInput).mas_offset(65);
        }];
    }
    
    [self configTextInput:textInput atIndex:indexPath.row];
    [_textInputCells addObject:cell];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (UITableViewCell* vCell in _textInputCells) {
        QHNewUserReigstTextInput* textInput = [vCell.contentView viewWithTag:1234];
        if(textInput)
            [textInput.inputTextInput resignFirstResponder];
    }
    return ;
}

#pragma mark - QHNewUserRegistTextInputDelegate
-(void)textInput:(QHNewUserReigstTextInput *)textInput returnKeyPressedAtIndex:(NSInteger)index {
    UITableViewCell* nextCell = [_textInputCells objectAtIndex:index + 1];
    if(nextCell) {
        QHNewUserReigstTextInput* nextInput = (QHNewUserReigstTextInput*)[nextCell.contentView viewWithTag:1234];
        if(nextInput)
            [nextInput.inputTextInput becomeFirstResponder];
    }
    return ;
}

-(void)checkDataValid {
    _userRegistConfirmBtn.enabled = [self checkContentIsValid];
}

-(void)textInput:(QHNewUserReigstTextInput *)textInput isValidDataWithTextWhenChanged:(NSString *)text {
    
    QHNewUserReigstTextInput* nextInput = nil;
    if(textInput.theIndex == 0 || textInput.theIndex == 1) {
        if(textInput.theIndex == 0) {
            nextInput = (QHNewUserReigstTextInput*)[((UITableViewCell*)[_textInputCells objectAtIndex:textInput.theIndex + 1]).contentView viewWithTag:1234];
        }else if(textInput.theIndex == 1) {
            nextInput = (QHNewUserReigstTextInput*)[((UITableViewCell*)[_textInputCells objectAtIndex:textInput.theIndex - 1]).contentView viewWithTag:1234];
        }
        
        // 密码格式
        if((textInput.theIndex == 0 || textInput.theIndex == 1) && (textInput.inputTextInput.text.length == 0 || textInput.inputTextInput.text.length < kMinimumPasswordLength || textInput.inputTextInput.text.length > kMaximumPasswordLength || [kPasswordFormatPattern matchesInString:textInput.inputTextInput.text options:0 range:NSMakeRange(0, textInput.inputTextInput.text.length)].count == 0)) {
            [textInput setInvalidModeWithHintText:errorMsg(USER_REGIST_ERROR_PAY_PASSWORD_INVALID)];
            return ;
        }
        
        // 判断两次密码是否相等
        if(nextInput.inputTextInput.text.length != 0 && [textInput.inputTextInput.text isEqualToString:nextInput.inputTextInput.text] == NO) {
            if (nextInput.theIndex == 1) {
                [nextInput setInvalidModeWithHintText:errorMsg(USER_REGIST_ERROR_PASSWORD_DIFFER)];
            }
            if (textInput.theIndex == 1) {
                [textInput setInvalidModeWithHintText:errorMsg(USER_REGIST_ERROR_PASSWORD_DIFFER)];
            }
            return ;
        }
    }else if(textInput.theIndex == 0) {
        if(textInput.inputTextInput.text.length == 0) {
            [textInput setInvalidModeWithHintText:QHLocalizedString(@"手机号码不能为空", nil)];
            return ;
        }
    }else if(textInput.theIndex == 5) {
        if(textInput.inputTextInput.text.length == 0) {
            [textInput setInvalidModeWithHintText:QHLocalizedString(@"手机验证码不能为空", nil)];
            return ;
        }
    }
    [textInput setValidModeWithHintText:@""];
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
