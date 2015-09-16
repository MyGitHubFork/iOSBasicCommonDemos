//
//  KCMainViewController.m
//  Network status
//
//  Created by Kenshin Cui on 14-3-22.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCMainViewController.h"
#import "AFNetworking.h"

@interface KCMainViewController ()<NSURLConnectionDataDelegate>

@end

@implementation KCMainViewController

#pragma mark - UI方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkNetworkStatus];
    
}

#pragma mark - 私有方法
#pragma mark 网络状态变化提示
-(void)alert:(NSString *)message{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"System Info" message:message delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark 网络状态监测
-(void)checkNetworkStatus{
    //创建一个用于测试的url
    NSURL *url=[NSURL URLWithString:@"http://www.apple.com"];
    AFHTTPRequestOperationManager *operationManager=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];

    //根据不同的网络状态改变去做相应处理
    [operationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self alert:@"2G/3G/4G Connection."];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self alert:@"WiFi Connection."];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [self alert:@"Network not found."];
                break;
                
            default:
                [self alert:@"Unknown."];
                break;
        }
    }];
    
    //开始监控
    [operationManager.reachabilityManager startMonitoring];
}
@end






