//
//  QHRobotImageViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRobotImageViewController.h"
#import "QHChooseRobotImgView.h"
#import "QHRobotAIModel.h"

#define IMGVIEW_TAG 666

@interface QHRobotImageViewController ()

@property (nonatomic, strong) NSMutableArray<QHRobotAIModel *> *modelArr;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation QHRobotImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"机器人形象", nil);
    
    self.modelArr = [[NSMutableArray alloc] init];
    self.selectIndex = -1;
    
    WeakSelf
    [self addRightTitleItem:QHLocalizedString(@"设置", nil) color:MainColor sendBlock:^(id prama) {
        [weakSelf save];
    }];
    
    UILabel *titleLabel = [UILabel labelWithFont:20 color:RGB939EAE];
    titleLabel.text = QHLocalizedString(@"请选择形象", nil);
    [self.view addSubview:titleLabel];
    [titleLabel sizeToFit];
    CGRect frame = titleLabel.frame;
    frame.origin.x = 15;
    frame.origin.y = 30;
    titleLabel.frame = frame;
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    [QHRobotAIModel queryPepperImageWithSuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *models = [NSArray modelArrayWithClass:[QHRobotAIModel class] json:responseObject[@"data"]];
        [self.modelArr addObjectsFromArray:models];
        [self setupUI];
    } failureBlock:nil];
}

- (void)setupUI {
//    NSArray *titleArr = @[QHLocalizedString(@"Contana", nil), QHLocalizedString(@"Pepper", nil), QHLocalizedString(@"Mantis Shrimp", nil), QHLocalizedString(@"Narwhal", nil), QHLocalizedString(@"Dragon", nil), QHLocalizedString(@"Ghost", nil)];
//    NSArray *picArr = @[@"Robot_contana", @"Robot_pepper", @"Robot_mantis", @"Robot_narwhal", @"Robot_dragon", @"Robot_ghost"];
    
    WeakSelf
    for (NSInteger i = 0; i < self.modelArr.count; i++) {
        QHChooseRobotImgView *robotImgView = [[QHChooseRobotImgView alloc] initWithImgStr:self.modelArr[i].url title:self.modelArr[i].name imageCallback:^(id params) {
            if (weakSelf.selectIndex == i) {
                QHChooseRobotImgView *selectedView = [weakSelf.view viewWithTag:IMGVIEW_TAG+i];
                selectedView.isSelectImage = !selectedView.isSelectImage;
                weakSelf.selectIndex = -1;
            } else {
                if (weakSelf.selectIndex >= 0) {
                    QHChooseRobotImgView *selectedView = [weakSelf.view viewWithTag:IMGVIEW_TAG+weakSelf.selectIndex];
                    selectedView.isSelectImage = !selectedView.isSelectImage;
                }
                weakSelf.selectIndex = i;
            }
        }];
        
        CGRect frame = robotImgView.frame;
        frame.origin.x = i%3*SCREEN_WIDTH/3.0;
        frame.origin.y = i/3*140+80;
        robotImgView.frame = frame;
        
        robotImgView.tag = IMGVIEW_TAG+i;
        [self.view addSubview:robotImgView];
        
        if ([self.modelArr[i].name isEqualToString:self.image]) {
            robotImgView.isCurrentImage = YES;
        }
    }
}

- (void)save {
    if (self.selectIndex > 0) {
        [QHRobotAIModel updatePepperSetWithPepperimageid:self.modelArr[self.selectIndex].robotId successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            [self showHUDOnlyTitle:QHLocalizedString(@"保存成功", nil)];
            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGEPEPPERIMAGENAME_NOTI object:nil userInfo:@{@"name" : self.modelArr[self.selectIndex].name}];
            PerformOnMainThreadDelay(1.5, [self.navigationController popViewControllerAnimated:YES];);
        } failureBlock:nil];
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
