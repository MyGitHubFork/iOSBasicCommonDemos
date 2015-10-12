//
//  HCDDisplayView.m
//  CoreTextDemo_mine
//
//  Created by yifan on 15/8/19.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDDisplayView.h"
#import <CoreText/CoreText.h>
@implementation HCDDisplayView

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    //得到当前绘制上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //把坐标切换为底层坐标
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    //设置绘制范围
//    CGMutablePathRef path = CGPathCreateMutable();
//    //CGPathAddRect(path, NULL, self.bounds);
//    CGPathAddEllipseInRect(path, NULL, self.bounds);
//    //具体绘制内容
//    //NSAttributedString *attString = [[NSAttributedString alloc]initWithString:@"hello world"];
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World! "
//        " 创建绘制的区域，CoreText 本身支持各种文字排版的区域，"
//        " 我们这里简单地将 UIView 的整个界面作为排版的区域。"
//        " 为了加深理解，建议读者将该步骤的代码替换成如下代码，"
//        " 测试设置不同的绘制区域带来的界面变化。"];
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
//    //绘制动作
//    CTFrameDraw(frame, context);
//    //释放相关资源
//    CFRelease(frame);
//    CFRelease(path);
//    CFRelease(framesetter);
//
//}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
}

@end
