//
//  SRCInputView.h
//  CleanPayInputView
//
//  Created by spring on 2019/1/19.
//  Copyright © 2019 spring. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPInputView : UIView

@property(nonatomic,copy)NSString *srcValueText;

-(instancetype)initWithFrame:(CGRect)frame numbers:(NSInteger)numbers isUnderLine:(BOOL)underline;
-(instancetype)initMobileInputView:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
