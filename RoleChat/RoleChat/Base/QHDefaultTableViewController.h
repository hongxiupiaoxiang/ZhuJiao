//
//  QHDefaultTableViewController.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/20.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseViewController.h"

@interface QHDefaultTableViewController : QHBaseViewController <UITableViewDelegate, UITableViewDataSource>

@end

@interface QHDefaultTableViewController ()

-(UITableView*)tableView;
-(void)addPullToRefreshWithBlock:(QHNoParamCallback)block;
-(void)addLoadMoreWithBlock:(QHNoParamCallback)block;
-(void)startRefresh;
-(void)stopRefresh;

-(instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle;

@end
