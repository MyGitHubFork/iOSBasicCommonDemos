//
//  HCDFrameParserConfig.h
//  CoreTextDemo_mine
//
//  Created by yifan on 15/8/19.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>
#warning 用于配置绘制的参数，例如：文字颜色，大小，行间距等。
@interface HCDFrameParserConfig : NSObject
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat fontSize;
@property(nonatomic,assign)CGFloat lineSpace;
@property(nonatomic,strong)UIColor *textColor;
@end
