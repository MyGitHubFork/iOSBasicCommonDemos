//
//  MyViewLayout.h
//  瀑布流
//
//  Created by 修斌 on 15/7/14.
//  Copyright (c) 2015年 handaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyViewLayout;
@protocol MyViewLayoutDelegate <NSObject>

-(CGFloat)waterflowlayout:(MyViewLayout*)waterflowLayout heightForWidth:(CGFloat)width atIndexpath:(NSIndexPath*)indexpath;

@end
@interface MyViewLayout : UICollectionViewLayout
/**每列的间距*/
@property(nonatomic,assign)CGFloat columiMargin;
/**每行的间距*/
@property(nonatomic,assign)CGFloat rowMargin;
/**整个内容与view的间距*/
@property(nonatomic,assign)UIEdgeInsets sectionInset;
/**几列*/
@property(nonatomic,assign)CGFloat columnsCount;

@property(nonatomic,strong)id<MyViewLayoutDelegate> delegate;
@end
