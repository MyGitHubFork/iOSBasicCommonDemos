//
//  APAuthV2Info.h
//  AliSDKDemo
//
//  Created by 方彬 on 12/25/14.
//  Copyright (c) 2014 Alipay.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APAuthV2Info : NSObject


@property(strong)NSString *apiName;
@property(strong)NSString *appName;
@property(strong)NSString *appID;
@property(strong)NSString *bizType;
@property(strong)NSString *pid;
@property(strong)NSString *productID;
@property(strong)NSString *scope;
@property(strong)NSString *targetID;
@property(strong)NSString *authType;
@property(strong)NSString *signDate;
@property(strong)NSString *service;



- (NSString *)description;


@end
