//
//  ViewController.m
//  debug测试
//
//  Created by maiyun on 15/3/16.
//  Copyright (c) 2015年 maidong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#ifdef IPAD
    NSLog(@"HAHAHHA");
#endif
    
#if 2 > 3
    NSLog(@"2>3");
#else
    NSLog(@"2<=3");
#endif
    
#if DEBUG 
    NSLog(@"DEBUG");
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
