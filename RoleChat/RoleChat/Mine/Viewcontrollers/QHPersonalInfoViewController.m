//
//  QHPersonalInfoViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPersonalInfoViewController.h"
#import "QHSimplePersoninfoCell.h"
#import "QHBaseLabelCell.h"
#import "QHAddFriendCodeView.h"
#import "QHTextFieldAlertView.h"
#import "QHGenderAlertView.h"
#import "QHUpdateUserInfoModel.h"
#import "QHZoneCodeModel.h"
#import "QHSelectZoneViewController.h"

#define kDefaultExpireDate 15

@interface QHPersonalInfoViewController ()<UITableViewDataSource, UITableViewDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, copy) __block NSArray<QHZoneCodeModel *>* zoneCodesArray;
@property (nonatomic, copy) __block NSArray<QHZoneCodeModel *>* countriesArray;

@end

@implementation QHPersonalInfoViewController {
    UITableView *_mainView;
    NSArray *_mainTitles;
    NSString *_zone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"个人信息", nil);
    
    _mainTitles = @[@"二维码", @"昵称", @"地区", @"性别"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti) name:UPDATEUSERINFO_NOTI object:nil];
    
    if([self load:@"country" array:self.countriesArray] == NO) {
        [QHZoneCodeModel getGlobalParamWithGroup:Group_PhoneCode lastUpdateDate:[NSString stringWithFormat:@"%lu",(unsigned long)[[NSDate date] toTimeIntervalSince1970]] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            self.zoneCodesArray = [NSArray modelArrayWithClass:[QHZoneCodeModel class] json:[responseObject[@"data"][@"phonecode"] valueForKey:[QHLocalizable currentLocaleShort]]];
            self.countriesArray = [NSArray modelArrayWithClass:[QHZoneCodeModel class] json:[responseObject[@"data"][@"country"] valueForKey:[QHLocalizable currentLocaleShort]]];
            [self cache:@"zone" array:self.zoneCodesArray];
            [self cache:@"country" array:self.countriesArray];
            [_mainView reloadData];
        } failure:nil];
    }

    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)noti {
    [_mainView reloadData];
}

-(BOOL)load: (NSString *)content array: (NSArray<QHZoneCodeModel *> *)array {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@", content,[QHLocalizable currentLocaleShort]]];
    
    if([fileManager fileExistsAtPath:filePath] == YES) {
        NSDate* expireDate = (NSDate*)[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"expireDate_%@", [QHLocalizable currentLocaleShort]]];
        CGFloat expireTime = ABS([[NSDate date] timeIntervalSinceDate:expireDate]) / (24 * 60 * 60);
        if(expireTime <= kDefaultExpireDate) {
            self.countriesArray = [NSArray modelArrayWithClass:[QHZoneCodeModel class] json:[NSArray arrayWithContentsOfFile:filePath]];
            return YES;
        }
        else
            [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

- (void)cache:(NSString *)content array: (NSArray<QHZoneCodeModel *> *)array {
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@", content, [QHLocalizable currentLocaleShort]]];

    NSMutableArray *dictArr = [[NSMutableArray alloc] init];
    for (QHZoneCodeModel *model in array) {
        NSDictionary *dict = [model modelToJSONObject];
        [dictArr addObject:dict];
        if ([model.code isEqualToString:[QHPersonalInfo sharedInstance].userInfo.phoheCode]) {
            _zone = [[model.value componentsSeparatedByString:@")"] lastObject];
        }
    }
    [dictArr writeToFile:filePath atomically:YES];
    //过期时间
    [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:[NSString stringWithFormat:@"expireDate_%@", [QHLocalizable currentLocaleShort]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    _mainView.backgroundColor = WhiteColor;
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(_mainView)weakView = _mainView;
    _mainView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakView reloadData];
    }];
    
    [_mainView registerClass:[QHSimplePersoninfoCell class] forCellReuseIdentifier:[QHSimplePersoninfoCell reuseIdentifier]];
    [_mainView registerClass:[QHBaseLabelCell class] forCellReuseIdentifier:[QHBaseLabelCell reuseIdentifier]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 140 : 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = UIColorFromRGB(0xf5f6fa);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1f : 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHSimplePersoninfoCell reuseIdentifier]];
        [((QHSimplePersoninfoCell *)cell).headView loadImageWithUrl:[QHPersonalInfo sharedInstance].userInfo.imgurl placeholder:ICON_IMAGE];
        ((QHSimplePersoninfoCell *)cell).headView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImgurl)];
        [((QHSimplePersoninfoCell *)cell).headView addGestureRecognizer:tap];
        ((QHSimplePersoninfoCell *)cell).nameLabel.text = [QHPersonalInfo sharedInstance].userInfo.nickname;
        ((QHSimplePersoninfoCell *)cell).phoneLabel.text = [NSString stringWithFormat:@"+%@ %@",[QHPersonalInfo sharedInstance].userInfo.phoheCode, [QHPersonalInfo sharedInstance].userInfo.phone];
        UIImage *img = [[QHPersonalInfo sharedInstance].userInfo.gender isEqualToString:@"1"] ? IMAGENAMED(@"gender_male") : IMAGENAMED(@"gender_female");
        [((QHSimplePersoninfoCell *)cell).genderView setImage:img forState:(UIControlStateNormal)];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseLabelCell reuseIdentifier]];
        ((QHBaseLabelCell *)cell).titleLabel.text = [NSString stringWithFormat:QHLocalizedString(@"%@", nil),_mainTitles[indexPath.row]];
        if (indexPath.row == 0) {
            ((QHBaseLabelCell *)cell).rightView.image = IMAGENAMED(@"qrcode");
        } else if(indexPath.row == 1) {
            ((QHBaseLabelCell *)cell).detailLabel.text = [QHPersonalInfo sharedInstance].userInfo.nickname;
        } else if (indexPath.row == 2) {
            if ([QHPersonalInfo sharedInstance].userInfo.country.length) {
                for (QHZoneCodeModel *model in self.countriesArray) {
                    if ([model.code isEqualToString:[QHPersonalInfo sharedInstance].userInfo.country]) {
                        ((QHBaseLabelCell *)cell).detailLabel.text = model.value;
                        break;
                    }
                }
            } else {
                ((QHBaseLabelCell *)cell).detailLabel.text = _zone;
            }
        } else if (indexPath.row == 3) {
            ((QHBaseLabelCell *)cell).detailLabel.text = [[QHPersonalInfo sharedInstance].userInfo.gender isEqualToString:@"1"] ? QHLocalizedString(@"男", nil) : QHLocalizedString(@"女", nil);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(_mainView)weakView = _mainView;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [[QHAddFriendCodeView manager] show];
        } else if (indexPath.row == 1) {
            QHTextFieldAlertView *textFieldAlertView = [[QHTextFieldAlertView alloc] initWithTitle:QHLocalizedString(@"昵称", nil) placeholder:QHLocalizedString(@"请输入昵称", nil) content:[QHPersonalInfo sharedInstance].userInfo.nickname sureBlock:^(id params) {
                [QHUpdateUserInfoModel updateUserInfoWithNickName:params imgurl:[QHPersonalInfo sharedInstance].userInfo.imgurl.length ?  [QHPersonalInfo sharedInstance].userInfo.imgurl : @"" gender:[QHPersonalInfo sharedInstance].userInfo.gender success:^(NSURLSessionDataTask *task, id responseObject) {
                    [QHPersonalInfo sharedInstance].userInfo = [QHUserInfo modelWithJSON:responseObject[@"data"]];
                    [weakView reloadData];
                    [[QHSocketManager manager] authSetNickname:params completion:nil failure:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:INFO_CHANGE_NOTI object:nil];
                } failure:nil];
                [weakView reloadData];
            } failureBlock:nil];
            [textFieldAlertView show];
        } else if (indexPath.row == 3) {
            QHGenderAlertView *genderAlertView = [[QHGenderAlertView alloc] initWithGender:[QHPersonalInfo sharedInstance].userInfo.gender callbackBlock:^(id params) {
                [QHUpdateUserInfoModel updateUserInfoWithNickName:[QHPersonalInfo sharedInstance].userInfo.nickname imgurl:[QHPersonalInfo sharedInstance].userInfo.imgurl.length ?  [QHPersonalInfo sharedInstance].userInfo.imgurl : @"" gender:params success:^(NSURLSessionDataTask *task, id responseObject) {
                    [QHPersonalInfo sharedInstance].userInfo = [QHUserInfo modelWithJSON:responseObject[@"data"]];
                    [weakView reloadData];
                    [[NSNotificationCenter defaultCenter] postNotificationName:INFO_CHANGE_NOTI object:nil];
                } failure:nil];
            }];
            [genderAlertView show];
        } else if (indexPath.row == 2) {
            QHSelectZoneViewController *selectZoneVC = [[QHSelectZoneViewController alloc] init];
            selectZoneVC.zoneCodesArray = self.countriesArray;
            [self.navigationController pushViewController:selectZoneVC animated:YES];
        }
    }
}

- (void)changeImgurl {
    __weak typeof(_mainView)weakView = _mainView;
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [Util uploadImages:photos imgSize:CGSizeMake(100, 100) inView:self.view whenComplete:^(id params) {
            [QHUpdateUserInfoModel updateUserInfoWithNickName:[QHPersonalInfo sharedInstance].userInfo.nickname imgurl:[NSString stringWithFormat:@"%@%@",QINIU_IMAGE_PREFIX,params] gender:[QHPersonalInfo sharedInstance].userInfo.gender success:^(NSURLSessionDataTask *task, id responseObject) {
                [QHPersonalInfo sharedInstance].userInfo = [QHUserInfo modelWithJSON:responseObject[@"data"]];
                [weakView reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:INFO_CHANGE_NOTI object:nil];
            } failure:nil];
        } whenFailure:^(NSURLSessionDataTask *task, id responseObject) {
            [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
        }];
    }];
    [self presentViewController:imagePickerController animated:YES completion:nil];
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
