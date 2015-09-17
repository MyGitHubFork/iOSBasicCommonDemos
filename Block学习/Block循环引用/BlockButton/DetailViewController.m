//
//  DetailViewController.m
//  BlockButton
//
//  Created by aiteyuan on 14/11/6.
//  Copyright (c) 2014年 黄成都. All rights reserved.
//

#import "DetailViewController.h"
#import "BlockButton.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    
#warning 在ARC中这个方式好像没用。
    
    
    BlockButton *button = [[BlockButton alloc]initWithFrame:CGRectMake(20, 40, 100, 20)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
#warning 如果用self这里会导致block与DetailViewController循环引用。
    //使用__block修饰局部变量，block不会将此变量retain
    __block UIViewController *viewcontroller = self;
    button.block = ^(BlockButton *btn){
        NSLog(@"Detail按钮被点击了");
        //用self会让block将当前对象retain一下，因为访问了当前对象的方法。如果用viewcontroller则不会retain一下。
        [viewcontroller dismissModalViewControllerAnimated:YES];
    };
//DetailViewController.view 持有button，button持有block，block持有DetailViewController，造成一个闭环。
    [self.view addSubview:button];
}

-(void)dealloc
{
    NSLog(@"DetailViewController被销毁");
}

@end
