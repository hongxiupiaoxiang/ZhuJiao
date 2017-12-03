//
//  QHCheckUpdateViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHCheckUpdateViewController.h"
#import "QHBaseLabelCell.h"
#import "QHBaseContentCell.h"
#import "QHVersionUpdateViewController.h"

@interface QHCheckUpdateViewController ()

@end

@implementation QHCheckUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"检查更新", nil);
    
    self.tableView.backgroundColor = WhiteColor;
    [self.tableView registerClass:[QHBaseContentCell class] forCellReuseIdentifier:[QHBaseContentCell reuseIdentifier]];
    [self.tableView registerClass:[QHBaseLabelCell class] forCellReuseIdentifier:[QHBaseLabelCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 240;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 90, 90)];
    imgView.centerX = SCREEN_WIDTH*0.5;
    imgView.image = IMAGENAMED(@"Check_pepper");
    [headerView addSubview:imgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 158, 200, 20)];
    nameLabel.font = FONT(17);
    nameLabel.centerX = SCREEN_WIDTH*0.5;
    nameLabel.textColor = RGB52627C;
    [headerView addSubview:nameLabel];
    nameLabel.text = QHLocalizedString(@"小辣椒Pepper", nil);
    
    [[QHTools toolsDefault] addLineView:headerView :CGRectMake(15, 239, SCREEN_WIDTH-30, 1)];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseContentCell reuseIdentifier]];
        ((QHBaseContentCell *)cell).aliment = ContentAliment_Right;
        ((QHBaseContentCell *)cell).titleLabel.text = QHLocalizedString(@"当前版本号", nil);
        ((QHBaseContentCell *)cell).contentLabel.text = [Util getApplicationVersion];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"版本更新内容", nil);
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        ((QHBaseLabelCell *)cell).titleLabel.text = QHLocalizedString(@"检查新版本", nil);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        QHVersionUpdateViewController *versionUpdateVC = [[QHVersionUpdateViewController alloc] init];
        [self.navigationController pushViewController:versionUpdateVC animated:YES];
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
