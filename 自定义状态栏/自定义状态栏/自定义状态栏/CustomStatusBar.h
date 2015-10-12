//
//  CustomStatusBar.h
//  CustomStatusBar
//
//  Created by Jason Lee on 12-3-12.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomStatusBar : UIWindow
{
    UILabel *_statusMsgLabel;
}

- (void)showStatusMessage:(NSString *)message;
- (void)hide;

@end
