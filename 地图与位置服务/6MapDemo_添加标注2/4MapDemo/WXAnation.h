//
//  WXAnation.h
//  4MapDemo
//
//  Created by aiteyuan on 14/11/13.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//
#warning 这个类实现添加标注头
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//要实现这个协议
@interface WXAnation : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
//自定义初始化方法
-(id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate;
@end
