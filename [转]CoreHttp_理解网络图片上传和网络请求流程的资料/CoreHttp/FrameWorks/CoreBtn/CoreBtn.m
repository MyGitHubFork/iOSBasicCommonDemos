//
//  BaseBtn.m
//  Drivers
//
//  Created by muxi on 15/2/6.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "CoreBtn.h"
#import "UIImage+ColorForBtn.h"

@implementation CoreBtn



#pragma mark  普通状态
-(void)setBackgroundColorForNormal:(UIColor *)backgroundColorForNormal{
    
    _backgroundColorForNormal=backgroundColorForNormal;
    [self setBackgroundImage:[UIImage imageFromContextWithColor:backgroundColorForNormal] forState:UIControlStateNormal];
    if(_backgroundColorForDisabled==nil) self.backgroundColorForDisabled=backgroundColorForNormal;
}


#pragma mark  高亮状态
-(void)setBackgroundColorForHighlighted:(UIColor *)backgroundColorForHighlighted{
    _backgroundColorForHighlighted=backgroundColorForHighlighted;
    [self setBackgroundImage:[UIImage imageFromContextWithColor:backgroundColorForHighlighted] forState:UIControlStateHighlighted];
}



#pragma mark  选中状态
-(void)setBackgroundColorForSelected:(UIColor *)backgroundColorForSelected{
    _backgroundColorForSelected=backgroundColorForSelected;
    [self setBackgroundImage:[UIImage imageFromContextWithColor:backgroundColorForSelected] forState:UIControlStateSelected];
}


#pragma mark  不可用状态
-(void)setBackgroundColorForDisabled:(UIColor *)backgroundColorForDisabled{
    _backgroundColorForDisabled=backgroundColorForDisabled;
    [self setBackgroundImage:[UIImage imageFromContextWithColor:backgroundColorForDisabled] forState:UIControlStateDisabled];
}



#pragma mark  字体大小
-(void)setFontPoint:(CGFloat)fontPoint{
    _fontPoint=fontPoint;
    self.titleLabel.font=[UIFont systemFontOfSize:fontPoint];
}


@end
