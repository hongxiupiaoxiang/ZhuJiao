//
//  QHLanguageSettingViewCtrl.m
//
//  Created by zfQiu on 17/10/23.
//
//

#import "QHLocalizable.h"
#import "QHLanguageSettingViewCtrl.h"
#import "QHLanguageSettingTableViewCell.h"

#define LanguageSettingTableViewCellIdentifier @"LanguageSettingTableViewCellIdentifier"

@interface QHLanguageSettingViewCtrl () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, assign) NSUInteger selectedItemIndex;

@end

@implementation QHLanguageSettingViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRight];
    
    _tableView =[[UITableView alloc]init];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15.0f, 0, 15.0f);
    _tableView.tableFooterView =[[UIView alloc]init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [_tableView registerNib:[UINib nibWithNibName:@"QHLanguageSettingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:LanguageSettingTableViewCellIdentifier];
  
    _selectedItemIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:kUserLanguageKey] unsignedIntegerValue];
    
    return ;
}

-(void)setRight{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:QHLocalizedString(@"保存", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    [rightItem setTitleTextAttributes:@{NSFontAttributeName : FONT(14.0f) ,NSForegroundColorAttributeName : MainColor} forState:UIControlStateNormal];
    __weak typeof(self) weakself =self;
    [self addRightItem:rightItem complete:^(UIBarButtonItem *item) {
        
        __strong typeof(weakself) strongself = weakself;
        [strongself rightClick:nil];

    }];
}
#pragma mark tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [QHLocalizable localeInfoDict].allKeys.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QHLanguageSettingTableViewCell *cell = (QHLanguageSettingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:LanguageSettingTableViewCellIdentifier];
    NSString* lang = (NSString*)[[[QHLocalizable localeInfoDict] valueForKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]] valueForKey:@"description"];
    cell.titleTextLabel.text = QHLocalizedString(lang, nil);
    
    if(indexPath.row == _selectedItemIndex)
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedItemIndex = (NSUInteger)indexPath.row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (void)rightClick:(UIButton *)btn{
    
    [[NSUserDefaults standardUserDefaults] setInteger:_selectedItemIndex forKey:kUserLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHAGE_NOTI object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
