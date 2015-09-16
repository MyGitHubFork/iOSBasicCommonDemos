//
//  AppDelegate.m
//  AES加密解密
//
//  Created by aiteyuan on 14/11/12.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "AppDelegate.h"
#import "AESCrypt.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString *pwdKey = @"新风作浪";
    NSString *password = @"duxinfeng123456";
#warning 得到加密后的数据，可以把这个数据写入沙盒中
    NSString *encryptedPWD = [AESCrypt encrypt:password password:pwdKey];
    NSString *decryptedPWD = [AESCrypt decrypt:encryptedPWD password:pwdKey];
    
    NSLog(@"加密后密码:%@  解密后密码: %@",encryptedPWD,decryptedPWD);
    
    return YES;
}

#warning 从沙盒中取出数据解密
-(NSString *)getPwd
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString * temp = [settings objectForKey:@"Password"];
    return [AESCrypt decrypt:temp password:@"pwd"];
}
#warning 加密数据存入沙盒
-(void)saveUserNameAndPwd:(NSString *)userName andPwd:(NSString *)pwd
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
//移除沙盒中原有的数据
    [settings removeObjectForKey:@"UserName"];
    [settings removeObjectForKey:@"Password"];
    [settings setObject:userName forKey:@"UserName"];
    
    pwd = [AESCrypt encrypt:pwd password:@"pwd"];
    
    [settings setObject:pwd forKey:@"Password"];
    [settings synchronize];
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
