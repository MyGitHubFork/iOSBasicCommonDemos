//
//  UIControl+HCDControlCategory.m
//  用runtime 解决UIButton 重复点击问题
//
//  Created by yifan on 15/9/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "UIControl+HCDControlCategory.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *uxy_ignoreEvent = "uxy_ignoreEvent";


@implementation UIControl (HCDControlCategory)

//改变两个方法的实现。在类第一次使用的时候回调用这个方法
+(void)load{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}
//通过关联对象重写get和set方法
- (NSTimeInterval)uxy_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)uxy_ignoreEvent{
    return [objc_getAssociatedObject(self, uxy_ignoreEvent) boolValue];
}

-(void)setUxy_ignoreEvent:(BOOL)uxy_ignoreEvent{
    objc_setAssociatedObject(self, uxy_ignoreEvent, [NSNumber numberWithBool:uxy_ignoreEvent], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.uxy_ignoreEvent) return;
    if (self.uxy_acceptEventInterval > 0)
    {
        
        self.uxy_ignoreEvent = YES;
        [self performSelector:@selector(setUxy_ignoreEvent:) withObject:@(NO) afterDelay:self.uxy_acceptEventInterval];
    }
    [self __uxy_sendAction:action to:target forEvent:event];
}


@end
