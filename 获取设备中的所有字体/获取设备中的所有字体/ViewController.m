//
//  ViewController.m
//  获取设备中的所有字体
//
//  Created by maiyun on 15/6/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"字体族：%@",familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\t字体：%@",fontName);
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
