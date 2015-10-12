//
//  ViewController.m
//  七牛上传下载Demo
//
//  Created by maiyun on 15/4/2.
//  Copyright (c) 2015年 yifan. All rights reserved.
//

#import "ViewController.h"
#import "QNUploadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    // Your Token Here, See: http://developer.qiniu.com/docs/v6/api/reference/security/upload-token.html
    //这里填入你自己的七牛token
    NSString *token = @"yPwTOJsk52Ggl3eG_cHdfasfasdfasdfasDPn:p00_MfLCK1bn2pFbdBpoGyzOeasdfasdSI6ImFwcGltYWdlcyIsImRlYWRsaW5lIjozMjA1OTU4MTE0fQ==";
    
    // Load Local Image
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pixar" ofType:@"jpeg"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", [self getDateTimeString], [self randomStringWithLength:8]];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    //上传
//    [upManager putData:data
//                   key:fileName
//                 token:token
//              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                  
//                  NSLog(@" --->> Info: %@  ", info);
//                  NSLog(@" ---------------------");
//                  NSLog(@" --->> Response: %@,  ", resp);
//              }
//                option:nil];

    
    NSString *urlStr=[NSString stringWithFormat:@"http://7xidnq.com1.z0.gasdfasdfaddn.com/%@",@"2015-04-02_14:44:11_k9oMTJbU.jpg"];
    //注意对于url中的中文是无法解析的，需要进行url编码(指定编码类型位utf-8)
    //另外注意url解码使用stringByRemovingPercentEncoding方法
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //创建url链接
    NSURL *url=[NSURL URLWithString:urlStr];
    
    /*创建可变请求*/
    NSMutableURLRequest *requestM=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:60.0f];
    
    //发送一个异步请求
    [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *homeDir = NSHomeDirectory();
        NSString *thepath = [homeDir stringByAppendingPathComponent:@"xx.png"];
        NSLog(@"%@",thepath);
        [data writeToFile:thepath atomically:YES];
        
    }];

}



#pragma mark - Helpers

- (NSString *)getDateTimeString
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}


- (NSString *)randomStringWithLength:(int)len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
