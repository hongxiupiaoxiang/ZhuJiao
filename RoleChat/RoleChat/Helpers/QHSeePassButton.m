//
//  QHSeePassButton.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/8.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHSeePassButton.h"

@interface QHSeePassButton ()

@property(nonatomic, weak) UITextField* accessoryTextField;

@end

@implementation QHSeePassButton

+(instancetype)newInstanceWithAccessoryTextField:(UITextField *)textField {
    QHSeePassButton* seePassBtn = [QHSeePassButton buttonWithType:UIButtonTypeCustom];
    seePassBtn.accessoryTextField = textField;
    [seePassBtn setBackgroundImage:[UIImage imageNamed:@"hidden"] forState:UIControlStateNormal];
    [seePassBtn setBackgroundImage:[UIImage imageNamed:@"show"] forState:UIControlStateSelected];
    [seePassBtn addTarget:seePassBtn action:@selector(BtnSelected) forControlEvents:UIControlEventTouchUpInside];
    [seePassBtn sizeToFit];
    return seePassBtn;
}

-(void)BtnSelected {
    self.selected = !self.isSelected;
    self.accessoryTextField.secureTextEntry = !self.selected;
    
    return ;
}

@end
