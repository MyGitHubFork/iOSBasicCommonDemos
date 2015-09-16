//
//  YouMiWallSpot.h
//  YouMiSDK
//
//  Created by 陈建峰 on 13-9-4.
//  Copyright (c) 2013年 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YouMiWallSpot : NSObject

//积分插播的状态
+ (BOOL)isReady;

//展示插播,只有当isReady为true时才会展示积分插播。
+ (void)showSpotViewWithBlock:(void(^)())dismiss;
@end
