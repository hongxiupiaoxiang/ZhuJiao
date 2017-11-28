//
//  QHSelectZoneViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/28.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSelectZoneViewController.h"

@interface QHSelectZoneViewController ()

@property (nonatomic, strong) UITextField *zoneTF;

@end

@implementation QHSelectZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:QHLocalizedString(@"保存", nil) forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.tableView.backgroundColor = WhiteColor;
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    headView.backgroundColor = WhiteColor;
    [[QHTools toolsDefault] addLineView:headView :CGRectMake(0, 70, SCREEN_WIDTH, 10)];
    [headView addSubview:self.zoneTF];
    
    [self.zoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_top).mas_offset(35);
        make.left.equalTo(headView);
    }];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (void)save {
    
}

- (UITextField *)zoneTF {
    if (_zoneTF == nil) {
        _zoneTF = [[UITextField alloc] init];
        _zoneTF.placeholder = QHLocalizedString(@"搜索国家或地区", nil);
        _zoneTF.font = FONT(17);
    }
    return _zoneTF;
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
