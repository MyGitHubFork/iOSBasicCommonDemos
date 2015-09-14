//
//  UIControl+HCDControlCategory.h
//  用runtime 解决UIButton 重复点击问题
//
//  Created by yifan on 15/9/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (HCDControlCategory)
@property(nonatomic,assign)NSTimeInterval uxy_acceptEventInterval;// 可以用这个给重复点击加间隔
@property (nonatomic) BOOL ignoreEvent;
@end
