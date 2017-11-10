//
//  QHOpenAIViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/7.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHOpenAIViewController.h"

@interface QHOpenAIViewController ()<UITextFieldDelegate>

@end

@implementation QHOpenAIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"开通AI", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    UILabel *priceTitleLabel = [UILabel labelWithColor:UIColorFromRGB(0x52627c)];
    [self.view addSubview:priceTitleLabel];
    priceTitleLabel.text = QHLocalizedString(@"开通价格", nil);
    
    UILabel *priceLabel = [UILabel labelWithFont:28 color:UIColorFromRGB(0x52627c)];
    [self.view addSubview:priceLabel];
    NSString *priceStr = [NSString stringWithFormat:@"$ %.2f",2000.0];
    NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [atrStr addAttribute:NSForegroundColorAttributeName value:MainColor range:[priceStr rangeOfString:@"$"]];
    priceLabel.attributedText = atrStr;
    
    UILabel *descriptionLabel = [UILabel detailLabel];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = QHLocalizedString(@"开通后您可以获得小辣椒AI功能,您可以使用小辣椒对您的社交账户进行托管,另有更多功能您可以在开通小来叫AI后到商店中了解", nil);
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:descriptionLabel];
    
    UIView *topLine = [[QHTools toolsDefault] addLineView:self.view :CGRectZero];
    UIView *bottomLine = [[QHTools toolsDefault] addLineView:self.view :CGRectZero];
    
    UILabel *nameLabel = [UILabel labelWithColor:UIColorFromRGB(0x52627c)];
    [self.view addSubview:nameLabel];
    nameLabel.text = QHLocalizedString(@"推荐人用户名", nil);
    
    UITextField *nameTF = [[UITextField alloc] init];
    nameTF.font = FONT(15);
    nameTF.placeholder = QHLocalizedString(@"请输入推荐人用户名", nil);
    [self.view addSubview:nameTF];
    nameTF.delegate = self;
    nameTF.returnKeyType = UIReturnKeyDone;
    
    UIButton *openServiceBtn = [[UIButton alloc] init];
    [openServiceBtn setTitle:QHLocalizedString(@"立即开通", nil) forState:(UIControlStateNormal)];
    openServiceBtn.layer.cornerRadius = 3.0f;
    openServiceBtn.titleLabel.font = FONT(16);
    openServiceBtn.backgroundColor = MainColor;
    [self.view addSubview:openServiceBtn];
    
    [priceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceTitleLabel.mas_bottom).mas_offset(15);
        make.centerX.equalTo(self.view);
    }];
    
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel.mas_bottom).mas_offset(39);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.centerX.equalTo(self.view);
    }];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(1);
        make.top.equalTo(descriptionLabel.mas_bottom).mas_offset(50);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topLine.mas_bottom).mas_offset(35);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(1);
        make.top.equalTo(topLine.mas_bottom).mas_offset(70);
    }];
    
    [openServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).mas_offset(90);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - UITextField
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
