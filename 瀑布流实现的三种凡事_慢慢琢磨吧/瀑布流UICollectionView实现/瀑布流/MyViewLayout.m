//
//  MyViewLayout.m
//  瀑布流
//
//  Created by 修斌 on 15/7/14.
//  Copyright (c) 2015年 handaowei. All rights reserved.
//

#import "MyViewLayout.h"
@interface MyViewLayout();
/**这个字典用来储存每一列最大的Y值(每一列的高度)*/
@property(nonatomic,strong)NSMutableDictionary* maxYDict;
@property(nonatomic,strong)NSMutableArray* array;
@end
@implementation MyViewLayout
-(NSMutableDictionary *)maxYDict
{
    if (_maxYDict==nil) {
        _maxYDict=[NSMutableDictionary dictionary];
        
    }
    return _maxYDict;
}
-(NSMutableArray *)array
{
    if (_array==nil) {
        _array=[NSMutableArray array];
    }
    return _array;
}

-(instancetype)init
{
    if (self=[super init]) {
        self.columiMargin=10;
        self.rowMargin=10;
        self.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount=3;
    }
    return self;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


-(void)prepareLayout
{
    
    [super prepareLayout];
    //给每个字典里面的y值先初始化
    for (int i=0; i<self.columnsCount; i++) {
        NSString* colume=[NSString stringWithFormat:@"%d",i];
        self.maxYDict[colume]=@0;
    }
   
    [self.array removeAllObjects];
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        UICollectionViewLayoutAttributes* attrs=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.array addObject:attrs];
    }
}
//
-(CGSize)collectionViewContentSize
{
   

    __block NSString* maxColum=@"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString* colum, NSNumber* maxY, BOOL *stop) {
        if ([maxY floatValue]>[self.maxYDict[maxColum] floatValue]) {
            maxColum=colum;
        }
        
    }];
    return CGSizeMake(0, [self.maxYDict[maxColum] floatValue]);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //假设最短的那一列的第0列
    __block NSString* minColum=@"0";
    //找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString* colum, NSNumber* maxY, BOOL *stop) {
        if ([maxY floatValue]<[self.maxYDict[minColum] floatValue]) {
            minColum=colum;
        }
        
    }];
    
    //计算尺寸
    CGFloat width=(self.collectionView.frame.size.width-self.sectionInset.left-self.sectionInset.right-(self.columnsCount-1)*self.columiMargin)/self.columnsCount;
    
    //CGFloat height=100+arc4random_uniform(100);
    CGFloat height=[self.delegate waterflowlayout:self heightForWidth:width atIndexpath:indexPath];
    //计算位置
    CGFloat x=self.sectionInset.left+(width+self.columiMargin)*[minColum intValue];

    CGFloat y=[self.maxYDict[minColum] floatValue]+self.rowMargin;
    
   //更新这一列的最大Y值
    self.maxYDict[minColum]=@(y+height);
    //创建属性
    UICollectionViewLayoutAttributes* attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame=CGRectMake(x, y, width, height);
    return attrs;
  
    
    
}
/**
 *  返回rect布局内的属性
 */
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{

    return self.array;
}















@end
