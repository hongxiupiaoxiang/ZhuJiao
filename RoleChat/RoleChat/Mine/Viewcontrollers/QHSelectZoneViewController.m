//
//  QHSelectZoneViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/28.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSelectZoneViewController.h"
#import "QHSelectZoneCell.h"
#import "QHUpdateUserInfoModel.h"

@interface QHSelectZoneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *zoneTF;
@property (nonatomic, strong) NSMutableArray<QHZoneCodeModel *> *defaultZoneArr;
@property (nonatomic, strong) NSMutableArray<QHZoneCodeModel *> *searchZoneArr;
@property (nonatomic, strong) QHZoneCodeModel *model;

@end

@implementation QHSelectZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WeakSelf
    [self addRightTitleItem:QHLocalizedString(@"保存", nil) color:MainColor sendBlock:^(id prama) {
        [weakSelf save];
    }];
    
    self.title = QHLocalizedString(@"选择区号", nil);
    
    self.defaultZoneArr = [NSMutableArray arrayWithArray:self.zoneCodesArray];
    self.searchZoneArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < self.zoneCodesArray.count; i++) {
        if ([[QHPersonalInfo sharedInstance].userInfo.country isEqualToString:self.zoneCodesArray[i].code]) {
            self.model = self.zoneCodesArray[i];
            [self.defaultZoneArr insertObject:self.zoneCodesArray[i] atIndex:0];
            [self.defaultZoneArr removeObjectAtIndex:i+1];
            break;
        }
    }
    
    [self.tableView registerClass:[QHSelectZoneCell class] forCellReuseIdentifier:[QHSelectZoneCell reuseIdentifier]];
    
    self.tableView.backgroundColor = WhiteColor;
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    headView.backgroundColor = WhiteColor;
    [[QHTools toolsDefault] addLineView:headView :CGRectMake(0, 70, SCREEN_WIDTH, 10)];
    [headView addSubview:self.zoneTF];
    
    [self.zoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_top).mas_offset(35);
        make.left.equalTo(headView).mas_offset(15);
    }];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _zoneTF.text.length ?  self.searchZoneArr.count : self.defaultZoneArr.count;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_zoneTF resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_zoneTF.text.length) {
        self.model = self.searchZoneArr[indexPath.row];
    } else {
        self.model = self.defaultZoneArr[indexPath.row];
    }
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHSelectZoneCell *zoneCell = [tableView dequeueReusableCellWithIdentifier:[QHSelectZoneCell reuseIdentifier]];
    if (_zoneTF.text.length) {
        zoneCell.zoneLabel.text = self.searchZoneArr[indexPath.row].value;
    } else {
        zoneCell.zoneLabel.text = self.defaultZoneArr[indexPath.row].value;
    }
    if ([self.model.value isEqualToString:zoneCell.zoneLabel.text]) {
        zoneCell.isSelected = YES;
    } else {
        zoneCell.isSelected = NO;
    }
    return zoneCell;
}

- (void)save {
    if (self.model) {
        [QHUpdateUserInfoModel updateUserInfoWithCountry:self.model.code success:^(NSURLSessionDataTask *task, id responseObject) {
            [self showHUDOnlyTitle:QHLocalizedString(@"修改地区成功", nil)];
            [QHPersonalInfo sharedInstance].userInfo.country = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"country"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATEUSERINFO_NOTI object:nil];
            PerformOnMainThreadDelay(1.5, [self.navigationController popViewControllerAnimated:YES];);
        } failure:nil];
    }
}

- (UITextField *)zoneTF {
    if (_zoneTF == nil) {
        _zoneTF = [[UITextField alloc] init];
        _zoneTF.placeholder = QHLocalizedString(@"搜索国家或地区", nil);
        _zoneTF.font = FONT(17);
        _zoneTF.returnKeyType = UIReturnKeySearch;
        _zoneTF.delegate = self;
    }
    return _zoneTF;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text) {
        [self.searchZoneArr removeAllObjects];
        for (QHZoneCodeModel *model in self.zoneCodesArray) {
            if ([model.value containsString:textField.text]) {
                [self.searchZoneArr addObject:model];
            }
        }
    }
    [self.tableView reloadData];
    [textField resignFirstResponder];
    return YES;
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
