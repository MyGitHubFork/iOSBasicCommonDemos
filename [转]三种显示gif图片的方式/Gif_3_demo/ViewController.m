//
//  ViewController.m
//  Gif_3_demo
//
//  Created by idebug QQ群：262091386  on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GifView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //1. 第三方
    // 网络图片
    //  NSData *urlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.chinagif.com/gif/part/boy/0045.gif"]]; 
    
    // 本地图片 
    //NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"f000" ofType:@"gif"]];
     NSData *localData1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"f001" ofType:@"gif"]];
    NSMutableData *thedata = [[NSMutableData alloc]initWithData:localData1];
    [thedata appendData:localData1];
    GifView *dataView = [[GifView alloc] initWithFrame:CGRectMake(0, 0, 200, 100) data:thedata];
    [self.view addSubview:dataView];
    [dataView release];
    
    // 或者
    
//    GifView *pathView =[[GifView alloc] initWithFrame:CGRectMake(100, 0, 100, 100) filePath:[[NSBundle mainBundle] pathForResource:@"run" ofType:@"gif"]];
//    [self.view addSubview:pathView];
//    [pathView release];
    
    //2. webView   
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"f001" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"f001" ofType:@"gif"];
    NSData *gifData1 = [NSData dataWithContentsOfFile:path1];
    NSMutableData *theedata = [[NSMutableData alloc]initWithData:gifData];
    NSLog(@"%lu",(unsigned long)theedata.length);
    [theedata appendData:gifData1];
     NSLog(@"%lu",(unsigned long)theedata.length);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 120, 100, 100)];
     [webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
    webView.scalesPageToFit = YES;
    [webView loadData:theedata MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    [webView release];
    
    //3. animationView
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240, 100, 100)];
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"1"],
                         [UIImage imageNamed:@"2"],
                         [UIImage imageNamed:@"3"],
                         [UIImage imageNamed:@"4"],
                         [UIImage imageNamed:@"5"],
                         [UIImage imageNamed:@"6"],
                         [UIImage imageNamed:@"7"],
                         [UIImage imageNamed:@"8"],
                         [UIImage imageNamed:@"9"],
                         [UIImage imageNamed:@"10"],
                         [UIImage imageNamed:@"11"],
                         [UIImage imageNamed:@"12"],
                         [UIImage imageNamed:@"13"],
                         [UIImage imageNamed:@"14"],
                         [UIImage imageNamed:@"15"],
                         [UIImage imageNamed:@"16"],
                         [UIImage imageNamed:@"17"],
                         [UIImage imageNamed:@"18"],
                         [UIImage imageNamed:@"19"],
                         [UIImage imageNamed:@"20"],
                         [UIImage imageNamed:@"21"],
                         [UIImage imageNamed:@"22"],nil];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 5; //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 999;  //动画重复次数
    [gifImageView startAnimating];
    [self.view addSubview:gifImageView];
    [gifImageView release];
}
    

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
