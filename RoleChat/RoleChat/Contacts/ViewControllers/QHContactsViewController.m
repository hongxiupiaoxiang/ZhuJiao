//
//  QHContactsViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/25.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHContactsViewController.h"
#import "QHContactCell.h"
#import "BMChineseSort.h"

@interface QHContactsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHContactsViewController {
    UITableView *_mainView;
    
}

//_friendList = [BMChineseSort sortObjectArray:_frientTempArrM Key:@"remark" secondKey:@"nickName"];;
//_alphaList = [BMChineseSort IndexWithArray:_frientTempArrM Key:@"remark" secondKey:@"nickName"];

- (void)viewDidLoad {
    [super viewDidLoad];

    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _mainView.backgroundColor = WhiteColor;
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [_mainView registerClass:[QHContactCell class] forCellReuseIdentifier:[QHContactCell reuseIdentifier]];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 2 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHContactCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHContactCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.headView.image = IMAGENAMED(@"Chat_invite");
            cell.nameLabel.text = QHLocalizedString(@"新的邀请", nil);
        } else {
            cell.headView.image = IMAGENAMED(@"Chat_group");
            cell.nameLabel.text = QHLocalizedString(@"群聊", nil);
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1f : 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView;
    if (section == 0) {
        bgView = [UIView new];
    } else {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        bgView.backgroundColor = RGBF5F6FA;
        
        UILabel *alpha = [UILabel labelWithFont:15 color:UIColorFromRGB(0xc5c6d1)];
        alpha.text = @"A";
        [bgView addSubview:alpha];
        [alpha mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(15);
        }];
    }
    return bgView;
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
