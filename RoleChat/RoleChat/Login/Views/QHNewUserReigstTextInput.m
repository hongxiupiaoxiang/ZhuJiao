//
//  QHNewUserReigstTextInput.m
//  ShareMedianet
//
//  Created by 王落凡 on 2017/9/8.
//  Copyright © 2017年 qhsj. All rights reserved.
//

#import "QHNewUserReigstTextInput.h"

@interface QHNewUserReigstTextInput () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *hintSepLine;
@property (weak, nonatomic) IBOutlet UILabel *hintTextLabel;

@end

@implementation QHNewUserReigstTextInput

-(void)setValidModeWithHintText:(NSString *)hintText {
//    _hintSepLine.backgroundColor = UIColorFromRGB(0x47C45C);
    _hintTextLabel.textColor = UIColorFromRGB(0x47C45C);
    _hintTextLabel.text = hintText;
    
    _bDataValid = YES;
    
    [self addColorlayer];
    return ;
}

-(void)setInvalidModeWithHintText:(NSString *)hintText {
//    _hintSepLine.backgroundColor = UIColorFromRGB(0xE62739);
    _hintTextLabel.textColor = UIColorFromRGB(0xE62739);
    _hintTextLabel.text = hintText;
    [self addColorlayer];
    
    _bDataValid = NO;
    return ;
}

-(void)addColorlayer {
    if (_hintSepLine.layer.sublayers.count > 1) {
        return;
    }
    CAGradientLayer *lineLayer = [CAGradientLayer layer];
    lineLayer.colors = @[(__bridge id)UIColorFromRGB(0xff4f95).CGColor, (__bridge id)UIColorFromRGB(0x18d0f0).CGColor];
    lineLayer.startPoint = CGPointMake(0, 0.5);
    lineLayer.endPoint = CGPointMake(1, 0.5);
    lineLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 1.0f / SCREEN_SCALE);
    [_hintSepLine.layer addSublayer:lineLayer];
}

- (void)removeColorLayer {
    _hintTextLabel.text = @"";
    [_hintSepLine.layer removeAllSublayers];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(textField.returnKeyType == UIReturnKeyNext) {
        if([self.delegate respondsToSelector:@selector(textInput:returnKeyPressedAtIndex:)])
            [self.delegate textInput:self returnKeyPressedAtIndex:_theIndex];
    }
    return YES;
}

- (IBAction)textChanged:(UITextField *)sender {
    if(sender.text.length == 0) {
        _hintSepLine.backgroundColor = UIColorFromRGB(0xE1E2E6);
        _hintTextLabel.text = @"";
        _bDataValid = NO;
        [_hintSepLine.layer removeAllSublayers];
        if ([self.delegate respondsToSelector:@selector(checkDataValid)]) {
            [self.delegate checkDataValid];
        }
        return ;
    }
    if([self.delegate respondsToSelector:@selector(textInput:isValidDataWithTextWhenChanged:)])
        [self.delegate textInput:self isValidDataWithTextWhenChanged:sender.text];
    
    if ([self.delegate respondsToSelector:@selector(checkDataValid)]) {
        [self.delegate checkDataValid];
    }
    
    return ;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textInput:isValidDataWithTextWhenEndEditting:)] && textField.text.length != 0)
        [self.delegate textInput:self isValidDataWithTextWhenEndEditting:textField.text];
    return ;
}

@end
