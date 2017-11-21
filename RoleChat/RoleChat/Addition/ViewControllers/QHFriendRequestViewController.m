//
//  QHFriendRequestViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHFriendRequestViewController.h"

@interface QHFriendRequestViewController ()

@end

@implementation QHFriendRequestViewController {
    UITextView *_contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"发送请求", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 160)];
    _contentView.font = FONT(14);
    _contentView.text = [NSString stringWithFormat:QHLocalizedString(@"你好,我是%@", nil),[QHPersonalInfo sharedInstance].userInfo.nickname];
    _contentView.layer.cornerRadius = 3;
    _contentView.layer.borderWidth = 1;
    _contentView.layer.borderColor = UIColorFromRGB(0xf0f1f5).CGColor;
    [self.view addSubview:_contentView];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 255, SCREEN_WIDTH-30, 50)];
    sendBtn.backgroundColor = MainColor;
    sendBtn.layer.cornerRadius = 3;
    [sendBtn setTitle:QHLocalizedString(@"发送请求", nil) forState:(UIControlStateNormal)];
    [self.view addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(sendRequest) forControlEvents:(UIControlEventTouchUpInside)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [_contentView resignFirstResponder];
    }];
    [self.view addGestureRecognizer:tap];
}

- (void)sendRequest {
    WeakSelf
    [[QHSocketManager manager] requestAddFriendWithRefId:self.model.openid nickname:self.model.nickname message:_contentView.text completion:^(id response) {
        [weakSelf showHUDOnlyTitle:QHLocalizedString(@"发送成功", nil)];
        PerformOnMainThreadDelay(1.5, [weakSelf.navigationController popViewControllerAnimated:YES];);
    } failure:^(id response) {
        [weakSelf showHUDOnlyTitle:QHLocalizedString(@"服务器响应失败", nil)];
    }];
}

- (void)dealloc {
    NSLog(@"\n\n\n\n\n");
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
