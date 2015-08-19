//
//  HCDFrameParser.h
//  CoreTextDemo_mine
//
//  Created by yifan on 15/8/19.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCDCoreTextData.h"
#import "HCDFrameParserConfig.h"
#warning 用于生成最后绘制界面需要的CTFrameRef实例。
@interface HCDFrameParser : NSObject
+(HCDCoreTextData *)parseContext:(NSString *)content config:(HCDFrameParserConfig *)config;
@end
