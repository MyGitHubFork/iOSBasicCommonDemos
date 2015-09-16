//
//  AppDelegate.m
//  weiboTail
//
//  Created by Colin on 14-9-7.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize mySplashView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
#warning Images.xcassets中设置应用图标和启动图片，以及其他各种图片
#warning 在plist文件中设置启动的时候，隐藏状态栏。
    //有米广告
    [YouMiConfig setUseInAppStore:YES];  // [可选]开启内置appStore，详细请看YouMiSDK常见问题解答
    [YouMiConfig launchWithAppID:@"d38a28c984bba226" appSecret:@"630665c87c80a0cd"];
    
    //启动动画
    [self.window makeKeyAndVisible];
    
    mySplashView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
#warning 通过Images.xcassets设置背景图片
    [mySplashView setImage:[UIImage imageNamed:@"background_"]];
    [self.window addSubview:mySplashView];
    [self.window bringSubviewToFront:mySplashView];
    
    [self performSelector:@selector(showWord) withObject:nil afterDelay:0.3f];

    
    return YES;
}


-(void)showWord
{
    CGFloat animateHeight = 450;
    
    UIImageView *lightpoint = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icare_iphone_lightpoint"]];
    
    UIImageView *lightline = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icare_iphone_lightline"]];
    
    
    [lightline setCenter:CGPointMake(160, animateHeight)];
    [lightline setFrame:CGRectMake(lightline.frame.origin.x, lightline.frame.origin.y, 0, 2)];
    
    [lightpoint setCenter:CGPointMake(180, animateHeight)];
    lightpoint.hidden= YES;
    [mySplashView addSubview:lightpoint];
    
    [mySplashView addSubview:lightline];
#warning 设置启动动画
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         //                         [lightpoint setCenter:CGPointMake(233, 310)];
                         [lightline setFrame:CGRectMake(lightline.frame.origin.x, lightline.frame.origin.y, 188, 2)];
                     }
                     completion:^(BOOL finished) {
                         lightpoint.hidden= NO;
                         [UIView animateWithDuration:0.4
                                               delay:0.0
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              
                                              [lightpoint setCenter:CGPointMake(233, animateHeight)];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              NSLog(@"completion");
                                          }
                          
                          ];
                     }
     
     ];
    
    
    UIImageView *word_ = [[UIImageView alloc]initWithFrame:CGRectMake(35, 380, 250, 60)];
    word_.image = [UIImage imageNamed:@"word_"];
    [mySplashView addSubview:word_];
    
    word_.alpha = 0.0;
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         word_.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
#warning 主线程休眠一秒钟
         // 完成后执行code
         [NSThread sleepForTimeInterval:1.0f];
         [mySplashView removeFromSuperview];
         
     }
     ];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
