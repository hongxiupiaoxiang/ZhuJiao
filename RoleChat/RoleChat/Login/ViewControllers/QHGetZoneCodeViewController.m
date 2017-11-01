//
//  QHGetZoneCodeViewController.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/15.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHLocalizable.h"
#import "QHUserRegistView.h"
#import "QHGetZoneCodeViewController.h"
#import "QHZoneCodeModel.h"
#import "QHZoneCodeCell.h"
#import "QHPersonalInfo.h"

#define kGetZoneCodeTableViewCellIdentifier @"GetZoneCodeTableViewCellIdentifier"
#define kDefaultExpireDate 15
@interface QHGetZoneCodeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (nonatomic, copy) __block NSArray<QHZoneCodeModel *>* zoneCodesArray;

@end

@implementation QHGetZoneCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = QHLocalizedString(@"选择区号", nil);
    
    [_theTableView setSeparatorInset:UIEdgeInsetsMake(0, 50, 0, 15)];
    _theTableView.separatorColor = UIColorFromRGB(0xEBECF0);
    _theTableView.tableFooterView = [UIView new];
    
    if([self loadZoneCode] == NO) {
        WeakSelf
        [QHZoneCodeModel getGlobalParamWithGroup:Group_PhoneCode lastUpdateDate:[NSString stringWithFormat:@"%lu",(unsigned long)[[NSDate date] toTimeIntervalSince1970]] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
            weakSelf.zoneCodesArray = [NSArray modelArrayWithClass:[QHZoneCodeModel class] json:[responseObject[@"data"] valueForKey:[QHLocalizable currentLocaleShort]]];
            
            [weakSelf cacheZoneCode];
            
            [weakSelf.theTableView reloadData];
        } failure:nil];
    }
    return ;
}

- (void)gotoBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)loadZoneCode {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"zoneCode_%@", [QHLocalizable currentLocaleShort]]];
    
    if([fileManager fileExistsAtPath:filePath] == YES) {
        NSDate* expireDate = (NSDate*)[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"expireDate_%@", [QHLocalizable currentLocaleShort]]];
        CGFloat expireTime = ABS([[NSDate date] timeIntervalSinceDate:expireDate]) / (24 * 60 * 60);
        if(expireTime <= kDefaultExpireDate) {
            self.zoneCodesArray = [NSArray modelArrayWithClass:[QHZoneCodeModel class] json:[NSArray arrayWithContentsOfFile:filePath]];
            return YES;
        }
        else
            [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

-(void)cacheZoneCode {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"zoneCode_%@", [QHLocalizable currentLocaleShort]]];
    if([fileManager fileExistsAtPath:filePath] == NO) {
        NSMutableArray *dictArr = [[NSMutableArray alloc] init];
        for (QHZoneCodeModel *model in self.zoneCodesArray) {
            NSDictionary *dict = [model modelToJSONObject];
            [dictArr addObject:dict];
        }

        [dictArr writeToFile:filePath atomically:YES];
        //过期时间
        [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:[NSString stringWithFormat:@"expireDate_%@", [QHLocalizable currentLocaleShort]]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _zoneCodesArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHZoneCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHZoneCodeCell reuseIdentifier]];
    if (!cell) {
        cell = [[QHZoneCodeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[QHZoneCodeCell reuseIdentifier]];
    }
    cell.model = _zoneCodesArray[indexPath.row];

    if (![[NSUserDefaults standardUserDefaults] valueForKey:kZonePhoneCodeValue]) {
        // 默认区号86
        if ([_zoneCodesArray[indexPath.row].code isEqualToString:@"86"]) {
            cell.isSelect = YES;
        } else {
            cell.isSelect = NO;
        }
    } else {
        if ([_zoneCodesArray[indexPath.row].value isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:kZonePhoneCodeValue]]) {
            cell.isSelect = YES;
        } else {
            cell.isSelect = NO;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kZoneCodeChangedNotification object:nil userInfo:@{@"zoneCode" : [_zoneCodesArray objectAtIndex:(int)indexPath.row].code}];
    [[NSUserDefaults standardUserDefaults] setValue:_zoneCodesArray[indexPath.row].value forKey:kZonePhoneCodeValue];
    [[NSUserDefaults standardUserDefaults] setValue:_zoneCodesArray[indexPath.row].code forKey:kZonePhoneCode];
    [self.theTableView reloadData];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    return ;
}

@end
