//
//  UIViewController+HCDMethodSwizzling.m
//  OC消息转发
//
//  Created by yifan on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "UIViewController+HCDMethodSwizzling.h"
#import <objc/runtime.h>
@implementation UIViewController (HCDMethodSwizzling)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(mrc_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (void)mrc_viewWillAppear:(BOOL)animated {
    //[self mrc_viewWillAppear:animated];
    //NSLog(@"消息转发实现");
    
    NSLog(@"类%@",NSStringFromClass([self class]));
}


@end
