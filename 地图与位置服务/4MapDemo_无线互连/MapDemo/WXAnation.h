//
//  WXAnation.h
//  MapDemo
//
//  Created by wei.chen on 13-1-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WXAnation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;



- (id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate;

@end
