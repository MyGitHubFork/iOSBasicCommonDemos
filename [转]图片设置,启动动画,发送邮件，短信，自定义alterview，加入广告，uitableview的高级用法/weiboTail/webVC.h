//
//  webVC.h
//  weiboTail
//
//  Created by Colin on 14-9-7.
//  Copyright (c) 2014年 icephone. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface webVC : UIViewController<UIWebViewDelegate>
{
    NSURLRequest *request;
    UIWebView *webView;
}

@property NSString *webStr;
@end
