//
//  QHDetailOrderViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDetailOrderViewController.h"
#import "QHBaseSubTitleCell.h"
#import "QHNoArrowBaseViewCell.h"

@interface QHDetailOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray<QHOrderDetailModel *> *detailModelArr;

@end

@implementation QHDetailOrderViewController {
    UITableView *_mainView;
    NSArray *_shopImg;
    NSArray *_shopTitle;
    NSArray *_shopContent;
    NSArray *_shopText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"订单详情", nil);
    
    self.detailModelArr = [NSArray modelArrayWithClass:[QHOrderDetailModel class] json:self.orderModel.orderDetails];
    
    _shopImg = @[@"Shop_audio", @"Shop_draw", @"Shop_audio"];
    _shopTitle = @[QHLocalizedString(@"音频处理", nil), QHLocalizedString(@"绘画功能", nil), QHLocalizedString(@"音频处理", nil)];
    _shopContent = @[QHLocalizedString(@"订单状态", nil), QHLocalizedString(@"支付方式", nil) ,QHLocalizedString(@"订单编号", nil) ,QHLocalizedString(@"创建时间", nil)];
    _shopText = @[@"已完成", @"微信支付", @"10000000", @"2017/11/11 10:31"];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height-114) style:(UITableViewStyleGrouped)];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [self.view addSubview:_mainView];
    _mainView.backgroundColor = WhiteColor;
    [_mainView registerClass:[QHBaseSubTitleCell class] forCellReuseIdentifier:[QHBaseSubTitleCell reuseIdentifier]];
    [_mainView registerClass:[QHNoArrowBaseViewCell class] forCellReuseIdentifier:[QHNoArrowBaseViewCell reuseIdentifier]];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([self.orderModel.status isEqualToString:@"1"]) {
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-114, SCREEN_WIDTH*0.5, 50)];
        cancelBtn.backgroundColor = UIColorFromRGB(0xc5c7d1);
        [self.view addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(orderCanceled) forControlEvents:(UIControlEventTouchUpInside)];
        [cancelBtn setTitle:QHLocalizedString(@"取消", nil) forState:(UIControlStateNormal)];
        cancelBtn.titleLabel.font = FONT(16);
        
        UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT-114, SCREEN_WIDTH*0.5, 50)];
        payBtn.backgroundColor = MainColor;
        [self.view addSubview:payBtn];
        [payBtn addTarget:self action:@selector(payOrder) forControlEvents:(UIControlEventTouchUpInside)];
        [payBtn setTitle:QHLocalizedString(@"支付订单", nil) forState:(UIControlStateNormal)];
        payBtn.titleLabel.font = FONT(16);
    }
}

- (void)orderCanceled {
    UIAlertController *cancelAlert = [UIAlertController alertControllerWithTitle:QHLocalizedString(@"取消支付", nil) message:QHLocalizedString(@"确认取消支付?", nil) preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"确认", nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消支付成功");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"退出", nil) style:(UIAlertActionStyleCancel) handler:nil];

    [cancelAlert addAction:sureAction];
    [cancelAlert addAction:cancelAction];
    
    [self presentViewController:cancelAlert animated:YES completion:nil];
}

- (void)payOrder {
    NSLog(@"支付跳转");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 70 : 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 110 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.detailModelArr.count : [self.orderModel.status isEqualToString:@"3"] ? 4 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseSubTitleCell reuseIdentifier]];
        ((QHBaseSubTitleCell *)cell).leftView.image = IMAGENAMED(_shopImg[indexPath.row]);
        
        ((QHBaseSubTitleCell *)cell).titleLabel.text = self.detailModelArr[indexPath.row].productname;
        ((QHBaseSubTitleCell *)cell).detailLabel.text = [NSString stringWithFormat:@"$%.2f",[self.detailModelArr[indexPath.row].producttotal floatValue]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHNoArrowBaseViewCell reuseIdentifier]];
        if (indexPath.row == 0) {
            NSString *status;
            ((QHNoArrowBaseViewCell *)cell).titleLabel.text = _shopContent[indexPath.row];
            if ([self.orderModel.status isEqualToString:@"1"]) {
                status = QHLocalizedString(@"待支付", nil);
                NSMutableAttributedString *text = [NSMutableAttributedString getAttr:status color:MainColor targetStr:status];
                ((QHNoArrowBaseViewCell *)cell).detailLabel.attributedText = text;
            } else if ([self.orderModel.status isEqualToString:@"2"]) {
                ((QHNoArrowBaseViewCell *)cell).detailLabel.text = QHLocalizedString(@"已完成", nil);
            } else if ([self.orderModel.status isEqualToString:@"3"]) {
                ((QHNoArrowBaseViewCell *)cell).detailLabel.text = QHLocalizedString(@"已取消", nil);
            }
        } else if (indexPath.row == 1) {
            ((QHNoArrowBaseViewCell *)cell).titleLabel.text = [self.orderModel.status isEqualToString:@"2"] ?  _shopContent[indexPath.row] : _shopContent[indexPath.row+1];
            ((QHNoArrowBaseViewCell *)cell).detailLabel.text = [self.orderModel.status isEqualToString:@"2"] ? @"微信支付" : self.orderModel.orderId;
        } else if (indexPath.row == 2) {
            ((QHNoArrowBaseViewCell *)cell).titleLabel.text = [self.orderModel.status isEqualToString:@"2"] ?  _shopContent[indexPath.row] : _shopContent[indexPath.row+1];
            ((QHNoArrowBaseViewCell *)cell).detailLabel.text = [self.orderModel.status isEqualToString:@"2"] ? self.orderModel.orderId : [NSString timechange:self.orderModel.createAt withFormat:@"yyyy/MM/dd HH:mm"];
        } else if (indexPath.row == 3) {
            ((QHNoArrowBaseViewCell *)cell).titleLabel.text = [self.orderModel.status isEqualToString:@"2"] ?  _shopContent[indexPath.row] : _shopContent[indexPath.row+1];
            ((QHNoArrowBaseViewCell *)cell).detailLabel.text = [NSString timechange:self.orderModel.createAt withFormat:@"yyyy/MM/dd HH:mm"];
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView;
    if (section == 0) {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        bgView.backgroundColor = WhiteColor;
        [[QHTools toolsDefault] addLineView:bgView :CGRectMake(0, 100, SCREEN_WIDTH, 10)];
        
        UILabel *titleLabel = [UILabel labelWithColor:RGB52627C];
        [bgView addSubview:titleLabel];
        titleLabel.text = QHLocalizedString(@"订单总价", nil);
        
        UILabel *priceLabel = [UILabel labelWithFont:20 color:RGB52627C];
        [bgView addSubview:priceLabel];
        NSString *str = [NSString stringWithFormat:@"$ %.2f",[self.orderModel.orderAmount floatValue]];
        NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:str];
        [attrM addAttribute:NSForegroundColorAttributeName value:MainColor range:[str rangeOfString:@"$"]];
        priceLabel.attributedText = attrM;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).mas_offset(25);
            make.left.equalTo(bgView).mas_offset(15);
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).mas_offset(10);
            make.left.equalTo(bgView).mas_offset(15);
        }];
    } else {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        bgView.backgroundColor = RGBF5F6FA;
    }
    return bgView;
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
