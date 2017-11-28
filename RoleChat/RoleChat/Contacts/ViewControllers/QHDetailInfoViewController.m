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
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(15, 140, SCREEN_WIDTH-30, 1)];
    
    UILabel *addressLabel = [UILabel defalutLabel];
    addressLabel.text = QHLocalizedString(@"地区", nil);
    [self.view addSubview:addressLabel];
    
    UILabel *address = [UILabel labelWithFont:15 color:RGB939EAE];
    [self.view addSubview:address];
    address.text = @"中国";
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView);
        make.left.equalTo(headView.mas_right).mas_offset(15);
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(nameLabel);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(110);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressLabel);
        make.right.equalTo(self.view).mas_offset(-15);
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
