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

@implementation QHFriendRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"发送请求", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 160)];
    textView.font = FONT(14);
    textView.text = [NSString stringWithFormat:QHLocalizedString(@"你好,我是%@", nil),[QHPersonalInfo sharedInstance].userInfo.nickname];
    textView.layer.cornerRadius = 3;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = UIColorFromRGB(0xf0f1f5).CGColor;
    [self.view addSubview:textView];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 255, SCREEN_WIDTH-30, 50)];
    sendBtn.backgroundColor = MainColor;
    sendBtn.layer.cornerRadius = 3;
    [sendBtn setTitle:QHLocalizedString(@"发送请求", nil) forState:(UIControlStateNormal)];
    [self.view addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(sendRequest) forControlEvents:(UIControlEventTouchUpInside)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [textView resignFirstResponder];
    }];
    [self.view addGestureRecognizer:tap];
}

- (void)sendRequest {
    NSLog(@"发送请求");
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
