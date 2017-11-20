//
//  QHPepperShopViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPepperShopViewController.h"
#import "QHShopExtensionsViewController.h"
#import "QHCarButton.h"
#import "QHShopCarViewController.h"

@interface QHPepperShopViewController ()<ZJScrollPageViewDelegate>

@end

@implementation QHPepperShopViewController {
    NSArray *_titles;
    QHCarButton *_rightBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = QHLocalizedString(@"Pepper商店", nil);
    
    _rightBtn = [[QHCarButton alloc] init];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    [_rightBtn addTarget:self action:@selector(gotoShop:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addRightItem:rightItem complete:nil];
    
    _titles = @[QHLocalizedString(@"拓展功能", nil), QHLocalizedString(@"角色标签", nil), QHLocalizedString(@"AI形象", nil)];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)gotoShop: (QHCarButton *)sender {
    QHShopCarViewController *shopcarVC = [[QHShopCarViewController alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    [self.navigationController pushViewController:shopcarVC animated:YES];
}

- (void)setupUI {
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.showImage = YES;
    style.segmentHeight = 100;
    style.imagePosition = TitleImagePositionTop;
    style.autoAdjustTitlesWidth = YES;
    style.normalTitleColor = RGB939EAE;
    style.selectedTitleColor = UIColorFromRGB(0x29b3ff);
    style.scrollLineColor = UIColorFromRGB(0x29b3ff);
    style.scrollTitle = NO;
    
    
    ZJScrollPageView *pageView = [[ZJScrollPageView alloc] initWithFrame:self.view.frame segmentStyle:style titles:_titles parentViewController:self delegate:self];
    [self.view addSubview:pageView];
}

- (NSInteger)numberOfChildViewControllers {
    return _titles.count;
}

- (void)setUpTitleView:(ZJTitleView *)titleView forIndex:(NSInteger)index {
    NSString *imgName = [NSString stringWithFormat:@"Shop_%zd",index+1];
    titleView.normalImage = IMAGENAMED(imgName);
    titleView.selectedImage = IMAGENAMED(imgName);
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    if (index == 0) {
        QHShopExtensionsViewController *childVc = (QHShopExtensionsViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[QHShopExtensionsViewController alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            childVc.productType = Product_Expand;
        }
        return childVc;
        
    } else if (index == 1) {
        QHShopExtensionsViewController *childVc = (QHShopExtensionsViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[QHShopExtensionsViewController alloc] init];
            childVc.productType = Product_Sign;
        }
        
        return childVc;
    } else {
        QHShopExtensionsViewController *childVc = (QHShopExtensionsViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[QHShopExtensionsViewController alloc] init];
            childVc.productType = Product_Image;
        }
        return childVc;
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
