//
//  MyWaterflowViewCell.m
//  WaterFlowView
//
//  Created by hanwei on 15/7/27.
//  Copyright (c) 2015年 hanwei. All rights reserved.
//

#import "MyWaterflowViewCell.h"

@implementation MyWaterflowViewCell
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self = [super init];
    if (self) {
        static NSInteger cellCount;
        NSLog(@"第%ld个cell初始化",(long)cellCount++);
    }
    return self;
}

@end
