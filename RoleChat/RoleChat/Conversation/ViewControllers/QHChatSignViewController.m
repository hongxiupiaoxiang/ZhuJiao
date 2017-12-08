//
//  QHChatSignViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatSignViewController.h"
#import "QHSignView.h"

#define SIGNBTN_TAG 666

@interface QHChatSignViewController()

@property (nonatomic, strong) NSMutableArray *signContent;
@property (nonatomic, strong) UILabel *signCountLabel;

@end


@implementation QHChatSignViewController {
    NSArray *_titles;
    NSArray *_titleColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"添加标签", nil);
    
    self.signContent = [[NSMutableArray alloc] init];
    
    _titles = @[QHLocalizedString(@"买卖", nil), QHLocalizedString(@"推销", nil), QHLocalizedString(@"聊天", nil), QHLocalizedString(@"嘲讽", nil), QHLocalizedString(@"咒骂", nil), QHLocalizedString(@"更多", nil)];
    
    _titleColor = @[UIColorFromRGB(0x46a0ee), UIColorFromRGB(0x59d7d2), UIColorFromRGB(0xff6189), UIColorFromRGB(0x44d989), UIColorFromRGB(0xafbacb), UIColorFromRGB(0xafbacb)];
    
    
    WeakSelf
    [self addRightTitleItem:QHLocalizedString(@"清除已选", nil) color:MainColor sendBlock:^(id prama) {
        [weakSelf btnClick];
    }];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)btnClick {
    for (NSInteger i = 0; i < 5; i++) {
        QHSignView *signView = [self.view viewWithTag:SIGNBTN_TAG+i];
        signView.isSelect = NO;
    }
    [self.signContent removeAllObjects];
    [self setCount];
}

- (void)setupUI {
    UILabel *descriptionLabel = [UILabel detailLabel];
    descriptionLabel.text = QHLocalizedString(@"请选择想要添加的标签", nil);
    [self.view addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(40);
    }];
    
    WeakSelf
    for (NSInteger i = 0; i < 6; i++) {
        QHSignView *signView = [[QHSignView alloc] initWithFrame:CGRectMake(15+(i%3)*((SCREEN_WIDTH-15)/3.0), 100+(i/3)*(60), (SCREEN_WIDTH-60)/3.0, 40)];
        signView.tag = i+SIGNBTN_TAG;
        signView.color = _titleColor[i];
        signView.title = _titles[i];
        if (i == 5) {
            signView.hideCheck = YES;
        } else {
            signView.paramsCallback = ^(id params) {
                if ([weakSelf.signContent containsObject:params]) {
                    [weakSelf.signContent removeObject:params];
                } else {
                    [weakSelf.signContent addObject:params];
                }
                [weakSelf setCount];
            };
        }
        [self.view addSubview:signView];
    }
    
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(0, self.view.height-114, SCREEN_WIDTH, 1)];
    
    self.signCountLabel = [UILabel labelWithFont:16 color:UIColorFromRGB(0xff4c79)];
    [self setCount];
    [self.view addSubview:_signCountLabel];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, self.view.height-114, 100, 50)];
    [sureBtn setTitle:QHLocalizedString(@"确定", nill) forState:(UIControlStateNormal)];
    sureBtn.backgroundColor = MainColor;
    [self.view addSubview:sureBtn];
    
    [self.signCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sureBtn);
        make.left.equalTo(self.view).mas_offset(15);
    }];
}

- (void)setCount {
    NSString *text = [NSString stringWithFormat:QHLocalizedString(@"已选标签数量: %d", nil),self.signContent.count];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    [attr addAttribute:NSForegroundColorAttributeName value:RGB52627C range:[text rangeOfString:QHLocalizedString(@"已选标签数量:", nil)]];
    self.signCountLabel.attributedText = attr;
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
