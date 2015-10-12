//
//  ViewController.m
//  纯代码自动布局
//
//  Created by maidong on 15/3/11.
//  Copyright (c) 2015年 maidong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button=[[UIButton alloc]init];
    [button setTitle:@"点击一下" forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:button];
    
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)];
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[button(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)];
    [self.view addConstraints:constraints1];
    [self.view addConstraints:constraints2];
 
    UIButton *button1=[[UIButton alloc]init];
    button1.translatesAutoresizingMaskIntoConstraints=NO;
    [button1 setTitle:@"请不要点击我" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button1];
    //---------------------------------------------------------------------
    //button1距离父视图的水平方向的距离是20
    //NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button1]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button1)];
    //button1距离button的Y坐标是8.高度是30
    //NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-[button1(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button,button1)];
    //NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-[button1(==height)]" options:0 metrics:@{@"height":@30} views:NSDictionaryOfVariableBindings(button,button1)];
    //---------------------------------------------------------------------
    //水平方向button1和button一样的宽度
    NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button1(button)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button,button1)];
    //button1距离button的Y坐标是8.且高度和button1一样
    //NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-[button1(button)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button,button1)];
    //指定同级的button和button1之间的竖直方向的距离50.并且高度相同
    NSArray *constraints5 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-50-[button1(button)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button,button1)];
    [self.view addConstraints:constraints3];
    //[self.view addConstraints:constraints4];
    [self.view addConstraints:constraints5];

    
    
}




@end
