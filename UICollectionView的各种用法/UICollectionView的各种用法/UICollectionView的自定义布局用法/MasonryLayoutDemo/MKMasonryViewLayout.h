//
//  MKMasonryViewLayout.h
//  RedMart
//
//  Created by Mugunth on 20/9/13.
//  Copyright (c) 2013 Redmart Pte Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMasonryViewLayout;

@protocol MKMasonryViewLayoutDelegate <NSObject>
@required
- (CGFloat) collectionView:(UICollectionView*) collectionView
                   layout:(MKMasonryViewLayout*) layout
 heightForItemAtIndexPath:(NSIndexPath*) indexPath;
@end

@interface MKMasonryViewLayout : UICollectionViewLayout
@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) CGFloat interItemSpacing;
@property (weak, nonatomic) IBOutlet id<MKMasonryViewLayoutDelegate> delegate;
@end
