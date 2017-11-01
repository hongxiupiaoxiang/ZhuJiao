//
//  QHBaseViewController.m
//  RoleChat
//
//  Created by zfQiu on 2017/3/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseViewController.h"

@interface QHBaseViewController ()

@end

@implementation QHBaseViewController

- (instancetype)init
{
    NSString* nibFile = [[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"nib"];
    if(nibFile)
        self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    else
        self = [super init];
    
    if(self) {
        
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    return ;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    return ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = IMAGENAMED(@"back");
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(gotoBack)];
    return ;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    return ;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    return ;
}
-(void)addRightTitleItem:(NSString*)title sendBlock:(BaseVCBlock)sendBlock{
    self.baseVCBlock = sendBlock;
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-80, 24, 80, 40)];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = FONT(14);
    [rightBtn setTitle:QHLocalizedString(title, nil) forState:UIControlStateNormal];
    ButtonAddTarget(rightBtn, clicRightItem)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
-(void)clicRightItem{
    if (self.baseVCBlock) {
        self.baseVCBlock(nil);
    }
}
-(void)addLeftItem:(UIBarButtonItem *)barButtonItem complete:(void (^)(UIBarButtonItem *))complete{
    self.navigationItem.leftBarButtonItem = barButtonItem;
    [barButtonItem setActionBlock:complete];
}

-(void)addRightItem:(UIBarButtonItem *)barButtonItem complete:(void (^)(UIBarButtonItem *))complete{
    self.navigationItem.rightBarButtonItem = barButtonItem;
    [barButtonItem setActionBlock:complete];
}

-(void)addSubview:(UIView *)subview insets:(UIEdgeInsets)insets{
    [self.view addSubview:subview];
    
    [subview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}

-(void)keyBoardWillShowNotification:(NSNotification*)notification {
    if([self respondsToSelector:@selector(keyboardWillShow:)])
        [self keyboardWillShow:notification.userInfo];
    return ;
}

-(void)keyBoardWillHideNotification:(NSNotification*)notification {
    if([self respondsToSelector:@selector(keyboardWillHide:)])
        [self keyboardWillHide:notification.userInfo];
    return ;
}

#pragma mark -alert
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray *)actions complete:(void (^)(NSInteger))complete{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSString *actionTitle in actions) {
        NSInteger index = [actions indexOfObject:actionTitle];
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(complete){
                complete(index);
            }
        }];
        
        [alert addAction:action];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -actionSheet
-(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray *)actions complete:(void (^)(NSInteger))complete{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *actionTitle in actions) {
        NSInteger index = [actions indexOfObject:actionTitle];
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(complete){
                complete(index);
            }
        }];
        
        [alert addAction:action];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return ;
}

-(void)gotoBack {
    [self.navigationController popViewControllerAnimated:YES];
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShow:(NSDictionary *)keyboardFrameInfo {
    return ;
}

-(void)keyboardWillHide:(NSDictionary *)keyboardFrameInfo {
    return ;
}
-(NSMutableArray *)baseDataArray{
    if (!_baseDataArray) {
        _baseDataArray = [[NSMutableArray alloc] init];
    }
    return _baseDataArray;
}

@end
