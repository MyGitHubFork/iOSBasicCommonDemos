//
//  YouMiWallSpotView.h
//  YouMiSDK
//
//  Created by 陈建峰 on 13-10-11.
//  Copyright (c) 2013年 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *YouMiWallSpotView提供给开发者自定义积分插播的展现动画，展现的位置，背景等等
 *使用的时候用init来初始化，不要使用用initWithFrame。
 */
@interface YouMiWallSpotView : UIView
/*
 *设置偏移量
 *插播大小已经固定，只提供设置center的接口
 */
- (void)setCenter:(CGPoint)center;

/*
 *获取插播view的大小
 */
- (CGSize)getSpotViewSize;

/*
 * 当isReady返回true的时候，才显示view
 */
-  (BOOL)isReady;

@end
