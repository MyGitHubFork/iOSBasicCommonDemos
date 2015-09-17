//
//  AppDelegate.m
//  1LocationDemo
//
//  Created by aiteyuan on 14/11/11.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
#warning 定位服务非常耗电，精读越高越耗电，所以一般定位以后就要停止
    //定位的相关类都是以CL开头的
    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    //设置过滤信息
    [locationManager setDistanceFilter:CLLocationDistanceMax];//可选
    //设置定位精度
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];//十米级的精度
    locationManager.delegate = self;
    //开始实时定位
    [locationManager startUpdatingLocation];
    
    http://download.csdn.net/download/totogo2010/4400001
    
    
    return YES;
}


#warning 定位协议方法
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    for (int i = 0; i < locations.count; i++) {
        CLLocationCoordinate2D coordinate = ((CLLocation *)locations[0]).coordinate;
        NSLog(@"经度%f,纬度%f", coordinate.longitude, coordinate.latitude);
        //计算两个位置的距离
        //float distance = [newLocation distanceFromLocation:oldLocation];
        //NSLog(@"新位置和旧位置距离是%f", distance);
        //停止定位
        [manager stopUpdatingLocation];

    }
}
//6.0以后过期了
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    NSLog(@"经度%f,纬度%f", coordinate.longitude, coordinate.latitude);
    //计算两个位置的距离
    float distance = [newLocation distanceFromLocation:oldLocation];
    NSLog(@"新位置和旧位置距离是%f", distance);
   //停止定位
    [manager stopUpdatingLocation];
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
