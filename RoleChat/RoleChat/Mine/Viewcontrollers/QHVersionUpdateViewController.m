//
//  QHVersionUpdateViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHVersionUpdateViewController.h"
#import "QHBaseSubCell.h"
#import "QHUpdateContentViewController.h"

@interface QHVersionUpdateViewController ()

@end

@implementation QHVersionUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"版本更新内容", nil);
    
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QHBaseSubCell class] forCellReuseIdentifier:[QHBaseSubCell reuseIdentifier]];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseSubCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseSubCell reuseIdentifier]];
    cell.titleLabel.text = @"1.0.0 版本更新";
    cell.contentLabel.text = @"发布时间: 2017/12/12 12:12";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QHUpdateContentViewController *updateVC = [[QHUpdateContentViewController alloc] init];
    [self.navigationController pushViewController:updateVC animated:YES];
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
