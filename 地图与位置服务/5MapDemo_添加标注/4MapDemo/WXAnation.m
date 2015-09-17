//
//  WXAnation.m
//  4MapDemo
//
//  Created by aiteyuan on 14/11/13.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "WXAnation.h"

@implementation WXAnation
-(id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self != nil) {
        _coordinate = coordinate;
    }
    return self;
}
@end
