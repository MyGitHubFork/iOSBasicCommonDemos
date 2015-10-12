//
//  WaterFlowViewController.h
//  瀑布流
//
//  Created by aiteyuan on 14-10-20.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowView.h"
#import "WaterFlowCellView.h"
@interface WaterFlowViewController :UIViewController<WaterFlowViewDelegate,WaterFlowViewDataSource>
//要让waterFlowView等于self.view
@property(strong,nonatomic) WaterFlowView *waterFlowView;
@end
