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
//瀑布流视图缓存属性
@property (strong, nonatomic)NSMutableArray *cellFramesArray;
//缓冲池集合(可重用单元格集合)
@property(strong,nonatomic)NSMutableSet *reusableCellSet;
//还需要一个'东西'记录住当前屏幕上的单元格视图，如果存在，就不再实例化和添加。
//能偶解决的第一个问题：
    //视图不会因为简单的滚动被重复的增加
    //如果视图移动出屏幕，可以将此视图添加到缓冲池。
@property(strong,nonatomic)NSMutableDictionary *screenCellsDict;
@end

@implementation WaterFlowView
/*
 优化思路：
 1只显示屏幕范围内的单元格。(isInScreenWithFrame)
 2建立缓存，保存移出屏幕的单元格=》移出屏幕的单元格就是可重用的。
 3 如果屏幕上已经存在的视图，不需要再去重建。
 */


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

#pragma mark 判断指定frame是否在屏幕范围之内
-(BOOL)isInScreenWithFrame:(CGRect)frame
{
    return  ((frame.origin.y + frame.size.height > self.contentOffset.y)&&
    (frame.origin.y < self.contentOffset.y + self.bounds.size.height));
    
}

#pragma mark 重新调整视图布局
//layoutSubviews是在视图需要重新布局时被调用的
//ScrollView是靠contentOffset的变化来调整视图的显示的。
//滚动视图时，contentOffset发生变化，意味着视图的内容需要调整。
-(void)layoutSubviews
{
    //根据单元格的数组来设置瀑布流图片
    //遍历所有的indexpath，放置对应的视图。
    NSInteger index = 0;
    for (NSIndexPath *indexPath in self.indexPaths)
    {
        //检查屏幕视图数组中是否存在该单元格，如果存在，不再实例化
        WaterFlowCellView *cell = self.screenCellsDict[indexPath];
        if (cell == nil)
        {
            //调用数据源的方法，获取单元格
                //1 首先查询可重用单元格，如果有，从reusableCellSet返回anyObject
                //2 如果没有，实例化
            WaterFlowCellView *cell = [self.dataSource waterFlowView:self cellForRowAtIndexPath:indexPath];
            CGRect frame = [self.cellFramesArray[index] CGRectValue];
#warning 判断视图是否在屏幕里面
            if ([self isInScreenWithFrame:frame]) {
                [cell setFrame:frame];
                [self addSubview:cell];
                //使用indexpath作为key加入屏幕视图字典
                [self.screenCellsDict setObject:cell forKey:indexPath];
            }
        }else{
            //检查单元格是否移除屏幕，如果是，将其从视图中删除，并且添加到缓冲池
            if (![self isInScreenWithFrame:cell.frame]) {
                //1)从屏幕上删除
                [cell removeFromSuperview];
                //2）加到缓冲池
                [self.reusableCellSet addObject:cell];
                //3)从屏幕字典视图中删除。
                [self.screenCellsDict removeObjectForKey:indexPath];
            }
        }
        index++;
    }
    
    NSLog(@"layout subviews %lu", (unsigned long)self.subviews.count);
}

#pragma mark 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //从集合中随便拿出一个
    UITouch *touch = [touches anyObject];
}

#pragma mark 查询可重用单元格
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    /*
     0 预设：缓存池已经存在，并且工作正常
     
     1 去缓冲池查找是否有可重用单元格。
     2 如果有?需要从单元格缓冲池中删除
     */
    WaterFlowCellView *cell = [self.reusableCellSet anyObject];
#warning 查看缓冲池数量
    //NSLog(@"缓冲池的数量%d", self.reusableCellSet.count);
    
    //如果找到可重用单元格，将其从缓冲池中删除
    //单元格添加到视图中的工作，
    if (cell) {
        [self.reusableCellSet removeObject:cell];
    }
    return cell;
}

#pragma mark 加载数据
-(void)reloadData
{
   NSLog(@"加载数据---------%ld",(long)[self.dataSource waterFlowView:self numberOfRowsInColumns:0]);
    
    if (self.numberOfCells == 0) {
        return;
    }
    //后面做真正的数据处理
    [self resetView];
    //在滚动视图如果出现滚动条，会懒加载两个UIImageView，以显示滚动条。
    //NSLog(@"%d",self.subviews.count);
}

#pragma mark 生成缓存数据
-(void)generateCacheData
{
    NSInteger dataCount = [self numberOfCells];
    //1首先初始化根据数据行数indexpaths数组
    if (self.indexPaths == nil) {
        self.indexPaths = [NSMutableArray arrayWithCapacity:dataCount];
    }else{
        [self.indexPaths removeAllObjects];
    }
    for (NSInteger i = 0; i < dataCount; i++) {
        NSIndexPath  *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.indexPaths addObject:indexPath];
    }
    //2 实例化单元格边框数组
    if (self.cellFramesArray == nil) {
        self.cellFramesArray = [NSMutableArray arrayWithCapacity:dataCount];
    }else{
        [self.cellFramesArray removeAllObjects];
    }
    
    //3实例化缓冲池集合
    if (self.reusableCellSet == nil) {
        self.reusableCellSet = [NSMutableSet set];
    }else{
        [self.reusableCellSet removeAllObjects];
    }
    //4屏幕上的视图字典
    if (self.screenCellsDict == nil) {
        self.screenCellsDict = [NSMutableDictionary dictionary];
    }else{
        [self.screenCellsDict removeAllObjects];
    }
}

#pragma mark 布局视图
//根据视图属性或者数据源方法，生成瀑布流视图界面
-(void)resetView
{
    //初始化缓存数据
    [self generateCacheData];
    //2布局界面
    //1)计算每列宽度
    CGFloat colW = self.bounds.size.width / self.numberOfColumns;
    //2)使用一个数组，记录每列的当前Y值。
    CGFloat currentY[_numberOfColumns];
    for (NSInteger i = 0; i < _numberOfColumns; i++) {
        currentY[i] = 0.0;
    }

    /**
     *  在resetView方法中，最需要做的两件事情：
    1 确定每一个单元格的位置
        可以使用一个数组记录住所有单元格的位置
        然后layoutSubviews方法中，重写计算所有子视图的位置即可。
    2确定contentSize以保证用户滚动的流畅
     */
    
    NSInteger col = 0;
    for (NSIndexPath *indexPath in self.indexPaths) {
        //获取单元格高度
        CGFloat h = [self.delegate waterFlowView:self heightForRowAtIndexPath:indexPath];
        //x
        CGFloat x = col * colW;
        //y
        CGFloat y  = currentY[col];
        //设置当前列的新高度
        currentY[col] +=h;
        //计算出下一列的数值
        NSInteger nextCol = (col + 1) % _numberOfColumns;
        //判断当前的行高是否超过下一列的行高
        if (currentY[col] > currentY[nextCol]) {
            col = nextCol;
        }
        //在单元格数组中记录所有单元格的位置（位置和大小）
        [self.cellFramesArray addObject:[NSValue valueWithCGRect:CGRectMake(x, y, colW, h)]];
        
#warning 要让scrollView滚动，需要设置contentSize属性。
        CGFloat maxH = 0;
        //遍历数组，取出最大高度。
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
