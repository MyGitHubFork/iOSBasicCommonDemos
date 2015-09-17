//
//  MyWaterflowView.m
//  WaterFlowView
//
//  Created by hanwei on 15/7/27.
//  Copyright (c) 2015年 hanwei. All rights reserved.
//

#import "MyWaterflowView.h"
#import "MyWaterflowViewCell.h"
#define CellDefausHeight 70
#define ColumnsNumber 3
#define marginNumber 8

@interface MyWaterflowView()

/**
 存放cell的frame的数组
 */
@property(nonatomic,strong)NSMutableArray* cellArray;
/**
 正在显示的cell
 */
@property(nonatomic,strong)NSMutableDictionary* disDictionary;

/**
 缓存池
 */
@property(nonatomic,strong)NSMutableSet* SetSave;
@end


@implementation MyWaterflowView
@synthesize dateSource;
@synthesize delegate;

//懒加载数组
-(NSMutableArray *)cellArray
{
    if (_cellArray==nil) {
        self.cellArray=[[NSMutableArray alloc]init];
    }
    return _cellArray;
}
//懒加载字典
-(NSMutableDictionary *)disDictionary
{
    if (_disDictionary==nil) {
        self.disDictionary=[[NSMutableDictionary alloc]init];
    }
    return _disDictionary;
}
//懒加载缓存池
-(NSMutableSet *)SetSave
{
    if (_SetSave==nil) {
        self.SetSave=[NSMutableSet set];
    }
    return _SetSave;
}

//初始化方法
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
/**
 *刷新数据
 */
-(void)reloadData
{
    //有多少个cell
   long int intCellNumber=[self.dateSource numberOfCellsWatersFlowView:self];
    //NSLog(@"%ld",intCellNumber);
    //总列数
    long int intColumnsNumber=[self numberOfColumns];
    //NSLog(@"%ld",intColumnsNumber);
    
    //每个cell的宽度
    CGFloat top=[self marginForType:waterFlowViewMarginTop];
    CGFloat Bottom=[self marginForType:waterFlowViewMarginBottom];
    CGFloat Left=[self marginForType:waterFlowViewMarginLeft];
    CGFloat Right=[self marginForType:waterFlowViewMarginRight];
    CGFloat Column=[self marginForType:waterFlowViewMarginColumn];
    CGFloat Row=[self marginForType:waterFlowViewMarginRow];
    
    
    
    CGFloat cellW=(self.frame.size.width-Left-Right-(intColumnsNumber-1)*Column)/intColumnsNumber;
    
/**
 *
 *求每个cell的x值和y值
 */
    //把每一列得最大y值都放在C语言数组中
    CGFloat MaxOfColumns[intColumnsNumber];
    //对数组初始化
    for (int i=0; i<intColumnsNumber; i++) {
        MaxOfColumns[i]=0.0;
    }
    //遍历所有的cell，对每个cell的frame都进行计算
    for (int i=0; i<intCellNumber; i++) {
        //最新cell放在那一列,假设最短的是在第0列
        NSUInteger cellColumn=0;
        //cell所处那列的最大y值(所处这列在所有列中y值是最小的)
        CGFloat maxYOfCellColum=MaxOfColumns[cellColumn];
        
        for (int j=1; j<intColumnsNumber; j++) {
            //遍历每一列 ，如果比最小的maxOfCellColums小
             //NSLog(@"%f",MaxOfColumns[j]);
            if (MaxOfColumns[j]<maxYOfCellColum) {
                //求出cell放在了那j列
                cellColumn=j;
               
                maxYOfCellColum=MaxOfColumns[j];
            }
        }
        //每个cell的高度
  
        CGFloat cellH=[self hrightCells:i];
       // NSLog(@"%f",cellH);
        

        //得到cell的x
        CGFloat cellX=Left+cellColumn*(Column+cellW);
        //NSLog(@"%f",maxYOfCellColum);
        //得到cell的y
        CGFloat cellY=0;
        if (maxYOfCellColum==0.0) {//说明是第一个
             cellY=top;
        }else
        {
             cellY=Row+maxYOfCellColum;
        }
        
        CGRect cellFrame=CGRectMake(cellX, cellY, cellW, cellH);
        //self.cellArray = nil;
        [self.cellArray addObject:[NSValue valueWithCGRect:cellFrame]];
        
        //NSLog(@"%ld",self.cellArray.count);
        //更新cell的最大Y值
        //对数组里面的数据更新
        MaxOfColumns[cellColumn]=CGRectGetMaxY(cellFrame);
        //NSLog(@"%f",maxYOfCellColum);
#warning 这三句是我注视的，如果不注释会导致初始化所有的cell
//        MyWaterflowViewCell* cell=[self.dateSource waterFlowView:self cellAtIndex:i];
//        cell.frame=cellFrame;
//        [self addSubview:cell];
        
        
        //NSLog(@"x===%f",cell.frame.origin.x);
         //NSLog(@"y----%f",cell.frame.origin.y);
    }
    
    
    
    
    CGFloat maxY=MaxOfColumns[0];
    for (int a=0; a<intColumnsNumber; a++) {
        if (maxY<MaxOfColumns[a]) {
            maxY=MaxOfColumns[a];
        }
    }
    CGFloat contentH=maxY+Bottom;
#pragma mark 应该是这句话会自动调用layoutSubviews。。所以不加也可以..如果注视下面这句，则刷新无效
    self.contentSize=CGSizeMake(self.frame.size.width, contentH);
    
}

/**
 *UIscroller滚动也会调用这个方法
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger cellNumber=self.cellArray.count;
    //遍历所有的cell得到他们的CGRect，判断是否显示在当前这个页面上
    for (int i=0; i<cellNumber; i++) {
        CGRect cellframe=[self.cellArray[i] CGRectValue];
        //从字典中取cell
        MyWaterflowViewCell* cell=self.disDictionary[@(i)];
        if ([self cellFrame:cellframe]) {//在当前页面上
           
            if (cell==nil) {
                //如果为空，则从数据源方法中创建cell，定义这个cell
                cell=[self.dateSource waterFlowView:self cellAtIndex:i];
#warning 这里添加点击事件和给cell的index赋值；
                UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCell:)];
                [cell addGestureRecognizer:gesture];
                cell.frame=cellframe;
                [self addSubview:cell];
                
                //把每个cell都加入到字典中
                self.disDictionary[@(i)]=cell;
                //NSLog(@"%d---",self.disDictionary.count);
            }
      
            
        }else//不在当前页面上
        {
            if (cell) {
                [cell removeFromSuperview];
                [self.disDictionary removeObjectForKey:@(i)];
                [self.SetSave addObject:cell];
            }
        }
    }
    
    //NSLog(@"subview的个数:%d",self.subviews.count);
}

-(void)clickCell:(UITapGestureRecognizer *)gesture{
    
    //NSLog(@"点击%d",gesture.view.tag);
    
    if ([self.delegate respondsToSelector:@selector(waterFlowView:didSelectRowAtIndexPath:)]) {
        UIView *cellView = gesture.view;
        __block NSInteger index = 0;
        [self.disDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (obj == cellView) {
                index = [key integerValue];
            }
        }];
        [self.delegate waterFlowView:self didSelectRowAtIndexPath:index];
    }
}


/**
 实现从缓存池中取数据
 */
-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier 
{
    __block MyWaterflowViewCell* SaveCell=nil;
    [self.SetSave enumerateObjectsUsingBlock:^(MyWaterflowViewCell* cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            SaveCell=cell;
            *stop=YES;
        }
    }];
    //如果存在则从缓存池中移除
    if (SaveCell) {
        [self.SetSave removeObject:SaveCell];
    }
    return SaveCell;
    
}
/**
 这个方法来判断是否在当前页面上
 */
-(BOOL)cellFrame:(CGRect)cellFrame
{
    return CGRectGetMaxY(cellFrame)>self.contentOffset.y && cellFrame.origin.y<(self.contentOffset.y+self.frame.size.height);
}

#pragma mark 私有方法

-(CGFloat)marginForType:(waterFlowViewMarginType)type
{
    if ([self.delegate respondsToSelector:@selector(waterFlowView:magrnFortype:)]) {
        return [self.delegate waterFlowView:self magrnFortype:type];
    }else
    {
        return marginNumber;
    }
}

-(NSUInteger)numberOfColumns
{
    if ([self.dateSource respondsToSelector:@selector(numberOfColimnsInWaterFlowView:)]) {
        return [self.dateSource numberOfColimnsInWaterFlowView:self];
    }else
    {
        return ColumnsNumber;
    }
}

-(CGFloat)hrightCells:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(waterFlowView:heightForRowAtIndexPath:)]) {
        return [self.delegate waterFlowView:self heightForRowAtIndexPath:index];
    }else
    {
        return CellDefausHeight;
    }
}

@end
