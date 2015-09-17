//
//  AppDelegate.m
//  LocationDemo
//
//  Created by wei.chen on 13-1-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 200, 50)];
    self.label.backgroundColor = [UIColor greenColor];
    [self.window addSubview:self.label];
    [self.window makeKeyAndVisible];
#warning 定位服务非常耗电，精读越高越耗电，所以一般定位以后就要停止
    //定位的相关类都是以CL开头的
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //设置过滤信息
//    [locationManager setDistanceFilter:<#(CLLocationDistance)#>]
    //设置定位的精度
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];//十米级的精度
    
    locationManager.delegate = self;
    
    //开始实时定位
    [locationManager startUpdatingLocation];
    
    return YES;
}

//实时定位调用的方法, 6.0过期的方法
#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    NSLog(@"经度：%f,纬度：%f",coordinate.longitude,coordinate.latitude);
    
    //停止实时定位
    [manager stopUpdatingLocation];
    
    //计算两个位置的距离
//    float distance = [newLocation distanceFromLocation:oldLocation];
//    NSLog(@"%f",distance);
    
    
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
        
                       for (CLPlacemark *place in placemarks) {
                           NSLog(@"name,%@",place.name);                       // 位置名
                           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
                           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
                           NSLog(@"locality,%@",place.locality);               // 市
                           NSLog(@"subLocality,%@",place.subLocality);         // 区
                           NSLog(@"country,%@",place.country);                 // 国家                           
                       }
                       
    }];
    
    //----------------------位置反编码--5.0之前的使用-----------------
    MKReverseGeocoder *mkgeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
    mkgeocoder.delegate = self;
    [mkgeocoder start];
    
}

//6.0之后新增的位置调用方法
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations {
    for (CLLocation *location in locations) {
        NSLog(@"%@",location);
        self.label.text  = location;
    }
    
    //停止实时定位
    //[manager stopUpdatingLocation];

}

#pragma mark - MKReverseGeocoder delegate
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder
       didFindPlacemark:(MKPlacemark *)place {

       NSLog(@"---name,%@",place.name);                       // 位置名
       NSLog(@"---thoroughfare,%@",place.thoroughfare);       // 街道
       NSLog(@"---subThoroughfare,%@",place.subThoroughfare); // 子街道
       NSLog(@"---locality,%@",place.locality);               // 市
       NSLog(@"---subLocality,%@",place.subLocality);         // 区
       NSLog(@"---country,%@",place.country);                 // 国家
    
}

@end
