//
//  QHPepperRobotViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPepperRobotViewController.h"
#import "QHBaseLabelCell.h"
#import "QHTextFieldAlertView.h"
#import "QHRobotImageViewController.h"
#import "QHRobotAIModel.h"
#import "QHRobotSettingViewController.h"

@interface QHPepperRobotViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) QHRobotAIModel *model;

@end

@implementation QHPepperRobotViewController {
    UITableView *_mainView;
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"Pepper机器人", nil);
    _titleArr = @[QHLocalizedString(@"机器人姓名", nil), QHLocalizedString(@"机器人形象", nil)];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:QHLocalizedString(@"设置", nil) forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(setting) forControlEvents:(UIControlEventTouchUpInside)];
    rightBtn.titleLabel.font = FONT(14);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    
    self.nickname = @"Pepper";
    self.name = @"default";
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImageName:) name:CHANGEPEPPERIMAGENAME_NOTI object:nil];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)setting {
    QHRobotSettingViewController *settingVC = [[QHRobotSettingViewController alloc] init];
    settingVC.model = self.model;
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)changeImageName: (NSNotification *)noti {
    self.name = noti.userInfo[@"name"];
    [_mainView reloadData];
}

- (void)loadData {
    [QHRobotAIModel queryPepperSetWithSuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        self.model = [QHRobotAIModel modelWithJSON:responseObject[@"data"][@"pepperSet"]];
        self.nickname = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"pepperSet"][@"nickname"]];
        if (![[NSString stringWithFormat:@"%@",responseObject[@"data"][@"pepperSet"][@"pepperImage"]] isEqualToString:@"<null>"]) {
            self.name = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"pepperSet"][@"pepperImage"][@"name"]];
        }
        [_mainView reloadData];
    } failure:nil];
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _mainView.backgroundColor = WhiteColor;
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [self.view addSubview:_mainView];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainView registerClass:[QHBaseLabelCell class] forCellReuseIdentifier:[QHBaseLabelCell reuseIdentifier]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
    ((QHBaseLabelCell *)cell).titleLabel.text = _titleArr[indexPath.row];
    ((QHBaseLabelCell *)cell).detailLabel.text = indexPath.row == 0 ? self.nickname : self.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        __weak typeof(_mainView)weakView = _mainView;
        QHTextFieldAlertView *alertView = [[QHTextFieldAlertView alloc] initWithTitle:QHLocalizedString(@"机器人名称", nil) placeholder:@"" content:self.nickname sureBlock:^(NSString *params) {
            [QHRobotAIModel updatePepperSetWithNickname:params pepperimageid:self.name successBlock:^(NSURLSessionDataTask *task, id responseObject) {
                QHBaseLabelCell *cell = [weakView cellForRowAtIndexPath:indexPath];
                cell.detailLabel.text = params;
            } failureBlock:nil];
        } failureBlock:nil];
        [alertView show];
    } else {
        QHRobotImageViewController *robotImgVC = [[QHRobotImageViewController alloc] init];
        robotImgVC.image = self.name;
        [self.navigationController pushViewController:robotImgVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SCREEN_WIDTH/375.0*200+10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    bgView.backgroundColor = WhiteColor;
    
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 110, 110)];
    titleView.image = IMAGENAMED(@"Pepper_pepper");
    [bgView addSubview:titleView];
    titleView.centerX = SCREEN_WIDTH*0.5;
    [[QHTools toolsDefault] addLineView:bgView :CGRectMake(0, 170, SCREEN_WIDTH, 10)];
    
    return bgView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGFloat itemHeight = SCREEN_WIDTH/375.0*100;
    CGFloat topMargin = 0.25 * itemHeight;
    CGFloat titleMargin = 0.14 * itemHeight;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375.0*200+10)];
    bgView.backgroundColor = WhiteColor;
    
    [[QHTools toolsDefault] addLineView:bgView :CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    NSArray *titleArr = @[QHLocalizedString(@"聊天托管", nil), QHLocalizedString(@"音频处理", nil), QHLocalizedString(@"图片处理", nil), QHLocalizedString(@"聊天托管", nil), QHLocalizedString(@"音频处理", nil), QHLocalizedString(@"更多", nil)];
    
    NSArray *picArr = @[@"Robot_auto", @"Robot_audio", @"Robot_image", @"Robot_auto", @"Robot_audio", @"Robot_more"];
    
    for (NSInteger i = 0; i < 6; i++) {
        UIButton *itemBtn = [UIButton getImageBtnWithTitle:titleArr[i] imageStr:picArr[i] imageWH:CGSizeMake(30, 30) titleSize:14 titleColoe:RGB939EAE space:titleMargin];
        [itemBtn sizeToFit];
        CGRect frame = itemBtn.frame;
        frame.origin.y = i/3*itemHeight+topMargin;
        itemBtn.frame = frame;
        itemBtn.centerX =  (i%3*2+1)*SCREEN_WIDTH/6.0;
        [bgView addSubview:itemBtn];
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
