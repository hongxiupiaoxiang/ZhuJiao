//
//  QHSaleRecordViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/18.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSaleRecordViewController.h"
#import "QHSaleBonusCell.h"
#import "QHSaleDetailViewController.h"

@interface QHSaleRecordViewController ()

@end

@implementation QHSaleRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"销售成分", nil);
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:IMAGENAMED(@"search") forState:(UIControlStateNormal)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QHSaleBonusCell class] forCellReuseIdentifier:[QHSaleBonusCell reuseIdentifier]];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    bgView.backgroundColor = RGBF5F6FA;
    return bgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QHSaleDetailViewController *detaileVC = [[QHSaleDetailViewController alloc] init];
    [self.navigationController pushViewController:detaileVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHSaleBonusCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHSaleBonusCell reuseIdentifier]];
    return cell;
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
