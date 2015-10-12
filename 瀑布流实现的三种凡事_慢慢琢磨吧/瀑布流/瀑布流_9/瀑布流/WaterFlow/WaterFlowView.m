//
//  WaterFlowView.m
//  瀑布流
//
//  Created by aiteyuan on 14-10-20.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#warning 这个是模仿UITableView的实现
#import "WaterFlowView.h"
#import "WaterFlowCellView.h"

@interface WaterFlowView()
//indexPath的数组
@property (strong,nonatomic)NSMutableArray *indexPaths;
//列数
@property (assign,nonatomic)NSInteger numberOfColumns;
//瀑布流视图单元格的数量
@property(assign,nonatomic)NSInteger numberOfCells;
@end

@implementation WaterFlowView

#pragma mark 使用UIView的frame的Setter方法
//次方法是在重新调整视图大小时，调用的。可以利用这个方法在横竖屏切换时刷新数据使用。
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
#warning 这里设置WaterFlowView的Frame，现在是设置来适配状态栏
    //[super setFrame:CGRectMake(0, 20, frame.size.width, frame.size.height - 20)];
    //加载数据
    [self reloadData];
}


-(void)reloadData
{
   NSLog(@"加载数据---------%d",[self.dataSource waterFlowView:self numberOfRowsInColumns:0]);
//    NSInteger count = [self.dataSource waterFlowView:self numberOfRowsInColumns:0];
    if (self.numberOfCells == 0) {
        return;
    }
    //后面做真正的数据处理
    [self resetView];
    //在滚动视图如果出现滚动条，会懒加载两个UIImageView，以显示滚动条。
    NSLog(@"%d",self.subviews.count);
}


#pragma mark 布局视图
//根据视图属性或者数据源方法，生成瀑布流视图界面
-(void)resetView
{
    //1首先初始化根据数据行数indexpaths数组
    NSInteger dataCount = [self numberOfCells];
    
    if (self.indexPaths == nil) {
        self.indexPaths = [NSMutableArray arrayWithCapacity:dataCount];
    }else{
        [self.indexPaths removeAllObjects];
    }
    for (NSInteger i = 0; i < dataCount; i++) {
        NSIndexPath  *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.indexPaths addObject:indexPath];
    }
    //2布局界面
    //1)计算每列宽度
    CGFloat colW = self.bounds.size.width / self.numberOfColumns;
    //2)使用一个数组，记录每列的当前Y值。
    CGFloat currentY[_numberOfColumns];
    for (NSInteger i = 0; i < _numberOfColumns; i++) {
        currentY[i] = 0.0;
    }

    NSInteger col = 0;
    for (NSIndexPath *indexPath in self.indexPaths) {
        //从MainViewController的数据源方法获取单元格。
        WaterFlowCellView *cell = [self.dataSource waterFlowView:self cellForRowAtIndexPath:indexPath];
        //获取单元格高度
        CGFloat h = [self.delegate waterFlowView:self heightForRowAtIndexPath:indexPath];
        
        //列数
        //NSInteger col = indexPath.row % _numberOfColumns;
        //x
        CGFloat x = col * colW;
        //y
        CGFloat y  = currentY[col];
        
        currentY[col] +=h;
        
        //计算出下一列的数值
        NSInteger nextCol = (col + 1) % _numberOfColumns;
        //判断当前的行高是否超过下一列的行高
        if (currentY[col] > currentY[nextCol]) {
            col = nextCol;
        }
        
        [cell setFrame:CGRectMake(x, y, colW, h)];
        [self addSubview:cell];
        
#warning 要让scrollView滚动，需要设置contentSize属性。
        CGFloat maxH = 0;
        for (NSInteger i = 0; i < _numberOfColumns; i++) {
            if (currentY[i] > maxH) {
                maxH = currentY[i];
            }
        }
        [self setContentSize:CGSizeMake(self.bounds.size.width, maxH)];
    }
}

#pragma mark 私有方法
#pragma mark 获取列数getter方法
-(NSInteger)numberOfColumns
{
    NSInteger number = 1;
#warning  对于可选的代理方法，需要判断数据源是否实现了该方法
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterFlowView:)]) {
        number = [self.dataSource numberOfColumnsInWaterFlowView:self];
    }
    _numberOfColumns = number;
    return _numberOfColumns;
}

#pragma mark 获取数据行数 getter方法
-(NSInteger)numberOfCells
{
    _numberOfCells = [self.dataSource waterFlowView:self numberOfRowsInColumns:0];
    return _numberOfCells;
}
@end
