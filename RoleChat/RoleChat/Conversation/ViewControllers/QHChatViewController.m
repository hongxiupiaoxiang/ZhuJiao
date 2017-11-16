//
//  QHChatViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatViewController.h"
#import "QHChatKeyboard.h"

@interface QHChatViewController ()

@end

@implementation QHChatViewController {
    QHChatKeyboard *_keyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
    _keyboard = [[QHChatKeyboard alloc] initWithKeyboardInView:self.view delegate:self];
    [_keyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleKeyboard:(NSNotification *)aNotification {
    
    CGRect keyboardFrame = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [_keyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-([UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y));
                                                  }];
    
    /** 增加监听键盘大小变化通知,并且让tableView 滚动到最底部 */
    [self.view layoutIfNeeded];
    //    [self scrollBottom:NO];
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
