//
//  ViewController.m
//  CoreTextDemo_mine
//
//  Created by yifan on 15/8/19.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "HCDFrameParser.h"
#import "HCDCoreTextData.h"
#import "HCDFrameParserConfig.h"
#import "HCDDisplayView.h"
#warning 参考博客地址：http://blog.devtang.com/blog/2015/06/27/using-coretext-1/
@interface ViewController ()
@property (weak, nonatomic) IBOutlet HCDDisplayView *ctVuew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HCDFrameParserConfig *config = [[HCDFrameParserConfig alloc] init];
    config.textColor = [UIColor redColor];
    config.width = self.ctVuew.width;
    
    HCDCoreTextData *data = [HCDFrameParser parseContext:@" 按照以上原则，我们将`CTDisplayView`中的部分内容拆开。" config:config];
    self.ctVuew.data = data;
    //设置view的高度
    self.ctVuew.height = data.height;
    self.ctVuew.backgroundColor = [UIColor yellowColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
