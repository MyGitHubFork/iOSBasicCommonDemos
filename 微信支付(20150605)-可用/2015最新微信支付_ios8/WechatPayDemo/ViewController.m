//
//  ViewController.m
//  WechatPayDemo
//
//  Created by Alvin on 3/22/14.
//  Copyright (c) 2014 Alvin. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"
//#import <MBProgressHUD/MBProgressHUD.h>
#import "WXPayClient.h"

NSString * const HUDDismissNotification = @"HUDDismissNotification";

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUD) name:HUDDismissNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideHUD
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - Action

- (IBAction)pay:(id)sender 
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WXPayClient shareInstance] payProduct];
}
@end
