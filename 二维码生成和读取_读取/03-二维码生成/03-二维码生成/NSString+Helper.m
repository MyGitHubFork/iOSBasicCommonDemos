//
//  NSString+Helper.m
//  03-二维码生成
//
//  Created by aiteyuan on 14/11/24.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "NSString+Helper.h"
#import <CoreImage/CoreImage.h>
@implementation NSString (Helper)

/**
 *  返回当前字符串对应的，生成二维码对象。
 *
 *  二维码的实现是将字符串传递给滤镜，滤镜直接转换生成二维码图片
 */
-(UIImage *)createQRCode
{
    //1实例化一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //1.1设置filter的默认值，因为之前如果使用过滤镜，输入有可能会被保留。
    //因此在使用滤镜之前，最好设置恢复默认值
    [filter setDefaults];
    //2讲传入的字符串转换为NSData
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //3讲NSData传递给滤镜(通过kvc的方式， 设置inputMessage)
    [filter setValue:data forKey:@"inputMessage"];
    //4 由filter输出图像
    CIImage *outputImage = [filter outputImage];
    //5将CIImage转换为UIImage
   // return [UIImage imageWithCIImage:outputImage];
    return [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
}


@end
