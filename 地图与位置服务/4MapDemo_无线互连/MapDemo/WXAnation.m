//
//  WXAnation.m
//  MapDemo
//
//  Created by wei.chen on 13-1-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXAnation.h"

@implementation WXAnation

- (id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self != nil) {
        _coordinate = coordinate;
    }
    return self;
}

@end
