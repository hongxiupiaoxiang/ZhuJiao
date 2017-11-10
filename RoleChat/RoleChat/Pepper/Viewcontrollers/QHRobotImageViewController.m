//
//  QHRobotImageViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRobotImageViewController.h"
#import "QHChooseRobotImgView.h"

#define IMGVIEW_TAG 666

@interface QHRobotImageViewController ()

@property (nonatomic, copy) NSString *selectStr;

@end

@implementation QHRobotImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"机器人形象", nil);
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:QHLocalizedString(@"保存", nil) forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    rightBtn.titleLabel.font = FONT(14);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    NSArray *titleArr = @[QHLocalizedString(@"Contana", nil), QHLocalizedString(@"Pepper", nil), QHLocalizedString(@"Mantis Shrimp", nil), QHLocalizedString(@"Narwhal", nil), QHLocalizedString(@"Dragon", nil), QHLocalizedString(@"Ghost", nil)];
    NSArray *picArr = @[@"Robot_contana", @"Robot_pepper", @"Robot_mantis", @"Robot_narwhal", @"Robot_dragon", @"Robot_ghost"];
    
    UILabel *titleLabel = [UILabel labelWithFont:20 color:RGB939EAE];
    titleLabel.text = QHLocalizedString(@"请选择形象", nil);
    [self.view addSubview:titleLabel];
    [titleLabel sizeToFit];
    CGRect frame = titleLabel.frame;
    frame.origin.x = 15;
    frame.origin.y = 30;
    titleLabel.frame = frame;
    
    WeakSelf
    for (NSInteger i = 0; i < 6; i++) {
        QHChooseRobotImgView *robotImgView = [[QHChooseRobotImgView alloc] initWithImgStr:picArr[i] title:titleArr[i] imageCallback:^(id params) {
            NSLog(@"haha");
            if (weakSelf.selectStr.length) {
                NSInteger selectIndex = [titleArr indexOfObject:weakSelf.selectStr];
                QHChooseRobotImgView *selectedView = [weakSelf.view viewWithTag:IMGVIEW_TAG+selectIndex];
                selectedView.isSelectImage = NO;
            }
            self.selectStr = params;
        }];
        
        CGRect frame = robotImgView.frame;
        frame.origin.x = i%3*SCREEN_WIDTH/3.0;
        frame.origin.y = i/3*140+80;
        robotImgView.frame = frame;
        
        robotImgView.tag = IMGVIEW_TAG+i;
        [self.view addSubview:robotImgView];
        
        //
        if (i == 0) {
            robotImgView.isCurrentImage = YES;
        }
    }
}

- (void)save {
    NSLog(@"haha");
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
