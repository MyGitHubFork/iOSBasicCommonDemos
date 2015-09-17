//
//  MyWaterflowView.h
//  WaterFlowView
//
//  Created by hanwei on 15/7/27.
//  Copyright (c) 2015年 hanwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    waterFlowViewMarginTop,
    waterFlowViewMarginBottom,
    waterFlowViewMarginLeft,
    waterFlowViewMarginRight,
    waterFlowViewMarginColumn,
    waterFlowViewMarginRow,
}waterFlowViewMarginType;
@class MyWaterflowView;
@class MyWaterflowViewCell;

#pragma mark 数据源方法
@protocol  MyWaterflowViewDateSource<NSObject>
@optional;
//在每一行中的数据行数
-(NSInteger)waterFlowView:(MyWaterflowView*)waterFlowView numberOfRowsInColumns:(NSInteger*)columns;

//有多少个数据
-(NSInteger)numberOfCellsWatersFlowView:(MyWaterflowView*)waterFlowView;
//指定index位置对应的cell
-(MyWaterflowViewCell*)waterFlowView:(MyWaterflowView*)waterFlowView cellAtIndex:(NSUInteger)index;

//使用@optional描述符，可以指定方法不一定被实现
@optional
//指定列数
-(NSInteger)numberOfColimnsInWaterFlowView:(MyWaterflowView*)waterFlowView;



@end

#pragma mark 代理方法

@protocol MyWaterflowViewDelegate <NSObject>
@optional;
//1.选中单元格
-(void)waterFlowView:(MyWaterflowView*)waterFlowView didSelectRowAtIndexPath:(NSUInteger)index;
//2.指定indexPath单元格的行高
-(CGFloat)waterFlowView:(MyWaterflowView*)waterFlowView heightForRowAtIndexPath:(NSUInteger)index;


//3.刷新数据
-(void)waterFlowViewRefreshDate:(MyWaterflowView*)waterView;

//4.返回间距
-(CGFloat)waterFlowView:(MyWaterflowView*)waterFlowView magrnFortype:(waterFlowViewMarginType)type;


@end
@interface MyWaterflowView : UIScrollView<MyWaterflowViewDateSource,MyWaterflowViewDelegate>
@property(nonatomic,weak)id<MyWaterflowViewDelegate> delegate;
@property(nonatomic,weak)id<MyWaterflowViewDateSource> dateSource;
#pragma mark 刷新数据
-(void)reloadData;
#pragma mark 查询可重用单元格
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end
