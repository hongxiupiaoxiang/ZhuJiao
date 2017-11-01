//
//  QHTableViewCell.m
//  RoleChat
//
//  Created by zfQiu on 2017/3/9.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseTableViewCell.h"

@implementation QHBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self setupCellUI];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self setupCellUI];
    }
    return self;
}
-(void)setupCellUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
