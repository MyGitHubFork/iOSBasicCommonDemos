//
//  CTView.h
//  CoreText杂志应用
//
//  Created by yifan on 15/8/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "CTColumnView.h"
@interface CTView : UIScrollView<UIScrollViewDelegate>
{
    float frameXOffset;
    float frameYOffset;
    
    NSAttributedString* attString;
    
    NSMutableArray* frames;
    
    NSArray* images;
}
@property (retain, nonatomic) NSAttributedString* attString;
@property (retain, nonatomic) NSMutableArray* frames;
@property (retain, nonatomic) NSArray* images;
- (void)buildFrames;
-(void)setAttString:(NSAttributedString *)attString withImages:(NSArray*)imgs;
-(void)attachImagesWithFrame:(CTFrameRef)f inColumnView:(CTColumnView*)col;
@end
