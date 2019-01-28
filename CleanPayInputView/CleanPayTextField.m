//
//  CleanPayTextField.m
//  CleanPayInputView
//
//  Created by spring on 2019/1/19.
//  Copyright © 2019 spring. All rights reserved.
//

#import "CleanPayTextField.h"

@implementation CleanPayTextField


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.textAlignment = NSTextAlignmentCenter;
      
    }
    return self;
}
/// 实现删除方法
- (void)deleteBackward
{
    [super deleteBackward];
    
    BOOL conform = [self.xmDelegate conformsToProtocol:@protocol(XMTextFieldDelegate)];
    BOOL canResponse = [self.xmDelegate respondsToSelector:@selector(xmTextFeildDeleteBackward:)];
    if (self.xmDelegate && conform && canResponse) {
        [self.xmDelegate xmTextFeildDeleteBackward:self];
    }
}

- (void)setXmDelegate:(id<XMTextFieldDelegate>)xmDelegate
{
    _xmDelegate = xmDelegate;
    self.delegate = xmDelegate;
}


@end
