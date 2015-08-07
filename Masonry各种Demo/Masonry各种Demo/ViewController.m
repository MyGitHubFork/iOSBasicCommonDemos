//
//  ViewController.m
//  Masonry各种Demo
//
//  Created by yifan on 15/8/7.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MMPlaceHolder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //新建一个view
    UIView *sv = [UIView new];
    [sv showPlaceHolder];
    sv.backgroundColor = [UIColor blackColor];
    //在做autoLayout之前 一定要先将view添加到superview上 否则会报错
    [self.view addSubview:sv];
    //mas_makeConstraints就是Masonry的autolayout添加函数 将所需的约束添加到block中行了
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
