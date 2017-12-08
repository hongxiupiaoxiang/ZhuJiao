//
//  QHPepperTagViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPepperTagViewController.h"
#import "QHProductModel.h"
#import "QHPepperShopViewController.h"

@interface QHPepperTagViewController ()

@property (nonatomic, strong) NSMutableArray<QHProductModel *> *modelArr;

@end

@implementation QHPepperTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"标签", nil);
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    self.modelArr = [[NSMutableArray alloc] init];
    [QHProductModel querySignWithSuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *modelArr = [NSArray modelArrayWithClass:[QHProductModel class] json:responseObject[@"data"]];
        [self.modelArr addObjectsFromArray:modelArr];
        [self setupUI];
    } failureBlock:nil];
}

- (void)setupUI {
    UILabel *titleLabel = [UILabel labelWithFont:17 color:RGB52627C];
    titleLabel.text = QHLocalizedString(@"目前可用标签", nil);
    [self.view addSubview:titleLabel];
    
    UILabel *descriptionLabel = [UILabel labelWithFont:12 color:RGB939EAE];
    descriptionLabel.text = QHLocalizedString(@"点击\"更多\"可购买其他标签", nil);
    [self.view addSubview:descriptionLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(25);
        make.centerX.equalTo(self.view);
    }];
    
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(4);
        make.centerX.equalTo(self.view);
    }];
    
    NSArray *colorArr = @[UIColorFromRGB(0x46a0ee), UIColorFromRGB(0x59d7d2), UIColorFromRGB(0xff6189), UIColorFromRGB(0x44d989), UIColorFromRGB(0xafbacb)];
    
    for (NSInteger i = 0; i <= self.modelArr.count; i++) {
        
        CGFloat itemWidth = (SCREEN_WIDTH-60)/3.0;
        CGFloat itemHeight = 40;
        
        CGFloat topMargin = 100;
        
        
        CGRect frame = CGRectMake(15+(itemWidth+15)*(i%3), topMargin+55*(i/3), itemWidth, itemHeight);
        
        UIButton *signBtn = [[UIButton alloc] initWithFrame:frame];
        signBtn.layer.cornerRadius = 20;
        
        signBtn.backgroundColor = colorArr[i%5];
        [self.view addSubview:signBtn];
        
        if (i == self.modelArr.count) {
            [signBtn setTitle:QHLocalizedString(@"更多", nil) forState:(UIControlStateNormal)];
            signBtn.backgroundColor = UIColorFromRGB(0xafbacb);
            [signBtn addTarget:self action:@selector(moreClick) forControlEvents:(UIControlEventTouchUpInside)];
            break;
        }
        
        
        [signBtn setTitle:self.modelArr[i].name forState:(UIControlStateNormal)];
        
    }
    
}

- (void)moreClick {
    QHPepperShopViewController *shopVC = [[QHPepperShopViewController alloc] init];
    [self.navigationController pushViewController:shopVC animated:YES];
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
