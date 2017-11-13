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

#define ERROR_INDEX 7

@interface QHManagerModeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat autoModelHeight;
@property (nonatomic, assign) CGFloat simpleModelHeight;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger lastIndex;
@property (nonatomic, weak) UISwitch *switchBtn;

@end

@implementation QHManagerModeViewController {
    UITableView *_mainView;
    NSArray *_tittlArr;
    NSMutableArray<QHModeSelectedView *> *_arrM;
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
    
    self.title = QHLocalizedString(@"选择托管模式", nil);
    
    _tittlArr = @[QHLocalizedString(@"自荐模式", nil), QHLocalizedString(@"普通模式", nil)];
    _arrM = [[NSMutableArray alloc] init];
    self.selectedIndex = ERROR_INDEX;
    self.lastIndex = ERROR_INDEX;
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)save {
    NSLog(@"%zd",self.selectedIndex);
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height-64) style:(UITableViewStyleGrouped)];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    _mainView.backgroundColor = RGBF5F6FA;
    [self.view addSubview:_mainView];
    [_mainView registerClass:[QHSwitchBtnCell class] forCellReuseIdentifier:[QHSwitchBtnCell reuseIdentifier]];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _autoModelHeight = 75;
    _simpleModelHeight = 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 60;
    } else if (indexPath.row == 1) {
        return _autoModelHeight;
    } else {
        return _simpleModelHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf
    __weak typeof(_mainView)weakTableView = _mainView;
    
    if (indexPath.row == 0) {
        QHSwitchBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHSwitchBtnCell reuseIdentifier]];
        self.switchBtn = cell.switchBtn;
        cell.titleLabel.text = QHLocalizedString(@"启用托管", nil);
        cell.callback = ^(id params) {
            if ([params integerValue] == 1) {
                [weakSelf show];
                [weakTableView reloadData];
            } else {
                [weakSelf folder];
                [weakTableView reloadData];
            }
        };
        return cell;
    } else {
        NSString *reuseId = [NSString stringWithFormat:@"QHModeSelectedView%zd",indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseId];
            [cell.contentView removeAllSubviews];
            cell.contentView.backgroundColor = RGBF5F6FA;
            
            QHModeSelectedView *modeView = [[QHModeSelectedView alloc] initWithTitle:_tittlArr[indexPath.row-1] contentTitles:@[QHLocalizedString(@"自动模式", nil), QHLocalizedString(@"半自动模式", nil), QHLocalizedString(@"伪装模式", nil)] detailTitles:@[QHLocalizedString(@"由AI进行全自动处理", nil), QHLocalizedString(@"您可以审核AI发送的内容是否合理", nil), QHLocalizedString(@"用户自行回复", nil)] keyword:QHLocalizedString(@"AI", nil) selectedCallback:^(id params) {
                if ([params integerValue] == 0) {
                    weakSelf.switchBtn.on = NO;
                    weakSelf.selectedIndex = ERROR_INDEX;
                } else {
                    weakSelf.switchBtn.on = YES;
                    weakSelf.selectedIndex = (indexPath.row-1)*3+[params integerValue];
                }
            } selectedIndex:0];
            [_arrM addObject:modeView];
            modeView.folderBlock = ^{
                if (indexPath.row == 1) {
                    weakSelf.autoModelHeight = weakSelf.autoModelHeight == 75 ? 285 : 75;
                } else {
                    weakSelf.simpleModelHeight = weakSelf.simpleModelHeight == 75 ? 285 : 75;
                }
                [weakTableView reloadData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                });
            };
            
            modeView.frame= CGRectMake(15, 15, SCREEN_WIDTH-30, 60);
            
            modeView.userInteractionEnabled = YES;
            modeView.layer.masksToBounds = YES;
            modeView.layer.cornerRadius = 3;
            modeView.layer.shadowOffset = CGSizeMake(0, 10);
            modeView.layer.shadowColor = UIColorFromRGB(0x3d5276).CGColor;
            modeView.layer.shadowRadius = 10;
            modeView.layer.shadowOpacity = 0.05;
            
            [cell.contentView addSubview:modeView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (self.selectedIndex > 0 && self.selectedIndex < ERROR_INDEX && self.lastIndex > 0 && self.lastIndex < ERROR_INDEX) {
        if (((self.selectedIndex/4)^(self.lastIndex/4))==1) {
            _arrM[self.lastIndex/4].selectedIndex = 0;
        }
    }
    self.lastIndex = selectedIndex;
}

- (void)show {
    if (self.selectedIndex > 0 && self.selectedIndex < ERROR_INDEX) {
        _arrM[self.selectedIndex/4].selectedIndex = (self.selectedIndex-1)%3+1;
    } else {
        _arrM[0].selectedIndex = 1;
    }
    for (QHModeSelectedView *modeView in _arrM) {
        if (!modeView.isShow) {
            [modeView showOfFolder];
        }
    }
}

- (void)folder {
    for (QHModeSelectedView *modeView in _arrM) {
        if (modeView.isShow) {
            modeView.selectedIndex = 0;
            [modeView showOfFolder];
        }
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
