//
//  QHSearchFriendViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSearchFriendViewController.h"
#import "QHSearchResultViewController.h"

@interface QHSearchFriendViewController ()<UITextFieldDelegate>

@end

@implementation QHSearchFriendViewController {
    UITextField *_searchTF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"添加好友", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _searchTF = [[UITextField alloc] init];
    _searchTF.placeholder = QHLocalizedString(@"搜索手机号码 / 昵称", nil);
    _searchTF.font = FONT(15);
    UIButton *rightView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    _searchTF.rightView = rightView;
    [rightView setImage:IMAGENAMED(@"cancel_white") forState:(UIControlStateNormal)];
    [rightView addTarget:self action:@selector(clearTextField) forControlEvents:(UIControlEventTouchUpInside)];
    _searchTF.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_searchTF];
    _searchTF.returnKeyType = UIReturnKeyDone;
    _searchTF.delegate = self;
    
    [_searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(30);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-20);
    }];
    
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(0, 60, SCREEN_WIDTH, 10)];
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(15, 130, SCREEN_WIDTH-30, 1)];
    
    UIButton *searchPhoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 60)];
    [self.view addSubview:searchPhoneBtn];
    [searchPhoneBtn addTarget:self action:@selector(gotoPhoneContact) forControlEvents:(UIControlEventTouchUpInside)];
    UILabel *searchLabel = [UILabel labelWithFont:15 color:UIColorFromRGB(0x52627c)];
    [searchPhoneBtn addSubview:searchLabel];
    searchLabel.text = QHLocalizedString(@"搜索手机联系人好友", nil);
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchPhoneBtn);
        make.left.equalTo(searchPhoneBtn).mas_offset(15);
    }];
    [[QHTools toolsDefault] addCellRightView:searchPhoneBtn point:CGPointMake(SCREEN_WIDTH-28, 23.5)];
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 250, SCREEN_WIDTH-30, 50)];
    searchBtn.layer.cornerRadius = 3;
    [searchBtn setTitle:QHLocalizedString(@"搜索", nil) forState:(UIControlStateNormal)];
    searchBtn.backgroundColor = MainColor;
    [self.view addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(search) forControlEvents:(UIControlEventTouchUpInside)];
    
    __weak typeof(_searchTF)weakTF = _searchTF;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakTF resignFirstResponder];
    }];
    [self.view addGestureRecognizer:tap];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)search {
//    [[QHSocketManager manager] send:@{
//                                      @"object" : @"15107716547"
//                                      } completion:^(id response) {
//                                          NSLog(@"-----response:%@",response);
//                                      }];
    QHSearchResultViewController *searchResult = [[QHSearchResultViewController alloc] init];
    searchResult.searchContent = _searchTF.text;
    [self.navigationController pushViewController:searchResult animated:YES];
}

- (void)gotoPhoneContact {
    NSLog(@"showPhoencContact");
}

- (void)clearTextField {
    _searchTF.text = @"";
    [_searchTF becomeFirstResponder];
}

- (void)gotoBack {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
