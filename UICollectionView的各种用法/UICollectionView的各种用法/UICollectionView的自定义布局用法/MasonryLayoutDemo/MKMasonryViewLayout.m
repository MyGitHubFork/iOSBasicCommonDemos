//
//  MKMasonryViewLayout.m
//  RedMart
//
//  Created by Mugunth on 20/9/13.
//  Copyright (c) 2013 Redmart Pte Ltd. All rights reserved.
//

#import "MKMasonryViewLayout.h"

@interface MKMasonryViewLayout (/*Private Methods*/)
@property (nonatomic, strong) NSMutableDictionary *lastYValueForColumn;
@property (strong, nonatomic) NSMutableDictionary *layoutInfo;
@end

@implementation MKMasonryViewLayout

#pragma mark 在开始布局之前调用。在这里设置列的个数、计算各种值。
-(void) prepareLayout {
  //三竖
  self.numberOfColumns = 2;
  //间隔
  self.interItemSpacing = 1;
  
  self.lastYValueForColumn = [NSMutableDictionary dictionary];
  CGFloat currentColumn = 0;
  CGFloat fullWidth = self.collectionView.frame.size.width;
  CGFloat availableSpaceExcludingPadding = fullWidth - (self.interItemSpacing * (self.numberOfColumns + 1));
  CGFloat itemWidth = availableSpaceExcludingPadding / self.numberOfColumns;
  self.layoutInfo = [NSMutableDictionary dictionary];
  NSIndexPath *indexPath;
  NSInteger numSections = [self.collectionView numberOfSections];
  
  for(NSInteger section = 0; section < numSections; section++)  {
    
    NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
    for(NSInteger item = 0; item < numItems; item++){
      indexPath = [NSIndexPath indexPathForItem:item inSection:section];
      
      UICollectionViewLayoutAttributes *itemAttributes =
      [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
      
      CGFloat x = self.interItemSpacing + (self.interItemSpacing + itemWidth) * currentColumn;
      CGFloat y = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
      
      CGFloat height = [((id<MKMasonryViewLayoutDelegate>)self.collectionView.delegate)
                        collectionView:self.collectionView
                        layout:self
                        heightForItemAtIndexPath:indexPath];
      
      itemAttributes.frame = CGRectMake(x, y, itemWidth, height);
      y+= height;
      y += self.interItemSpacing;
      
      self.lastYValueForColumn[@(currentColumn)] = @(y);
      
      currentColumn ++;
      if(currentColumn == self.numberOfColumns) currentColumn = 0;
        //存储每一个item的位置信息
      self.layoutInfo[indexPath] = itemAttributes;
    }
  }
}
#pragma mark 当collectionView开始滚动的时候，调用这个方法。
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
  
  NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
  
  [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                       UICollectionViewLayoutAttributes *attributes,
                                                       BOOL *stop) {
    //可以判断矩形结构是否交叉，两个矩形对象是否重叠
    if (CGRectIntersectsRect(rect, attributes.frame)) {
      [allAttributes addObject:attributes];
    }
  }];
  return allAttributes;
}


#pragma mark 计算collectionView的ContentSize
-(CGSize) collectionViewContentSize {
  
  NSUInteger currentColumn = 0;
  CGFloat maxHeight = 0;
  do {
    CGFloat height = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
    if(height > maxHeight)
      maxHeight = height;
    currentColumn ++;
  } while (currentColumn < self.numberOfColumns);
  
  return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}

@end
