//
//  TestViewController.m
//  XMPayCodeViewDemo
//
//  Created by sfk-ios on 2018/5/10.
//  Copyright © 2018年 aiq西米. All rights reserved.
//

#import "TestViewController.h"

#import "CPInputView.h"
@interface TestViewController ()

@end

@implementation TestViewController
-(void)mobile
{
    CPInputView *codeView = [[CPInputView alloc]initMobileInputView:CGRectMake(30, 180, self.view.frame.size.width-60, 50)];
    [self.view addSubview:codeView];
}
-(void)variableInputNumber
{
    CPInputView *codeView = [[CPInputView alloc]initWithFrame:CGRectMake(30, 180, self.view.frame.size.width - 60, 50) numbers:7 isUnderLine:false];
    [self.view addSubview:codeView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 30)];
    tipL.text = @"请输入支付密码";
    tipL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipL];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [back addTarget:self action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    back.frame = CGRectMake(100, 260, 100, 40);
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:back];
}

@end
