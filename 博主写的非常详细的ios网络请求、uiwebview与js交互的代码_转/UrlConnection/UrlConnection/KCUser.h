//
//  KCUser.h
//  UrlConnection
//
//  Created by Kenshin Cui on 14-3-22.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCUser : NSObject

#pragma mark 编号
@property (nonatomic,strong) NSNumber *Id;

#pragma mark 用户名
@property (nonatomic,copy) NSString *name;

#pragma mark 城市
@property (nonatomic,copy) NSString *city;

@end
