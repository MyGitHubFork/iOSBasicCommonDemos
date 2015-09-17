//
//  MGJData.m
//  瀑布流
//
//  Created by aiteyuan on 14/10/21.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#import "MGJData.h"

@implementation MGJData
#warning 自定义对象的description方法。
-(NSString *)description
{
    return [NSString stringWithFormat:@"<MGJData: %p, img: %@, w: %f, h: %f, price: %@>", self,self.img,self.w,self.h,self.price];
}
@end
