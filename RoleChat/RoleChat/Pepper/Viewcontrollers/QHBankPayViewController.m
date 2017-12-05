//
//  QHBankPayViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/5.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBankPayViewController.h"

@interface QHBankPayViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation QHBankPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"支付订单", nil);
    
//    self.fd_prefersNavigationBarHidden = YES;
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
     UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:webView];
    self.webView = webView;
    webView.delegate = self;
    
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    
    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    
    [self.webView loadHTMLString:self.webString baseURL:baseURL];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *url = [_webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    DLog(@"%@", url);
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
