//
//  ViewController.m
//  按钮旋转
//
//  Created by maiyun on 15/3/27.
//  Copyright (c) 2015年 maiyun. All rights reserved.
//

#import "ViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
///ImageView旋转状态枚举
typedef enum {
    RotateStateStop,
    RotateStateRunning,
}RotateState;


@interface ViewController ()
{
    ///旋转角度
    CGFloat imageviewAngle;
    ///旋转ImageView
    UIImageView *imageView;
    ///旋转状态
    RotateState rotateState;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"按钮旋转测试";
    [self buildBarButtonItem];
}

#pragma mark  添加 RightBarButtonItem
-(void)buildBarButtonItem{
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.bounds=CGRectMake(0, 0, 40, 40);
    //设置视图为圆形
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=20.f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addSubview:imageView];
    [button addTarget:self action:@selector(animate) forControlEvents:UIControlEventTouchUpInside];
    imageView.center = button.center;
    //设置RightBarButtonItem
    UIBarButtonItem  *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barItem;
}
#pragma mark  点击 RightBarButtonItem
- (void)animate {
    //改变ImageView旋转状态
    if (rotateState==RotateStateStop) {
        rotateState=RotateStateRunning;
        [self rotateAnimate];
    }else{
        rotateState=RotateStateStop;
    }
}
#pragma mark 旋转动画
-(void)rotateAnimate{
    imageviewAngle+=50;
    //0.5秒旋转50度
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(imageviewAngle));
    } completion:^(BOOL finished) {
        if (rotateState==RotateStateRunning) {
            [self rotateAnimate];
        }
    }];
}

@end
