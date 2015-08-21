//
//  NSArray+Swizzle.m
//  NSArraySwizzing
//
//  Created by yifan on 15/8/21.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "NSArray+Swizzle.h"

@implementation NSArray (Swizzle)
-(id)myLastObject{
    //[self myLastObject] 将会执行真的 [self lastObject]
    id ret = [self myLastObject];
    NSLog(@"**********myLastObject************");
    return ret;
}
@end
