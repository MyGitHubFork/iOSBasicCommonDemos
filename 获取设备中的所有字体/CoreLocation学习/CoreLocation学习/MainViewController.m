//
//  MainViewController.m
//  CoreLocation学习
//
//  Created by aiteyuan on 14/11/26.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "MainViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController ()<CLLocationManagerDelegate>
@property(strong,nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic) UILabel *Standart;
@property(strong,nonatomic) UILabel *Significant;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _Standart = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 500, 50)];
    [self.view addSubview:self.Standart];
    [self startStandartUpdates];// 获得地址
    
    //[self startSignificantChangeUpdates];
    
}

-(void)startStandartUpdates
{
    if (nil == _locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
    }
    
    
    _locationManager.delegate = self;
    //定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //如果用户过一段时间没有动，则停止定位
    //_locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //移动五百米更新定位信息
    _locationManager.distanceFilter = 500;
    [_locationManager startUpdatingLocation];
    //[CLLocationManager deferredLocationUpdatesAvailable];
}


-(void)startSignificantChangeUpdates
{
    if (nil == _locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
    }
    
    [_locationManager startMonitoringSignificantLocationChanges];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //-------------------------定位-----------------
    CLLocation *location = [locations lastObject];
    self.Standart.text = [[NSString alloc]initWithFormat:@"latitude %+.10f, lognitude %+.10f\n",location.coordinate.latitude, location.coordinate.longitude];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent =[eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        NSLog(@"latitude xx%+.10f, lognitude xx%+.10f\n", location.coordinate.latitude, location.coordinate.longitude);
        self.Standart.text = [[NSString alloc]initWithFormat:@"latitude %+.10f, lognitude %+.10f\n",location.coordinate.latitude, location.coordinate.longitude];
        //停止定位
        manager.pausesLocationUpdatesAutomatically = YES;
        [manager disallowDeferredLocationUpdates];//不允许延迟定位
    }
   
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error");
    manager.pausesLocationUpdatesAutomatically = YES;
}


-(void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"停止定位");
}

-(void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"重新开始定位");
}
-(void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    NSLog(@"停止延迟定位");
}
@end
