//
//  HCDFrameParserConfig.m
//  CoreTextDemo_mine
//
//  Created by yifan on 15/8/19.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDFrameParserConfig.h"

@implementation HCDFrameParserConfig
-(instancetype)init{
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0;
        _lineSpace = 8.0f;
        _textColor = RGB(108, 108, 108);
    }
    return self;
}
@end
