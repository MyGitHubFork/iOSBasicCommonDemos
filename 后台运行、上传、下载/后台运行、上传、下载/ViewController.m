//
//  ViewController.m
//  后台运行、上传、下载
//
//  Created by 黄成都 on 15/8/4.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#define Picture @"http://www.xf0573.com/attached/131702/qyxx/infrel/img/131702_20140929104216_7427.jpg"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [[NSURL alloc]initWithString:Picture];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return ;
        }
        self.imageview.image = [UIImage imageWithData:data];
    }];
    
    [task resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
