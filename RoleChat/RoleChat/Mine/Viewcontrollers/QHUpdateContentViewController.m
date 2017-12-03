//
//  QHUpdateContentViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHUpdateContentViewController.h"
#import "QHUpdateContentCell.h"
#import "QHUpdateTitleCell.h"

@interface QHUpdateContentViewController ()

@end

@implementation QHUpdateContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"版本更新内容", nil);
    
    self.tableView.backgroundColor = WhiteColor;
    
    self.tableView.estimatedRowHeight = 300;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QHUpdateContentCell class] forCellReuseIdentifier:[QHUpdateContentCell reuseIdentifier]];
    [self.tableView registerClass:[QHUpdateTitleCell class] forCellReuseIdentifier:[QHUpdateTitleCell reuseIdentifier]];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 75 : UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHUpdateTitleCell reuseIdentifier]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHUpdateContentCell reuseIdentifier]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
