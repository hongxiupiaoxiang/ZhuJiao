//
//  QHRobotSettingViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRobotSettingViewController.h"

@interface QHRobotSettingViewController ()

@end

@implementation QHRobotSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"AI设置", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(0, 130, SCREEN_WIDTH, 10)];
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(15, 70, SCREEN_WIDTH-30, 1)];
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(15, 200, SCREEN_WIDTH-30, 1)];
    
    UIImageView *leftView1 = [[UIImageView alloc] init];
    leftView1.image = IMAGENAMED(@"AI_create");
    [self.view addSubview:leftView1];
    [leftView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(40);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    UIImageView *leftView2 = [[UIImageView alloc] init];
    leftView2.image = IMAGENAMED(@"AI_end");
    [self.view addSubview:leftView2];
    [leftView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(100);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    UILabel *createText = [UILabel defalutLabel];
    createText.text = QHLocalizedString(@"开通时间", nil);
    [self.view addSubview:createText];
    [createText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView1.mas_right).mas_offset(10);
        make.centerY.equalTo(leftView1);
    }];
    
    UILabel *endText = [UILabel defalutLabel];
    endText.text = QHLocalizedString(@"到期时间", nil);
    [self.view addSubview:endText];
    [endText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView2.mas_right).mas_offset(10);
        make.centerY.equalTo(leftView2);
    }];
    
    UILabel *create = [UILabel detailLabel];
    create.text = [NSObject timechange:self.model.startCreateAt withFormat:@"yyyy/MM/dd HH:mm"];
    [self.view addSubview:create];
    [create mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(createText.mas_right).mas_offset(30);
        make.centerY.equalTo(leftView1);
    }];
    
    UILabel *end = [UILabel labelWithFont:15 color:MainColor];
    end.text = [NSObject timechange:self.model.endCreateAt withFormat:@"yyyy/MM/dd HH:mm"];
    [self.view addSubview:end];
    [end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endText.mas_right).mas_offset(30);
        make.centerY.equalTo(leftView2);
    }];
    
    UILabel *autoText = [UILabel defalutLabel];
    autoText.text = QHLocalizedString(@"到期自动续费", nil);
    [self.view addSubview:autoText];
    [autoText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(170);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    UILabel *last = [UILabel defalutLabel];
    last.text = QHLocalizedString(@"上次续费时间", nil);
    [self.view addSubview:last];
    [last mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(230);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    UILabel *lastTime = [UILabel detailLabel];
    if ([self.model.lastTime isEqualToString:@"<null>"] || self.model.lastTime == nil) {
        lastTime.text = QHLocalizedString(@"无", nil);
    } else {
        lastTime.text = [NSObject timechange:self.model.lastTime withFormat:@"yyyy/MM/dd HH:mm"];
    }
    [self.view addSubview:lastTime];
    [lastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(230);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
    
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-61, 0, 48, 24)];
    switchBtn.backgroundColor = UIColorFromRGB(0xc5c6c1);
    switchBtn.tintColor = UIColorFromRGB(0xc5c6c1);
    switchBtn.onTintColor = UIColorFromRGB(0xff4c79);
    switchBtn.thumbTintColor = WhiteColor;
    switchBtn.layer.cornerRadius = 15.5;
    switchBtn.layer.masksToBounds = YES;
    [self.view addSubview:switchBtn];
    [switchBtn addTarget:self action:@selector(changeStates:) forControlEvents:(UIControlEventValueChanged)];
    [switchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).mas_offset(-15);
        make.centerY.equalTo(autoText);
    }];
    
    if ([self.model.isAuth isEqualToString:@"2"]) {
        switchBtn.on = YES;
    }
}

- (void)changeStates: (UISwitch *)sender {
    [QHRobotAIModel updatePepperSetWithAuth:[NSString stringWithFormat:@"%d",(sender.isOn+1)] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [self showHUDOnlyTitle:QHLocalizedString(@"修改设置成功", nil)];
    } failureBlock:nil];
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
