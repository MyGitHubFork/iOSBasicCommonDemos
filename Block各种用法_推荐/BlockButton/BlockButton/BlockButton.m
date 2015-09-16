//
//  BlockButton.m
//  BlockButton
//
//  Created by aiteyuan on 14/11/3.
//  Copyright (c) 2014年 黄成都. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)clickAction
{
#warning _block是一个代码块，self是一个button,点击按钮的时候，就会调用按钮实例中相应的_block的实现。
    _block(self);
    
}

@end
