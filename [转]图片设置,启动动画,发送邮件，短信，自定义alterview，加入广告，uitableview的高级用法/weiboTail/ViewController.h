//
//  ViewController.h
//  weiboTail
//
//  Created by Colin on 14-9-7.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "EAIntroView.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#include <sys/types.h>
#include <sys/sysctl.h>

#import "DXAlertView.h"

#import "YouMiView.h"



@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, EAIntroDelegate>
{
    NSArray *tableArr;
    UITableView *myTableView;
    NSArray *picArr;
}

@end
