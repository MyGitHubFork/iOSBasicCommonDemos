//
//  WaterFlowViewController.m
//  瀑布流
//
//  Created by aiteyuan on 14-10-20.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#import "WaterFlowViewController.h"


@interface WaterFlowViewController ()

@end

@implementation WaterFlowViewController



#pragma mark 实例化视图
-(void)loadView
{
    //如此做法是保证视图控制器能够嵌套使用。
    //1 实例化一个没有大小的瀑布流视图。
    _waterFlowView = [[WaterFlowView alloc]initWithFrame:CGRectZero];
    //_waterFlowView = [[WaterFlowView alloc]init];
    //2 要保证当前视图和父视图同样大小。
#warning 把视图的宽和高自动设置为父视图宽高。
    [_waterFlowView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    //3设置代理和数据源
    [_waterFlowView setDataSource:self];
    [_waterFlowView setDelegate:self];
    
    
    
    //4与根视图等同，作用是模仿UITableView
    self.view = _waterFlowView;
    
    
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
   
    //[self.waterFlowView reloadData];
}




#pragma mark数据源方法
//提示：一下两个协议方法的实现，都是空方法，具体的实现，应该在子类中实现。
-(NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns
{
    return 0;
}
-(WaterFlowCellView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
#pragma mark 代理方法

@end
