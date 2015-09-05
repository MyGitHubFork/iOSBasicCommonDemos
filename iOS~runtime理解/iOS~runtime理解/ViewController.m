//
//  ViewController.m
//  iOS~runtime理解
//
//  Created by 黄成都 on 15/9/4.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

#warning http://www.jianshu.com/p/927c8384855a
@interface ViewController ()
{
    NSString *varusString;
}
@property(nonatomic,strong)NSString *customproperty;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property------>%@",[NSString stringWithUTF8String:propertyName]);
    }
    //获取方法列表
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
