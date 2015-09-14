//
//  ViewController.m
//  用runtime 解决UIButton 重复点击问题
//
//  Created by yifan on 15/9/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+HCDControlCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = CGRectMake(100, 100, 30, 30);
    tempBtn.backgroundColor = [UIColor greenColor];
    [tempBtn addTarget:self action:@selector(clickWithInterval:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.uxy_acceptEventInterval = 2.5;
    
    [self.view addSubview:tempBtn];
}

#pragma mark 这里其实就是调用我们自定义的那个方法。
-(void)clickWithInterval:(UIButton *)sender{
    NSLog(@"你现在能点哥了。");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
