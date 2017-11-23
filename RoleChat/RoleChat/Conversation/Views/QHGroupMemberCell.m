//
//  QHGroupMemberCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/23.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHGroupMemberCell.h"

static NSString *reuseId = @"reuseId";

@class QHMemberCollectionCell;

@interface QHMemberCollectionCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imgurl;

@end

@implementation QHMemberCollectionCell {
    UIImageView *_headView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _headView = [[UIImageView alloc] init];
    _headView.image = ICON_IMAGE;
    [self.contentView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_headView cornerRedii:3];
    });
}

@end

@interface QHGroupMemberCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *memberView;

@end

@implementation QHGroupMemberCell {
    BOOL _isShowAll;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(40, 40);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = (SCREEN_WIDTH-250)/4.0;
    self.memberView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.memberView.backgroundColor = WhiteColor;
    [self.contentView addSubview:self.memberView];
    self.memberView.showsVerticalScrollIndicator = NO;
    self.memberView.showsHorizontalScrollIndicator = NO;
    self.memberView.delegate = self;
    self.memberView.dataSource = self;
    [self.memberView registerClass:[QHMemberCollectionCell class] forCellWithReuseIdentifier:reuseId];
    
    UIButton *showAllBtn = [[UIButton alloc] init];
    [showAllBtn setTitle:QHLocalizedString(@"查看所有群成员", nil) forState:(UIControlStateNormal)];
    [showAllBtn setTitle:QHLocalizedString(@"收起", nil) forState:(UIControlStateSelected)];
    [showAllBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    showAllBtn.backgroundColor = WhiteColor;
    showAllBtn.titleLabel.font = FONT(16);
    [self.contentView addSubview:showAllBtn];
    [showAllBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [showAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(50);
    }];
    
    UIView *bottomView = [[QHTools toolsDefault] addLineView:self.contentView :CGRectZero];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).mas_offset(-51);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
    
    [self.memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).mas_offset(25);
        make.right.equalTo(self.contentView).mas_offset(-25);
        make.bottom.equalTo(bottomView.mas_top);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _isShowAll ? 20 : 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QHRealmContactModel *model = [[QHRealmContactModel alloc] init];
    model.imgurl = @"haha";
    if ([self.delegate respondsToSelector:@selector(tapHeadInView:userModel:)]) {
        [self.delegate tapHeadInView:[collectionView cellForItemAtIndexPath:indexPath] userModel:model];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QHMemberCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    // testmodel
    return cell;
}

- (void)btnClick: (UIButton *)sender {
    sender.selected = !sender.isSelected;
    _isShowAll = sender.selected;
    if ([self.delegate respondsToSelector:@selector(showAllMember:)]) {
        [self.delegate showAllMember:sender.selected];
    }
    [self.memberView reloadData];
}

+ (NSString *)reuseIdentifier {
    return @"QHGroupMemberCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
