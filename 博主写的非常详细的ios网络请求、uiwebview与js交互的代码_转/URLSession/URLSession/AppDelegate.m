//
//  AppDelegate.m
//  URLSession
//
//  Created by Kenshin Cui on 14-03-23.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "AppDelegate.h"
#import "KCMainViewController.h"

@interface AppDelegate ()<NSURLSessionDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _window.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    
    //设置全局导航条风格和颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    KCMainViewController *mainController=[[KCMainViewController alloc]init];
    _window.rootViewController=mainController;
    
    [_window makeKeyAndVisible];
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"5 seconds after entering the background");
}


-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler{
    
    //backgroundSessionCompletionHandler是自定义的一个属性
    self.backgroundSessionCompletionHandler=completionHandler;
   
}

-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Other Operation....
    
    if (appDelegate.backgroundSessionCompletionHandler) {
        
        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
        
        appDelegate.backgroundSessionCompletionHandler = nil;
        
        completionHandler();
        
    }
}
@end
