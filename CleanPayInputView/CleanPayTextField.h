//
//  CleanPayTextField.h
//  CleanPayInputView
//
//  Created by spring on 2019/1/19.
//  Copyright © 2019 spring. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol XMTextFieldDelegate<UITextFieldDelegate>

@optional
- (void)xmTextFeildDeleteBackward:(UITextField *)textField;
@end

@interface CleanPayTextField : UITextField<UITextFieldDelegate>

@property (nonatomic, weak) id <XMTextFieldDelegate> xmDelegate;
@end

NS_ASSUME_NONNULL_END
