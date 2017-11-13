//
//  QHPepperViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/25.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPepperViewController.h"
#import "QHBaseViewCell.h"
#import "QHOpenAIViewController.h"
#import "QHPepperRobotViewController.h"
#import "QHPayOrderViewController.h"
#import "QHPepperTagViewController.h"
#import "QHSocialAccountViewController.h"
#import "QHChatAutoViewController.h"
#import "QHPepperShopViewController.h"

@interface QHPepperViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHPepperViewController {
    UITableView *_mainView;
    NSArray *_titleArr;
    NSArray *_picArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

#pragma mark - setUI
- (void)setupUI {
    [super setupUI];
    
    // 普通用户
//    [self setupUIForSimple];
    
    // 会员用户
    [self setupUIForVip];
}

- (void)setupUIForVip {
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [self.view addSubview:_mainView];
    [_mainView registerClass:[QHBaseViewCell class] forCellReuseIdentifier:[QHBaseViewCell reuseIdentifier]];
    _mainView.backgroundColor = WhiteColor;
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _titleArr = @[@[QHLocalizedString(@"Pepper", nil)], @[QHLocalizedString(@"Pepper商店", nil), QHLocalizedString(@"消费订单", nil), QHLocalizedString(@"可用标签", nil)], @[QHLocalizedString(@"聊天托管", nil), QHLocalizedString(@"社交账户", nil)]];
    
    _picArr = @[@[@"Pepper_spepper"], @[@"Pepper_shop", @"Pepper_order", @"Pepper_sign"], @[@"Pepper_auto", @"Pepper_chat"]];
}

- (void)setupUIForSimple {
    UIImageView *pepperView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 110, 110)];
    pepperView.image = IMAGENAMED(@"Pepper_pepper");
    pepperView.centerX = SCREEN_WIDTH * 0.5;
    [self.view addSubview:pepperView];
    
    UILabel *titleLabel = [UILabel labelWithFont:21 color:UIColorFromRGB(0x52627c)];
    titleLabel.text = QHLocalizedString(@"Pepper", nil);
    [self.view addSubview:titleLabel];
    
    UILabel *descriptionLabel = [UILabel detailLabel];
    descriptionLabel.numberOfLines = 0;
    [self.view addSubview:descriptionLabel];
    descriptionLabel.text = QHLocalizedString(@"您尚未开通小辣椒AI功能,立即开通即可使用人工智能服务!", nil);
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *openServiceBtn = [[UIButton alloc] init];
    [openServiceBtn setTitle:QHLocalizedString(@"立即开通", nil) forState:(UIControlStateNormal)];
    openServiceBtn.layer.cornerRadius = 3.0f;
    openServiceBtn.titleLabel.font = FONT(16);
    openServiceBtn.backgroundColor = MainColor;
    [self.view addSubview:openServiceBtn];
    [openServiceBtn addTarget:self action:@selector(openService) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *intelligenceBtn = [[UIButton alloc] init];
    [intelligenceBtn setTitle:QHLocalizedString(@"体验人工智能", nil) forState:(UIControlStateNormal)];
    [intelligenceBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    intelligenceBtn.titleLabel.font = FONT(16);
    intelligenceBtn.layer.cornerRadius = 3.0f;
    intelligenceBtn.layer.borderWidth = 1.0f;
    intelligenceBtn.layer.borderColor = UIColorFromRGB(0xffdce5).CGColor;
    [self.view addSubview:intelligenceBtn];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pepperView.mas_bottom).mas_offset(30);
        make.centerX.equalTo(self.view);
    }];
    
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(30);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.centerX.equalTo(self.view);
    }];
    
    [openServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descriptionLabel.mas_bottom).mas_offset(50);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(60);
    }];
    
    [intelligenceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(openServiceBtn.mas_bottom).mas_offset(20);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(60);
    }];
}

- (void)openService {
    QHOpenAIViewController *aiVC = [[QHOpenAIViewController alloc] init];
    [self.navigationController pushViewController:aiVC animated:YES];
}

#pragma mark UITabelViewDelegate && UITabelViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 80 : 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1f : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [UIView new];
    } else {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        sectionView.backgroundColor = UIColorFromRGB(0xf5f6fe);
        return sectionView;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseViewCell reuseIdentifier]];
    cell.leftView.image = IMAGENAMED(_picArr[indexPath.section][indexPath.row]);
    cell.titleLabel.text = _titleArr[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QHBaseViewController *targetVC;
    if (indexPath.section == 0) {
        targetVC = [[QHPepperRobotViewController alloc] init];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            targetVC = [[QHPayOrderViewController alloc] init];
        } else if (indexPath.row == 2) {
            targetVC = [[QHPepperTagViewController alloc] init];
        } else if (indexPath.row == 0) {
            targetVC = [[QHPepperShopViewController alloc] init];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            targetVC = [[QHSocialAccountViewController alloc] init];
        } else {
            targetVC = [[QHChatAutoViewController alloc] init];
        }
    }
    if (targetVC) {
        targetVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:targetVC animated:YES];
    }
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
