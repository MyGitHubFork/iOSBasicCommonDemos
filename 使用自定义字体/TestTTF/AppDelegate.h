//
//  AppDelegate.h
//  TestTTF
//
//  Created by yunfenghan Ling on 13-3-15.
//  Copyright (c) 2013年 yunfenghan Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MainViewController * mainView;
}
@property (strong, nonatomic) UIWindow *window;

@end
