//
//  UIImage+changeColor.h
//  通过coreGraphic把图片变灰
//
//  Created by 黄成都 on 15/7/4.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (changeColor)
- (UIImage *)imageWithColor:(UIColor *)color;

-(UIImage *)grayImage:(UIImage *)sourceImage;
@end
