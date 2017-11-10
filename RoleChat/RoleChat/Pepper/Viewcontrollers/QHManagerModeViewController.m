//
//  QHManagerModeViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/10.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHManagerModeViewController.h"
#import "QHSwitchBtnCell.h"
#import "QHModeSelectedView.h"

@interface QHManagerModeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHManagerModeViewController {
    UITableView *_mainView;
    NSArray *_tittlArr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:QHLocalizedString(@"保存", nil) forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    rightBtn.titleLabel.font = FONT(14);
    [rightBtn addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    
    _tittlArr = @[QHLocalizedString(@"自荐模式", nil), QHLocalizedString(@"普通模式", nil)];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)save {
    NSLog(@"save");
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    _mainView.estimatedRowHeight = 260;
    [self.view addSubview:_mainView];
    [_mainView registerClass:[QHSwitchBtnCell class] forCellReuseIdentifier:[QHSwitchBtnCell reuseIdentifier]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 60 : 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QHSwitchBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHSwitchBtnCell reuseIdentifier]];
        cell.titleLabel.text = QHLocalizedString(@"启用托管", nil);
        return cell;
    } else {
        NSString *reuseId = [NSString stringWithFormat:@"QHModeSelectedView%zd",indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseId];
            [cell.contentView removeAllSubviews];
            
            QHModeSelectedView *modeView = [[QHModeSelectedView alloc] initWithTitle:_tittlArr[indexPath.row-1] contentTitles:@[QHLocalizedString(@"自动模式", nil), QHLocalizedString(@"半自动模式", nil), QHLocalizedString(@"伪装模式", nil)] detailTitles:@[QHLocalizedString(@"由AI进行全自动处理", nil), QHLocalizedString(@"您可以审核AI发送的内容是否合理", nil), QHLocalizedString(@"用户自行回复", nil)] keyword:QHLocalizedString(@"AI", nil) selectedCallback:^(id params) {
                
            } selectedIndex:0];
            modeView.userInteractionEnabled = YES;
            [cell.contentView addSubview:modeView];
            [modeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(cell.contentView).mas_offset(15);
                make.right.equalTo(cell.contentView).mas_offset(-15);
                make.bottom.equalTo(cell.contentView);
            }];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
