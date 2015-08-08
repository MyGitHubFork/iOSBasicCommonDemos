//
//  UIViewController+HCDViewControllerCategory.h
//  OC关联对象实践
//
//  Created by yifan on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HCDViewControllerCategory)
@property(assign,nonatomic)NSString *associatedObject_assign;
@property(strong,nonatomic)NSString *associatedObject_retain;
@property(copy,nonatomic)NSString *associatedObject_copy;

#pragma mark 给类添加关联对象associatedObject
+ (NSString *)associatedObject;
+ (void)setAssociatedObject:(NSString *)associatedObject;
@end
