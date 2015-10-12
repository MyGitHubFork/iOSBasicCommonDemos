//
//  NSString+Helper.h
//  03-二维码生成
//
//  Created by aiteyuan on 14/11/24.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (Helper)
/**
 *  返回当前字符串对应的，生成二维码对象。
 *
 *  二维码的实现是将字符串传递给滤镜，滤镜直接转换生成二维码图片
 */
-(UIImage *)createQRCode;
@end
