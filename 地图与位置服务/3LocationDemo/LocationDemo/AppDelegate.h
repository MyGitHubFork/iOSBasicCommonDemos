//
//  AppDelegate.h
//  LocationDemo
//
//  Created by wei.chen on 13-1-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#warning 使用定位需要导入CoreLocation框架
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#warning 定位的代理协议CLLocationManagerDelegate
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,MKReverseGeocoderDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UILabel *label;
@end
