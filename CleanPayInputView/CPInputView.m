//
//  SRCInputView.m
//  CleanPayInputView
//
//  Created by spring on 2019/1/19.
//  Copyright © 2019 spring. All rights reserved.
//

#import "CPInputView.h"
#import "OutsideBorderTextField.h"
#import "UnderlineTextField.h"
#define Tag_Start_Index 100
@interface CPInputView()<XMTextFieldDelegate,UITextFieldDelegate>
@property(nonatomic,assign)NSInteger number_tf;
@property(nonatomic,strong)CleanPayTextField *holdOnTextField;
//@property(nonatomic,assign)BOOL isMobile;
@end
@implementation CPInputView

-(instancetype)initWithFrame:(CGRect)frame numbers:(NSInteger)numbers isUnderLine:(BOOL)underline
{
    self = [super initWithFrame:frame];
    if(self)
    {
    _number_tf = numbers;
    
    [self createUI:underline];
    [self addCoverButton];
    }
    return self;
}
-(instancetype)initMobileInputView:(CGRect)frame
{
 
    self = [super initWithFrame:frame];
    if(self)
    {
        _number_tf = 10;
//        _isMobile = true;
        [self setUpMobileView];
        [self addCoverButton];
    }
    return self;
    
}
//初始化UI
//根据输入框的个数，平均分布 宽度
-(void)createUI:(BOOL)isUnderline
{
    CGFloat space = 10;
    CGFloat itemWidth = (CGRectGetWidth(self.frame) - (_number_tf - 1)*space)/_number_tf;
    CGFloat itemHeight = CGRectGetHeight(self.frame);
    
    for (int i= 0; i<_number_tf+1; i++) {
        NSString *className ;
        if (isUnderline)
        {
            className = @"UnderlineTextField";
            
        }else{
            className = @"OutsideBorderTextField";
        }
        
        CleanPayTextField * subTextField = [[NSClassFromString(className) alloc]initWithFrame:CGRectMake((itemWidth+space)*i, 0, itemWidth, itemHeight)];
        subTextField.tag = Tag_Start_Index+i;
    
        subTextField.xmDelegate = self;
        [subTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
          [self addSubview:subTextField];
        if(i==_number_tf)
        {
          
            subTextField.frame = CGRectZero;
            _holdOnTextField = subTextField;
            
        }
    }
    

}

-(void)setUpMobileView
{
    
    CGFloat space = 10;

    
    CGFloat itemWidth = ((CGRectGetWidth(self.frame) - (_number_tf - 3)*space) -(space*2 + space*2)) /_number_tf;
    CGFloat itemHeight = CGRectGetHeight(self.frame)-15;
    
    for (int i= 0; i<_number_tf+1; i++) {
        CGFloat originalX ;
        if(i<3)
        {
            originalX = i*(itemWidth+space)+space;
            
        }else {
            originalX = i*(itemWidth+space)+space*2;
        }
        
        UnderlineTextField * subTextField = [[UnderlineTextField alloc]initWithFrame:CGRectMake(originalX, 0, itemWidth, itemHeight)];
        subTextField.tag = Tag_Start_Index+i;
        
        subTextField.xmDelegate = self;
        [subTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:subTextField];
        if(i==_number_tf)
        {
            
            subTextField.frame = CGRectZero;
            _holdOnTextField = subTextField;
            
        }
//        [subTextField setBackgroundColor:[UIColor redColor]];
    }
    [self drawSpaceSymbols:itemWidth space:space height:itemHeight];
    
}

-(void)drawSpaceSymbols:(CGFloat)itemWidth space:(CGFloat)space height:(CGFloat)itemHeight
{
    UILabel *label_leftBracket = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, space, itemHeight)];
    [label_leftBracket setText:@"("];
//    [label_leftBracket setBackgroundColor:[UIColor greenColor]];
    [self addSubview:label_leftBracket];
    UILabel *label_rightBracket =  [[UILabel alloc]initWithFrame:CGRectMake(3*(itemWidth+space), 0, space, itemHeight)];
    [label_rightBracket setText:@")"];
    [self addSubview:label_rightBracket];
//    [label_rightBracket setBackgroundColor:[UIColor greenColor]];
    UILabel *label_line =  [[UILabel alloc]initWithFrame:CGRectMake((itemWidth+space)*3+space, 0, space, itemHeight)];
    [label_line setText:@"-"];
    [self addSubview:label_line];
//    [label_line setBackgroundColor:[UIColor greenColor]];
    
    UILabel *label_line2 =  [[UILabel alloc]initWithFrame:CGRectMake((itemWidth+space)*6+space, 0, space, itemHeight)];
    [label_line2 setText:@"-"];
    [self addSubview:label_line2];
//    [label_line2 setBackgroundColor:[UIColor greenColor]];
    
    
}
-(void)addCoverButton
{
    UIButton * coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    coverButton.frame = self.bounds;
    [self addSubview:coverButton];
    [coverButton addTarget:self action:@selector(tapOnThisView) forControlEvents:UIControlEventTouchUpInside];
}
-(void)tapOnThisView
{
    NSInteger number = self.srcValueText.length;
    
    if (number <= _number_tf) {
        [[self viewWithTag:(Tag_Start_Index+number)]becomeFirstResponder];
    }else{
        _holdOnTextField.text = nil;
        [_holdOnTextField becomeFirstResponder];
    }
}

-(void)showKeyBoardOnFirstItem
{
    [self setFirstResponder:Tag_Start_Index];
}
//每当输入框内容发生改变 总会触发此方法。
//对SRCValueText重新赋值
//响应者跳转到下一个输入框
//跳转到最后一个并且文字发生改变后，键盘回收
-(void)textFieldDidChange:(OutsideBorderTextField *)textField
{
    [self collectSubText];
    if(textField.text.length == 1 && ![textField.text isEqualToString:@" "])
    {
    OutsideBorderTextField * nextTextField = [self viewWithTag: (textField.tag + 1)];
    if ([nextTextField isEqual:_holdOnTextField])
    {
        [textField resignFirstResponder];
        //输入的字符个数达到的最大值，这里可以添加block方法执行回执方法。
    }else{
     [nextTextField becomeFirstResponder];
    }
    }else{
        textField.text = nil;
    }
    
}
-(void)collectSubText{
    NSString * collectText = [(OutsideBorderTextField *)[self viewWithTag:Tag_Start_Index] text];
    for (int i=1;i<_number_tf;i++)
    {
        collectText = [collectText stringByAppendingString:[(OutsideBorderTextField *)[self viewWithTag:Tag_Start_Index+i] text]];
    }
    _srcValueText = collectText;
    NSLog(@"SRC:%@",_srcValueText);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual: _holdOnTextField])
    {
        return NO;
    }
    if(string.length > 1)
    {
        textField.text = nil;
        return NO;
    }
    return YES;
}
//XMTextFieldDelegate
-(void)xmTextFeildDeleteBackward:(UITextField *)textField{
    if(textField.text.length == 0)
    {
        NSUInteger preTag = textField.tag - 1;
      
         if (preTag != (Tag_Start_Index - 1))
        {
            textField.text = nil;
            [(UITextField *)[self viewWithTag:preTag] setText:nil];
            [self setFirstResponder:preTag];
        }
    }
    [self collectSubText];
}
-(void)setFirstResponder:(NSInteger)tag
{
    [[self viewWithTag:tag]becomeFirstResponder];
    
}
@end
