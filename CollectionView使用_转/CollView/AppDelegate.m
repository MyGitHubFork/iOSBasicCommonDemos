//
//  AppDelegate.m
//  CollView
//
//  Created by the Hackintosh of XKD on 14-10-20.
//  Copyright (c) 2014年 ZHIYOUEDU. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    RootViewController *rootVC=[[RootViewController alloc]init];
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:rootVC];
    nav.navigationBarHidden=YES;
    
    self.window.rootViewController=nav;
    
    
    
    
    return YES;
}


@end
