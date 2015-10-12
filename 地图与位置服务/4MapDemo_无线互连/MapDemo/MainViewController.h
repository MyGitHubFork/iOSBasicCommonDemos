//
//  MainViewController.h
//  MapDemo
//
//  Created by wei.chen on 13-1-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController<MKMapViewDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@end
