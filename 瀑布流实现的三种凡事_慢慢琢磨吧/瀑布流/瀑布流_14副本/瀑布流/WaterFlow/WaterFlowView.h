//
//  WaterFlowView.h
//  瀑布流
//
//  Created by aiteyuan on 14-10-20.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowView;
@class WaterFlowCellView;

/**
 *  对象之间的通信：
 * 1 代理协议
    1>必须针对每个方法，去编写具体的实现，在开发时会上下切换代码
    2>对于复杂的对象的开发，使用代理协议通常便于调试和扩展。
    3>使用@optional描述符，可以指定方法不一定被实现。
 * 2 快代码
    1>所有代码集成在一起，便于维护，便于书写
    2>适合与少量的协议方法，如果方法过多，开发难度会上升。
 
 如何选择代理方法的可选和必选：
    如果方法不实现，会影响整体运行，此类方法必须实现！
 
 代理方法的调用：
    由WaterFlowView通知其代理
 */


#pragma 数据源协议方法
@protocol WaterFlowViewDataSource <NSObject>
@optional
//在每一列中的数据行数
- (NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns;
//指定indexpath位置的单元格视图
- (WaterFlowCellView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//指定列数
- (NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView;
@end


#pragma mark 代理协议方法
/**
 *  <NSObject>表示继承自NSObject得对象都可以遵守这个代理协议，
    如果当前对象的父类有delegate属性，会自动合并属性
 */
@protocol WaterFlowViewDelegate <NSObject,UIScrollViewDelegate>
@optional
//1选中单元格
- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//2指定indexpath单元格的行高
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//3刷新数据
-(void)waterFlowViewRefreshData:(WaterFlowView *)waterFlowView;
@end




@interface WaterFlowView : UIScrollView

@property(weak,nonatomic) id<WaterFlowViewDataSource>dataSource;
@property(weak,nonatomic) id<WaterFlowViewDelegate>delegate;
#pragma mark 刷新数据
-(void)reloadData;
#pragma mark 查询可重用单元格
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end
