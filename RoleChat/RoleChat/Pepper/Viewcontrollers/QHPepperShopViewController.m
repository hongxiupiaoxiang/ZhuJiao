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

@interface QHPepperShopViewController ()<ZJScrollPageViewDelegate, QHShopExtensionDelegate,QHShopCarDelegate>

@property (nonatomic, strong) NSMutableArray<QHProductModel *> *modelArrM;
@property (nonatomic, strong) QHShopExtensionsViewController *functionVC;
@property (nonatomic, strong) QHShopExtensionsViewController *signVC;
@property (nonatomic, strong) QHShopExtensionsViewController *imageVC;

@end

@implementation QHPepperShopViewController {
    NSArray *_titles;
    QHCarButton *_rightBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"Pepper商店", nil);
    
    self.modelArrM = [[NSMutableArray alloc] init];
    
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
    shopcarVC.delegate = self;
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
        self.functionVC = (QHShopExtensionsViewController *)reuseViewController;
        if (self.functionVC == nil) {
            self.functionVC = [[QHShopExtensionsViewController alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            self.functionVC.productType = Product_Expand;
        }
        self.functionVC.delegate = self;
        return self.functionVC;
    } else if (index == 1) {
        self.signVC = (QHShopExtensionsViewController *)reuseViewController;
        if (self.signVC == nil) {
            self.signVC = [[QHShopExtensionsViewController alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            self.signVC.productType = Product_Sign;
        }
        self.signVC.delegate = self;
        return self.signVC;
    } else {
        self.imageVC = (QHShopExtensionsViewController *)reuseViewController;
        if (self.imageVC == nil) {
            self.imageVC = [[QHShopExtensionsViewController alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            self.imageVC.productType = Product_Image;
        }
        self.imageVC.delegate = self;
        return self.imageVC;
    }
}


#pragma mark QHShopExtensionDelegate
- (void)addShopmodel:(QHProductModel *)model {
    [_rightBtn addShopCount];
    switch ([model.type integerValue]) {
        case 1:
            [self.functionVC startRefresh];
            break;
        case 2:
            [self.signVC startRefresh];
            break;
        case 3:
            [self.imageVC startRefresh];
        default:
            break;
    }
}

- (void)deleteShopmodel:(QHProductModel *)model {
    [_rightBtn decreaseCount];
    switch ([model.type integerValue]) {
        case 1:
            [self.functionVC startRefresh];
            break;
        case 2:
            [self.signVC startRefresh];
            break;
        case 3:
            [self.imageVC startRefresh];
        default:
            break;
    }
}

- (void)setShopcount:(NSInteger)productCount {
    [_rightBtn setShopCount:productCount];
}

#pragma mark QHShopCarDelegate
- (void)deleteCarShop {
    [_rightBtn setShopCount:0];
    [self.functionVC startRefresh];
    [self.signVC startRefresh];
    [self.imageVC startRefresh];
}

- (void)deleteProduct:(QHProductModel *)model {
    [_rightBtn decreaseCount];
    switch ([model.type integerValue]) {
        case 1:
            [self.functionVC startRefresh];
            break;
        case 2:
            [self.signVC startRefresh];
            break;
        case 3:
            [self.imageVC startRefresh];
        default:
            break;
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
