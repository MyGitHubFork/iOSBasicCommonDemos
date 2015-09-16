//
//  CustomStatusBar.m
//  CustomStatusBar
//
//  Created by Jason Lee on 12-3-12.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "CustomStatusBar.h"

@implementation CustomStatusBar

//- (void)dealloc
//{
//    [_statusMsgLabel release], _statusMsgLabel = nil;
//    //
//    [super dealloc];
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor blackColor];
        
        _statusMsgLabel = [[UILabel alloc] initWithFrame:self.frame];
        _statusMsgLabel.backgroundColor = [UIColor clearColor];
        _statusMsgLabel.textColor = [UIColor whiteColor];
        _statusMsgLabel.font = [UIFont systemFontOfSize:10.0f];
        _statusMsgLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_statusMsgLabel];
    }
    return self;
}

- (void)showStatusMessage:(NSString *)message
{
    self.hidden = NO;
    self.alpha = 1.0f;
    _statusMsgLabel.text = @"";
    
    CGSize totalSize = self.frame.size;
    self.frame = (CGRect){ self.frame.origin, 0, totalSize.height };
    
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = (CGRect){ self.frame.origin, totalSize };
    } completion:^(BOOL finished){
        _statusMsgLabel.text = message;
    }];
}

- (void)hide
{
    self.alpha = 1.0f;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished){
        _statusMsgLabel.text = @"";
        self.hidden = YES;
    }];;
}

@end
