//
//  QHDetailInfoViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/24.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDetailInfoViewController.h"

@interface QHDetailInfoViewController ()

@end

@implementation QHDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    self.title = QHLocalizedString(@"详细资料", nil);
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:headView cornerRedii:3];
    [headView loadImageWithUrl:self.model.imgurl placeholder:ICON_IMAGE];
    [self.view addSubview:headView];
    
    UILabel *nameLabel = [UILabel defalutLabel];
    nameLabel.text = self.model.fromNickname;
    [self.view addSubview:nameLabel];
    
    UILabel *detailLabel = [UILabel detailLabel];
    [self.view addSubview:detailLabel];
    detailLabel.text = [NSString stringWithFormat:@"+%@ %@", self.model.phoneCode, [NSString getPhoneHiddenStringWithPhone:self.model.phone]];
    
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(0, 70, SCREEN_WIDTH, 10)];
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(0, 190, SCREEN_WIDTH, 10)];
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(15, 260, SCREEN_WIDTH-30, 1)];
    
    UILabel *addressLabel = [UILabel defalutLabel];
    addressLabel.text = QHLocalizedString(@"地区", nil);
    [self.view addSubview:addressLabel];
    
    UILabel *address = [UILabel labelWithFont:15 color:RGB939EAE];
    [self.view addSubview:address];
    address.text = @"中国";
    
    UILabel *inviteLabel = [UILabel detailLabel];
    inviteLabel.text = self.model.message;
    [self.view addSubview:inviteLabel];
    inviteLabel.numberOfLines = 0;
    
    UIButton *refuseBtn = [[UIButton alloc] init];
    [refuseBtn setTitle:QHLocalizedString(@"拒绝", nil) forState:(UIControlStateNormal)];
    refuseBtn.backgroundColor = UIColorFromRGB(0xc5c6d1);
    refuseBtn.layer.cornerRadius = 3;
    [self.view addSubview:refuseBtn];
    refuseBtn.tag = 666;
    [refuseBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    refuseBtn.titleLabel.font = FONT(15);
    
    UIButton *acceptBtn = [[UIButton alloc] init];
    [acceptBtn setTitle:QHLocalizedString(@"同意", nil) forState:(UIControlStateNormal)];
    acceptBtn.backgroundColor = MainColor;
    acceptBtn.layer.cornerRadius = 3;
    [self.view addSubview:acceptBtn];
    acceptBtn.tag = 667;
    [acceptBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    acceptBtn.titleLabel.font = FONT(15);
    
    CGFloat width = (SCREEN_WIDTH-45)*0.5;
    [refuseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(15);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view).mas_offset(-30);
        make.width.mas_equalTo(width);
    }];
    [acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view).mas_offset(-30);
        make.width.mas_equalTo(width);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView);
        make.left.equalTo(headView.mas_right).mas_offset(15);
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(nameLabel);
    }];
    
    [inviteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(90);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(230);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressLabel);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
}

- (void)btnClick: (UIButton *)sender {
    NSString *flag = sender.tag == 666 ? @"1" : @"0";
    [[QHSocketManager manager] acceptFriendRequestWithMessageId:self.model.messageId fromNickname:self.model.fromNickname flag:flag formId:self.model.fromId to:self.model.to completion:^(id response) {
        [self showHUDOnlyTitle:QHLocalizedString(@"操作成功", nil)];
        PerformOnMainThreadDelay(1.5, [self.navigationController popViewControllerAnimated:YES];);
        RLMResults *result = [QHRealmFriendMessageModel objectsInRealm:[QHRealmDatabaseManager currentRealm] where:@"messageId = %@",self.model.messageId];
        QHRealmFriendMessageModel *updateModel = result[0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[QHRealmDatabaseManager currentRealm] transactionWithBlock:^{
                updateModel.read = YES;
                updateModel.dealStatus = @"1";
            }];
        });
        if (self.baseVCBlock) {
            self.baseVCBlock(flag);
        }
    } failure:^(id response) {
        [self showHUDOnlyTitle:QHLocalizedString(@"请求服务器失败", nil)];
    }];
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
