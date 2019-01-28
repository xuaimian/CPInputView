//
//  OutsideBorderTextField.m
//  CleanPayInputView
//
//  Created by spring on 2019/1/19.
//  Copyright © 2019 spring. All rights reserved.
//

#import "OutsideBorderTextField.h"

@implementation OutsideBorderTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    return  self;
}

@end
