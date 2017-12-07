//
//  QHChatViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatViewController.h"
#import "QHChatKeyboard.h"
#import "QHChatMeCell.h"
#import "QHChatOtherCell.h"
#import "QHChatModel.h"
#import "QHChatSettingViewController.h"
#import "QHPopRightButtonView.h"
#import "QHChattipCell.h"
#import "QHChatOtherMoreCell.h"
#import "QHChatFunctionView.h"
#import "QHPersonInfoViewController.h"
#import "QHChatSignViewController.h"
#import "QHGroupSettingViewController.h"

#import "QHRealmMessageModel.h"
#import "QHRealmMListModel.h"

@interface QHChatViewController ()<UITableViewDelegate,UITableViewDataSource,QHChatKeyboardDelegate,QHChatDelegate>

@property (nonatomic, strong) UITableView *mainView;
// 消息
@property (nonatomic, strong) NSMutableArray<QHChatModel *> *messages;
// 键盘
@property (nonatomic, strong) QHChatKeyboard *keyboard;
// 弹窗
@property (nonatomic, strong) QHPopRightButtonView *rightBtnView;
// 操作
@property (nonatomic, assign) NSInteger checkCellIndex;
@property (nonatomic, assign) BOOL isOprate;
// leftItem
@property (nonatomic, strong) UIButton *leftBtn;
// leftItemcancel
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *operateBtn;
@property (nonatomic, strong) QHChatFunctionView *functionView;

// rid
@property (nonatomic, copy) NSString *rid;


@property (nonatomic, strong) RLMNotificationToken *messageToken;



@end

@implementation QHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建UI
    [self setupUI];
    
    // 配置聊天IM聊天环境
    [self configIM];
    
    // Do any additional setup after loading the view.
}

- (void)loadHistoryMessages {
    self.messages = [[NSMutableArray alloc] init];
    RLMResults *result = [QHRealmMessageModel objectsInRealm:[QHRealmDatabaseManager currentRealm] where:@"rid=%@",self.rid];
    
    QHRealmMListModel *mmodel = [QHRealmMListModel objectInRealm:[QHRealmDatabaseManager currentRealm] forPrimaryKey:self.rid];
    [[QHRealmDatabaseManager currentRealm] transactionWithBlock:^{
        mmodel.unreadcount = 0;
    }];
    
    for (QHRealmMessageModel *realmModel in result) {
        [[QHRealmDatabaseManager currentRealm] transactionWithBlock:^{
            realmModel.read = YES;
        }];
        QHChatModel *model = [[QHChatModel alloc] init];
        model.content = realmModel.msg;
        model.time = realmModel.ts.$date;
        model.showTime = [self showTimeWith:model];
        model.nickname = realmModel.u.username;
        if (![realmModel.u.username isEqualToString:[QHPersonalInfo sharedInstance].userInfo.username]) {
            model.imgurl = self.contactModel.imgurl;
        }
        
        [self.messages addObject:model];
    }

    [_mainView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollBottom:NO];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseChatCell *cell;
//    if (indexPath.row % 2) {
//        self.messages[indexPath.row].showTime = YES;
//        self.messages[indexPath.row].showNickname = YES;
//        if (self.checkCellIndex >= -1 && self.isOprate == YES) {
//            cell = [tableView dequeueReusableCellWithIdentifier:[QHChatOtherMoreCell reuseIdentifier]];
//            if (indexPath.row == self.checkCellIndex || self.checkCellIndex == -1) {
//                ((QHChatOtherMoreCell *)cell).check = YES;
//            } else {
//                ((QHChatOtherMoreCell *)cell).check = NO;
//            }
//        } else {
//            cell = [tableView dequeueReusableCellWithIdentifier:[QHChatOtherCell reuseIdentifier]];
//            cell.delegate = self;
//        }
//    } else {
//        cell = [tableView dequeueReusableCellWithIdentifier:[QHChatMeCell reuseIdentifier]];
//    }
    if ([self.messages[indexPath.row].nickname isEqualToString:[QHPersonalInfo sharedInstance].userInfo.username]) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHChatMeCell reuseIdentifier]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHChatOtherCell reuseIdentifier]];
    }
    
    cell.model = self.messages[indexPath.row];
    return cell;
}

- (void)sendMessages:(NSString *)message {
    QHChatModel *model = [[QHChatModel alloc] init];
    model.content = message;
    model.nickname = [QHPersonalInfo sharedInstance].userInfo.username;
    model.time = [NSObject getNowTimeTimestamp];
    model.showTime = [self showTimeWith:model];
    [self.messages addObject:model];
    [self.mainView reloadData];
    [self scrollBottom:NO];
    [[QHSocketManager manager] sendMessageWithRid:self.rid msg:message completion:^(id response) {
        QHRealmMessageModel *model = [QHRealmMessageModel modelWithJSON:response[@"result"]];
        QHRealmMListModel *mmodel = [QHRealmMListModel modelWithJSON:response[@"result"]];
        model.read = YES;
        mmodel.unreadcount = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [QHRealmDatabaseManager updateRecord:model];
        [QHRealmDatabaseManager updateRecord:mmodel];
        });
    } failure:nil];
}

- (BOOL)showTimeWith: (QHChatModel *)model {
    QHChatModel *chatModel = self.messages.lastObject;
    if (chatModel == nil) {
        return YES;
    } else {
        NSString *lastTime = [[chatModel.time componentsSeparatedByString:@":"] lastObject];
        NSString *nowTime = [[model.time componentsSeparatedByString:@":"] lastObject];
        if (nowTime.longValue - lastTime.longValue >= 3*1000*60) {
            return YES;
        } else {
            return NO;
        }
    }
}

#pragma mark QHChatKeyboardDelegate
- (void)keyboardFrameChange {
    [self scrollBottom:NO];
}

#pragma mark QHChatDelegate
- (void)longTapinView:(QHBaseChatCell *)cell model:(QHChatModel *)model ges:(UILongPressGestureRecognizer *)ges {
    if (self.rightBtnView.isShow == YES) {
        return;
    }
    CGPoint point = [ges locationInView:self.view];
    point.y+=64;
    if (point.y+280 > self.keyboard.mj_y) {
        point.y -= (point.y+290-64-self.keyboard.mj_y);
    }
    if (point.y < 64) {
        point.y = 84;
    }
    self.checkCellIndex = [self.mainView indexPathForCell:cell].row;
    [self.rightBtnView showInPoint:point];
}

- (void)tapInHeadView:(QHBaseChatCell *)cell model:(QHChatModel *)model {
    QHPersonInfoViewController *personInfoVC = [[QHPersonInfoViewController alloc] init];
    personInfoVC.contactModel = self.contactModel;
    [self.navigationController pushViewController:personInfoVC  animated:YES];
}

- (QHPopRightButtonView *)rightBtnView {
    if (_rightBtnView == nil) {
        WeakSelf
        _rightBtnView = [[QHPopRightButtonView alloc] initWithTitleArray:@[QHLocalizedString(@"复制", nil), QHLocalizedString(@"撤回", nil), QHLocalizedString(@"点赞", nil), QHLocalizedString(@"内容合理", nil), QHLocalizedString(@"内容不符", nil), QHLocalizedString(@"加标签", nil) ,QHLocalizedString(@"更多", nil)] cellHeight:40 titleAliment:TitleAliment_Left point:CGPointMake(0, 0) selectIndexBlock:^(id params) {
            switch ([params integerValue]) {
                case 5: {
                    QHChatSignViewController *signVC = [[QHChatSignViewController alloc] init];
                    [weakSelf.navigationController pushViewController:signVC animated:YES];
                }
                    break;
                case 6: {
                    weakSelf.isOprate = YES;
                    [weakSelf.keyboard resetBtnState];
                    weakSelf.keyboard.hidden = YES;
                    weakSelf.operateBtn.hidden = NO;
                    [weakSelf.mainView reloadData];
                    weakSelf.navigationItem.leftBarButtonItem = nil;
                    weakSelf.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:weakSelf.cancelBtn];
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }
    return _rightBtnView;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
        [_cancelBtn setTitle:QHLocalizedString(@"取消", nil) forState:(UIControlStateNormal)];
        _cancelBtn.titleLabel.font = FONT(14);
        [_cancelBtn addTarget:self action:@selector(cancelOperate) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelBtn;
}

- (void)cancelOperate {
    self.isOprate = NO;
    self.keyboard.hidden = NO;
    self.operateBtn.hidden = YES;
    self.checkCellIndex = -1;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    [self.mainView reloadData];
}

- (UIButton *)leftBtn {
    if (_leftBtn == nil) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setImage:IMAGENAMED(@"back") forState:(UIControlStateNormal)];
//        [_leftBtn setTitle:@"(99)" forState:(UIControlStateNormal)];
        [_leftBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
        _leftBtn.titleLabel.font = FONT(14);
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_leftBtn addTarget:self action:@selector(gotoBack) forControlEvents:(UIControlEventTouchUpInside)];
        [_leftBtn sizeToFit];
    }
    return _leftBtn;
}

- (UIButton *)operateBtn {
    if (_operateBtn == nil) {
        _operateBtn = [[UIButton alloc] init];
        [_operateBtn setTitle:QHLocalizedString(@"批量操作", nil) forState:(UIControlStateNormal)];
        [_operateBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
        _operateBtn.titleLabel.font = FONT(16);
        _operateBtn.layer.borderColor = UIColorFromRGB(0xf0f1f5).CGColor;
        _operateBtn.layer.borderWidth = 1.0;
        ButtonAddTarget(_operateBtn, showFunctionView:)
    }
    return _operateBtn;
}

- (void)showFunctionView: (UIButton *)sender {
    sender.hidden = YES;
    [self.functionView show];
}

- (QHChatFunctionView *)functionView {
    WeakSelf
    if (_functionView == nil) {
        _functionView = [[QHChatFunctionView alloc] initWithPoint:CGPointMake(15, SCREEN_HEIGHT-160) SelectedIndexCallback:^(id params) {
            weakSelf.operateBtn.hidden = NO;
        }];
    }
    return _functionView;
}

- (void)gotoBack {
    [super gotoBack];
}

- (void)setupUI {
    self.title = self.contactModel.nickname;
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:IMAGENAMED(@"Chat_setting") forState:(UIControlStateNormal)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    [rightBtn addTarget:self action:@selector(gotoSetting) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.mainView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    [self.view addSubview:self.mainView];
    [self.mainView registerClass:[QHChatOtherCell class] forCellReuseIdentifier:[QHChatOtherCell reuseIdentifier]];
    [self.mainView registerClass:[QHChatMeCell class] forCellReuseIdentifier:[QHChatMeCell reuseIdentifier]];
    [self.mainView registerClass:[QHChattipCell class] forCellReuseIdentifier:[QHChattipCell reuseIdentifier]];
    [self.mainView registerClass:[QHChatOtherMoreCell class] forCellReuseIdentifier:[QHChatOtherMoreCell reuseIdentifier]];
    self.mainView.backgroundColor = WhiteColor;
    self.mainView.estimatedRowHeight = 100;
    self.mainView.rowHeight = UITableViewAutomaticDimension;
    self.mainView.delegate = self;
    self.mainView.dataSource = self;
    self.mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.checkCellIndex = -2;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.keyboard = [[QHChatKeyboard alloc] initWithKeyboardInView:self.view delegate:self];
    [self.keyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(150);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.keyboard.mas_top);
    }];
    
    [self.view addSubview:self.operateBtn];
    [self.operateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    self.operateBtn.hidden = YES;
    
    WeakSelf
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.keyboard resetBtnState];
    }];
    [self.mainView addGestureRecognizer:tap];
}

- (void)configToken {
    __weak typeof(_mainView)weakView = _mainView;
    self.messageToken = [[QHRealmMessageModel objectsInRealm:[QHRealmDatabaseManager currentRealm] where:@"rid=%@",self.rid] addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if (error) {
            DLog(@"Failed tp open Realm!")
            return ;
        }
        if (change) {
            RLMResults *result = [QHRealmMessageModel objectsInRealm:[QHRealmDatabaseManager currentRealm] where:@"rid=%@ AND read=false",self.rid];
            
            for (QHRealmMessageModel *realmModel in result) {
                [[QHRealmDatabaseManager currentRealm] transactionWithBlock:^{
                    realmModel.read = YES;
                }];
                if (![realmModel.u.username isEqualToString:[QHPersonalInfo sharedInstance].userInfo.username]) {
                    QHChatModel *model = [[QHChatModel alloc] init];
                    model.content = realmModel.msg;
                    model.time = realmModel.ts.$date;
                    model.showTime = [self showTimeWith:model];
                    model.nickname = realmModel.u.username;
                    if (![realmModel.u.username isEqualToString:[QHPersonalInfo sharedInstance].userInfo.username]) {
                        model.imgurl = self.contactModel.imgurl;
                    }
                    [self.messages addObject:model];
                }
            }
            
            [weakView reloadData];
            [self scrollBottom:NO];
        }
    }];

}

- (void)configIM {
    QHRealmContactModel *model = [QHRealmContactModel objectInRealm:[QHRealmDatabaseManager currentRealm] forPrimaryKey:self.contactModel.rid];
    if (model.rid.length) {
        self.rid = model.rid;
        [self loadHistoryMessages];
        [self configToken];
        return;
    }
    
//    [[QHSocketManager manager] createDirectMessageWithUsername:self.contactModel.username completion:^(id response) {
//        if (response[@"result"]) {
//            self.rid = [NSString stringWithFormat:@"%@",response[@"result"][@"rid"]];
//            QHRealmContactModel *model = [QHRealmContactModel objectInRealm:[QHRealmDatabaseManager currentRealm] forPrimaryKey:self.contactModel.username];
//            [[QHRealmDatabaseManager currentRealm] transactionWithBlock:^{
//                model.rid = self.rid;
//            }];
//            [self loadHistoryMessages];
//            [self configToken];
//            [[QHSocketManager manager] streamRoomMessagesWithRoomId:self.rid completion:^(id response) {
//                if (![[QHSocketManager manager].rooms containsObject:self.rid]) {
//                    [[QHSocketManager manager].rooms addObject:self.rid];
//                }
//            } failure:nil];
//
//        }
//    } failure:nil];
}


- (void)gotoSetting {
    QHBaseViewController *targetVC;
    if (self.contactModel) {
        targetVC = [[QHChatSettingViewController alloc] init];
        ((QHChatSettingViewController *)targetVC).contactModel = self.contactModel;
    } else {
        targetVC = [[QHGroupSettingViewController alloc] init];
    }
    if (targetVC) {
        [self.navigationController pushViewController:targetVC animated:YES];
    }
}

- (void)handleKeyboard:(NSNotification *)aNotification {
    CGRect keyboardFrame = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardTime = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [_keyboard mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-([UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y)+100);
    }];
    [UIView animateWithDuration:keyboardTime animations:^{
        [self.view layoutIfNeeded];
    }];
    /** 增加监听键盘大小变化通知,并且让tableView 滚动到最底部 */
    [self scrollBottom:NO];
}

- (void)scrollBottom:(BOOL)animated {
    if (self.messages.count >= 2) {
        [self.mainView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
