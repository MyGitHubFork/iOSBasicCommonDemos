//
//  CTColumnView.h
//  CoreText杂志应用
//
//  Created by yifan on 15/8/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTColumnView : UIView
{
    id ctFrame;
    NSMutableArray* images;
}
@property (retain, nonatomic) NSMutableArray* images;
-(void)setCTFrame:(id)f;
@end
