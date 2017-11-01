//
//  QHNewUserReigstTextInput.h
//  ShareMedianet
//
//  Created by 王落凡 on 2017/9/8.
//  Copyright © 2017年 qhsj. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AttributedPlaceHolder(string) [[NSAttributedString alloc] initWithString:QHLocalizedString(string, nil) attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xC8C9CC)}]

@class QHNewUserReigstTextInput;
@protocol QHNewUserRegistTextInputDelegate <NSObject>

@optional
-(void)textInput:(QHNewUserReigstTextInput*)textInput returnKeyPressedAtIndex:(NSInteger)index;
-(void)textInput:(QHNewUserReigstTextInput*)textInput isValidDataWithTextWhenChanged:(NSString*)text;
-(void)textInput:(QHNewUserReigstTextInput*)textInput isValidDataWithTextWhenEndEditting:(NSString*)text;
-(void)checkDataValid;

@end

@interface QHNewUserReigstTextInput : UIView

@property(nonatomic, assign) id<QHNewUserRegistTextInputDelegate> delegate;
@property(nonatomic, assign) NSInteger theIndex;
@property(nonatomic, assign, readonly) BOOL bDataValid;
@property (weak, nonatomic) IBOutlet UITextField *inputTextInput;

-(void)setValidModeWithHintText:(NSString*)hintText;
-(void)setInvalidModeWithHintText:(NSString*)hintText;
-(void)removeColorLayer;

@end
