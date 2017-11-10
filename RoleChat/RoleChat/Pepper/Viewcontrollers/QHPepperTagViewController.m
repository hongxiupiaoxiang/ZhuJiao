//
//  QHPepperTagViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPepperTagViewController.h"

@interface QHPepperTagViewController ()

@end

@implementation QHPepperTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"标签", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    UILabel *titleLabel = [UILabel labelWithFont:17 color:RGB52627C];
    titleLabel.text = QHLocalizedString(@"目前可用标签", nil);
    [self.view addSubview:titleLabel];
    
    UILabel *descriptionLabel = [UILabel labelWithFont:12 color:RGB939EAE];
    descriptionLabel.text = QHLocalizedString(@"点击\"更多\"可购买其他标签", nil);
    [self.view addSubview:descriptionLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(25);
        make.centerX.equalTo(self.view);
    }];
    
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(4);
        make.centerX.equalTo(self.view);
    }];
    
    NSArray *titleArr = @[QHLocalizedString(@"买卖", nil), QHLocalizedString(@"推销", nil), QHLocalizedString(@"聊天", nil), QHLocalizedString(@"嘲讽", nil), QHLocalizedString(@"咒骂", nil), QHLocalizedString(@"更多", nil)];
    
    NSArray *colorArr = @[UIColorFromRGB(0x46a0ee), UIColorFromRGB(0x59d7d2), UIColorFromRGB(0xff6189), UIColorFromRGB(0x44d989), UIColorFromRGB(0xafbacb), UIColorFromRGB(0xafbacb)];
    
    for (NSInteger i = 0; i < 6; i++) {
        CGFloat itemWidth = (SCREEN_WIDTH-60)/3.0;
        CGFloat itemHeight = 40;
        
        CGFloat topMargin = 100;
        
        
        CGRect frame = CGRectMake(15+(itemWidth+15)*(i%3), topMargin+55*(i/3), itemWidth, itemHeight);
        
        UIButton *signBtn = [[UIButton alloc] initWithFrame:frame];
        signBtn.layer.cornerRadius = 20;
        [signBtn setTitle:titleArr[i] forState:(UIControlStateNormal)];
        signBtn.backgroundColor = colorArr[i];
        [self.view addSubview:signBtn];
        
        if (i == 5) {
            [signBtn addTarget:self action:@selector(moreClick) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    
}

- (void)moreClick {
    NSLog(@"点击更多");
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
