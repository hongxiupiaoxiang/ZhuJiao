//
//  QHTabbarChildViewController.m
//  GoldWorld
//
//  Created by zfQiu on 2017/3/15.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseNavigationController.h"
#import "QHTabbarChildViewController.h"
#import "QHPopRightButtonView.h"
#import "QHSearchFriendViewController.h"
#import "QHAddgroupViewController.h"

#define BTN_TAG 10086

@interface QHTabbarChildViewController ()

@end

@implementation QHTabbarChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

-(void)setupUI {
    [self.view removeAllSubviews];
    
    self.navigationItem.leftBarButtonItem = nil;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    [searchBtn setImage:IMAGENAMED(@"search") forState:(UIControlStateNormal)];
    [searchBtn addTarget:self action:@selector(searchFriend) forControlEvents:(UIControlEventTouchUpInside)];
    searchBtn.tag = BTN_TAG;
    UIBarButtonItem *rigthItem0 = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    [moreBtn setImage:IMAGENAMED(@"more") forState:(UIControlStateNormal)];
    [moreBtn addTarget:self action:@selector(showMoreMenu) forControlEvents:(UIControlEventTouchUpInside)];
    moreBtn.tag = BTN_TAG+1;
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItems = @[rightItem1, rigthItem0];
    
    self.navigationItem.title = QHLocalizedString(self.tabTitleKey, nil);
    return ;
}

- (void)searchFriend {
    QHSearchFriendViewController *searchFriendVC = [[QHSearchFriendViewController alloc] init];
    QHBaseNavigationController *nav = [[QHBaseNavigationController alloc] initWithRootViewController:searchFriendVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)addGroup {
    QHAddgroupViewController *addGroupVC = [[QHAddgroupViewController alloc] init];
    QHBaseNavigationController *nav = [[QHBaseNavigationController alloc] initWithRootViewController:addGroupVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)showMoreMenu {
    WeakSelf
    QHPopRightButtonView *moreMenu = [[QHPopRightButtonView alloc] initWithTitleArray:@[QHLocalizedString(@"添加好友", nil),QHLocalizedString(@"创建群聊", nil),QHLocalizedString(@"扫一扫", nil)] point:CGPointMake(SCREEN_WIDTH-135,64) selectIndexBlock:^(id params) {
        if ([params integerValue] == 0) {
            [weakSelf searchFriend];
        } else if ([params integerValue] == 1) {
            [weakSelf addGroup];
        }
    }];
    [moreMenu show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willUpdateData {
    return ;
}

@end
