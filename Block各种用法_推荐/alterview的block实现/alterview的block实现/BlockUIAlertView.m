//
//  BlockUIAlertView.m
//  alterview的block实现
//
//  Created by aiteyuan on 14/11/6.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "BlockUIAlertView.h"

@implementation BlockUIAlertView

-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles buttonBlock:(ButtonBlock)block
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self !=nil) {
        self.block = block;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _block(buttonIndex);
}
@end
