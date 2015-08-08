//
//  UIViewController+HCDViewControllerCategory.m
//  OC关联对象实践
//
//  Created by yifan on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "UIViewController+HCDViewControllerCategory.h"
#import <objc/runtime.h>
@implementation UIViewController (HCDViewControllerCategory)
#pragma mark assign
- (NSString *)associatedObject_assign{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAssociatedObject_assign:(NSString *)associatedObject_assign{
    objc_setAssociatedObject(self, @selector(associatedObject_assign), associatedObject_assign,OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark retain
-(NSString *)associatedObject_retain{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAssociatedObject_retain:(NSString *)associatedObject_retain{
    objc_setAssociatedObject(self, @selector(associatedObject_retain), associatedObject_retain, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark copy
- (NSString *)associatedObject_copy{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAssociatedObject_copy:(NSString *)associatedObject_copy{
    objc_setAssociatedObject(self, @selector(associatedObject_copy), associatedObject_copy, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark 给类添加关联对象associatedObject具体实现
+ (NSString *)associatedObject {
    return objc_getAssociatedObject([self class], _cmd);
}
+ (void)setAssociatedObject:(NSString *)associatedObject {
    objc_setAssociatedObject([self class], @selector(associatedObject), associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
