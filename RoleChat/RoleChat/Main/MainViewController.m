//
//  MainViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "MainViewController.h"
#import "QHSocketManager.h"
#import "QHLoginView.h"
#import "NSString+Extensions.h"

@interface MainViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) QHLoginView* loginView;
@property(nonatomic, strong) CABasicAnimation *earthAnimation;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initLoginView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)initLoginView {
    if(_loginView != nil) {
        [_loginView removeFromSuperview];
        _loginView = nil;
    }
    
    _loginView = [[QHLoginView alloc] init];
    [self.view addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.leading.and.trailing.mas_equalTo(self.view);
    }];
    [_loginView.confirmBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

-(void)login {
    NSString *usernameType = [self.loginView.userNameTextField.text containsString:@"@"] ? @"email" : @"usrname";
    NSDictionary *dict = @{@"user": @{usernameType: self.loginView.userNameTextField.text},
                           @"password": @{@"digest": [self.loginView.userPassTextField.text sha256],
                                          @"algorithm": @"sha-256"
                                          }
                           };
    NSDictionary *params = @{@"msg": @"method",
                             @"method": @"login",
                             @"params": @[dict]
                             };
}

- (CABasicAnimation *)earthAnimation {
    if (_earthAnimation == nil) {
        _earthAnimation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _earthAnimation.fromValue = [NSNumber numberWithFloat:0.f];
        _earthAnimation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        _earthAnimation.duration  = 60;
        _earthAnimation.autoreverses = NO;
        _earthAnimation.fillMode =kCAFillModeForwards;
        _earthAnimation.repeatCount = MAXFLOAT;
    }
    return _earthAnimation;
}

#pragma mark - Keyboard Notification
-(void)keyboardWillShow:(NSDictionary *)keyboardFrameInfo {
    
    for (UIView* subView in _loginView.subviews) {
        if([subView isFirstResponder] == YES) {
            CGRect viewFrame = subView.frame;
            CGRect keyboardFrame = [keyboardFrameInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            
            if(viewFrame.origin.y + viewFrame.size.height + 10 > keyboardFrame.origin.y) {
                
                CGFloat distance = keyboardFrame.origin.y - viewFrame.size.height - viewFrame.origin.y - 10;
                
                [_loginView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.view).mas_offset(distance);
                }];
                
                [UIView animateWithDuration:[keyboardFrameInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
        }
    }
    return ;
}

-(void)keyboardWillHide:(NSDictionary *)keyboardFrameInfo {
    [_loginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.leading.and.trailing.mas_equalTo(self.view);
    }];
    [UIView animateWithDuration:[keyboardFrameInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
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
