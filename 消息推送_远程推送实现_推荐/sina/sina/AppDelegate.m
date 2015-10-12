//
//  AppDelegate.m
//  sina
//
//  Created by aiteyuan on 14-9-26.
//  Copyright (c) 2014年 黄成都. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //这是测试label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 50)];
    label.backgroundColor = [UIColor redColor];
    label.tag = 101;
    label.textColor = [UIColor whiteColor];
    [self.window addSubview:label];
    //当我们的程序未运行时。
    NSDictionary *remoteDic = [launchOptions objectForKeyedSubscript:UIApplicationLaunchOptionsRemoteNotificationKey ];
    
    if (remoteDic) {
        label.backgroundColor = [UIColor purpleColor];
        label.text = [[remoteDic objectForKey:@"aps"] objectForKey:@"alert"];
    }
    
    
    //注册通知
    //这句话执行以后就会弹出一个对话框，是否允许远程推送，如果允许，则会链接苹果推送服务器，苹果推送服务器会给我们返回一个Token
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    //当我们的程序没有被启动的时候，provider(服务器)发送了一条感兴趣的消息，通过launchOptions字典来获取内容。
    return YES;
}

#pragma mark 推送通知需要实现下面这三个方法
//这个方法的作用就是接收从苹果推送服务器返回的Token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken: %@", deviceToken);
    
    //76c0e619 a98b6e6d b34de7e6 7f24480c 105a376c 67dbabf1 f696758f a248c383
}
//如果出现错误，则会调用这个方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"error: %@", [error localizedDescription]);
}

//这里用来接收推送的消息，接收苹果推送服务器发送给我们敢兴趣的消息。
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo:  %@", [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    UILabel *label = (UILabel *)[self.window viewWithTag:101];
    label.text = [[userInfo objectForKey:@"aps"] objectForKey:@"other"];
}//当我们的程序挂起的时候，通过代理来处理。


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
#warning 每次打开设置图标数字为0
    [application setApplicationIconBadgeNumber:0];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
