//
//  QHAboutUsViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHAboutUsViewController.h"

@interface QHAboutUsViewController ()

@end

@implementation QHAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"关于我们", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAMED(@"Check_pepper")];
    [self.view addSubview:imgView];
    
    CGRect frame = imgView.frame;
    frame.origin.y = 50;
    imgView.frame = frame;
    imgView.centerX = SCREEN_WIDTH*0.5;
    
    UILabel *nameLabel = [UILabel labelWithFont:17 color:RGB52627C];
    [self.view addSubview:nameLabel];
    nameLabel.text = QHLocalizedString(@"小辣椒Pepper", nil);
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imgView.mas_bottom).mas_offset(20);
    }];
    
    UILabel *descriptionLabel = [UILabel labelWithFont:14 color:RGB939EAE];
    [self.view addSubview:descriptionLabel];
    descriptionLabel.numberOfLines = 0;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7;
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:QHLocalizedString(@"小辣椒只能聊天机器人由主角只能实验室开发，能自主完成自由交谈、智能营销、知识问答、艺术表演等行为。依托自然语言处理基础，小辣椒具备强大的识别能力，并能准确的做出正确的应答。还能从聊天信息中自主学习，提高自我推销能力。\n\r小辣椒机器人不仅能帮助你赚钱，还能让你成为世界上最优秀的主人。", nil) attributes:@{NSParagraphStyleAttributeName : paragraphStyle}];
    descriptionLabel.attributedText = attr;
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).mas_offset(50);
        make.left.equalTo(self.view).mas_offset(25);
        make.right.equalTo(self.view).mas_offset(-25);
    }];
    
    UILabel *copyrightLabel = [UILabel detailLabel];
    copyrightLabel.text = @"Copyright 2017 - 2022";
    [self.view addSubview:copyrightLabel];
    
    UILabel *bottomLabel = [UILabel detailLabel];
    bottomLabel.text = @"网络科技有限公司";
    [self.view addSubview:bottomLabel];
    
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-50);
    }];
    
    [copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(bottomLabel.mas_top).mas_offset(-6);
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
