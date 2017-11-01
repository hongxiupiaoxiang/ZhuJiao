//
//  QHDefaultTableViewController.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/20.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHDefaultTableViewController.h"

@interface QHDefaultTableViewController ()

@property(nonatomic, strong) UITableView* theTableView;
@property(nonatomic, assign) UITableViewStyle tableViewStyle;

@end

@implementation QHDefaultTableViewController

-(instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle {
    self = [super init];
    
    if(self) {
        _tableViewStyle = tableViewStyle;
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if(self) {
        _tableViewStyle = UITableViewStyleGrouped;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _theTableView = [[UITableView alloc] initWithFrame:CGRectZero style:_tableViewStyle];
    _theTableView.separatorInset = UIEdgeInsetsMake(0, 15.0f, 0, 15.0f);
    _theTableView.delegate = self;
    _theTableView.dataSource = self;
    _theTableView.estimatedSectionFooterHeight = 0;
    _theTableView.estimatedSectionHeaderHeight = 0;
    _theTableView.estimatedRowHeight = 0;
    
    [self.view addSubview:_theTableView];
    [_theTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.top.and.bottom.mas_equalTo(self.view);
    }];
    
    return ;
}

-(void)addPullToRefreshWithBlock:(QHNoParamCallback)block {
    if(_theTableView.mj_header == nil)
        _theTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    return ;
}

-(void)addLoadMoreWithBlock:(QHNoParamCallback)block {
    if(_theTableView.mj_footer == nil)
        _theTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    return ;
}

-(void)startRefresh {
    if(_theTableView.mj_header != nil)
        [_theTableView.mj_header beginRefreshing];
    return ;
}

-(void)stopRefresh {
    if(_theTableView.mj_header != nil)
        [_theTableView.mj_header endRefreshing];
    if(_theTableView.mj_footer != nil)
        [_theTableView.mj_footer endRefreshing];
    return ;
}

-(UITableView *)tableView {
    return _theTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
