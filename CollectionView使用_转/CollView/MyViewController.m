//
//  MyViewController.m
//  CollView
//
//  Created by the Hackintosh of XKD on 14-10-20.
//  Copyright (c) 2014年 ZHIYOUEDU. All rights reserved.
//

#import "MyViewController.h"
#import "RootViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    Btn.backgroundColor=[UIColor cyanColor];
    Btn.frame=CGRectMake(80, 80, 100, 40);
    [Btn setTitle:@"返回" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
    
}

-(void)BtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
