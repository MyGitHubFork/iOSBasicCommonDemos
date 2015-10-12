//
//  WaterFlowCellView.h
//  瀑布流
//
//  Created by aiteyuan on 14-10-20.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFlowCellView : UIView
{
    UITableViewCell *_cell;
}
//可重用标示符，以便可以在缓冲池中找到可重用单元格。
@property(strong,nonatomic)NSString *reuseIdentifier;
//图像视图
@property(strong,nonatomic) UIImageView *imageView;
//文字标签
@property(strong, nonatomic) UILabel *textLable;
//选中标记
@property(assign,nonatomic)BOOL Selected;
//使用可重用标示符，实例化单元格
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
#warning 属性会默认生成一个带下划线的成员变量。
@end
