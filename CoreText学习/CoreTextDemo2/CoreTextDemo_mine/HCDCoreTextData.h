//
//  HCDCoreTextData.h
//  CoreTextDemo_mine
//
//  Created by yifan on 15/8/19.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#warning 用于保存由CTFrameParser类生成的CTFrameRef实例以及CTFrameRef实际绘制需要的高度。
@interface HCDCoreTextData : NSObject
@property(assign,nonatomic)CTFrameRef ctFrame;
@property(assign,nonatomic)CGFloat height;
@end
