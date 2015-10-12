//
//  AppDelegate.h
//  1LocationDemo
//
//  Created by aiteyuan on 14/11/11.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import <UIKit/UIKit.h>
#warning 使用定位需要导入CoreLocation框架
#import <CoreLocation/CoreLocation.h>

#warning 定位的代理协议CLLocationManagerDelegate
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
