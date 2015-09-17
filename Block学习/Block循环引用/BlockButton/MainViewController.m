//
//  MainViewController.m
//  BlockButton
//
//  Created by aiteyuan on 14/11/6.
//  Copyright (c) 2014年 黄成都. All rights reserved.
//

#import "MainViewController.h"
#import "BlockButton.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BlockButton *button = [[BlockButton alloc]initWithFrame:CGRectMake(20, 40, 100, 20)];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
#warning 按钮被点击以后，就会调用相应的block实现。
    button.block = ^(BlockButton *btn){
        NSLog(@"按钮被点击了");
        DetailViewController *detail = [[DetailViewController alloc]init];
        [self presentModalViewController:detail animated:YES];
    };
    [self.view addSubview:button];
}


@end
