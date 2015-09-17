//
//  WaterFlowCellView.m
//  瀑布流
//
//  Created by aiteyuan on 14-10-20.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#import "WaterFlowCellView.h"

#define kWaterFlowCellMargin 5.0
#define kWaterFlowCellFont [UIFont systemFontOfSize:14.0]

@implementation WaterFlowCellView

#pragma mark 实例化视图
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super init];
    if (self) {
        //使用属性记录可重用标示符
        self.reuseIdentifier = reuseIdentifier;
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
}


//以下是在自定义视图中实现懒加载方式
//可以用控件的getter
#pragma mark -imageview  getter方法
-(UIImageView *)imageView
{
    //懒加载imageview
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        
#warning 图像按比例显示
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_imageView];
    }
    return _imageView;
}
#pragma mark -textLable  getter方法
-(UILabel *)textLable
{
    if (_textLable == nil) {
        _textLable = [[UILabel alloc]init];
        //设置背景颜色,colorWithAlphaComponent设置透明度
        [_textLable setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
        //设置对其方式
        [_textLable setTextAlignment:NSTextAlignmentCenter];
        //设置文本自动换行
        [self.textLable setNumberOfLines:0];
        //设置文字颜色
        [_textLable setTextColor:[UIColor whiteColor]];
        //[self addSubview:_textLable];
#warning 这样就能保证textlable在imageview的上面。
        [self insertSubview:_textLable aboveSubview:self.imageView];
    }
    return _textLable;
}

#pragma mark 使用视图重写布局
-(void)layoutSubviews
{
#warning 因为本视图继承自UIView,UIView本身不包含任何控件，所以在此可以省略layoutSubviews方法。
    [super layoutSubviews];
    
    //1设置imageview的大小和位置
    //CGRectInset该结构体的应用是以原rect为中心，再参考dx，dy，进行缩放或者放大。
    [self.imageView setFrame:CGRectInset(self.bounds, kWaterFlowCellMargin, kWaterFlowCellMargin)];
    //2设置textlable的位置和大小
    //1)当前文本内容
    NSString *str = self.textLable.text;
    //2）计算文本需要的大小
    CGFloat w = self.bounds.size.width - (2 * kWaterFlowCellMargin);
#warning 计算textLabel的高度
    CGSize textSize = [str sizeWithFont:kWaterFlowCellFont constrainedToSize:CGSizeMake(w, 10000)];
    CGFloat h = textSize.height;
    //3)如果文本高度超过图像的一半，限定只显示一半高度
    if (h > self.bounds.size.height / 2.0) {
        h = self.bounds.size.height / 2.0;
    }
    CGFloat y = self.bounds.size.height - h - kWaterFlowCellMargin;
    [self.textLable setFrame:CGRectMake(kWaterFlowCellMargin, y, w, h)];
    
}
@end
