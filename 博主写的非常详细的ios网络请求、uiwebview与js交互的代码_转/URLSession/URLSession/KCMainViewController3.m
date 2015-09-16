////
////  KCMainViewController.m
////  URLSession
////
////  Created by Kenshin Cui on 14-03-23.
////  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
////
//
//#import "KCMainViewController.h"
//#import "AppDelegate.h"
//
//@interface KCMainViewController ()<NSURLSessionDownloadDelegate>{
//    NSURLSessionDownloadTask *_downloadTask;
//    NSString *_fileName;
//}
//
//@end
//
//@implementation KCMainViewController
//
//#pragma mark - UI方法
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self downloadFile];
//}
//
//#pragma mark 取得一个后台会话(保证一个后台会话，这通常很有必要)
//-(NSURLSession *)backgroundSession{
//    static NSURLSession *session;
//    static dispatch_once_t token;
//    dispatch_once(&token, ^{
//        NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.cmjstudio.URLSession"];
//        sessionConfig.timeoutIntervalForRequest=5.0f;//请求超时时间
//        sessionConfig.discretionary=YES;//系统自动选择最佳网络下载
//        sessionConfig.HTTPMaximumConnectionsPerHost=5;//限制每次最多一个连接
//        //创建会话
//        session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];//指定配置和代理
//    });
//    return session;
//}
//
//#pragma mark 文件下载
//-(void)downloadFile{
//    _fileName=@"1.mp4";
//    NSString *urlStr=[NSString stringWithFormat: @"http://192.168.1.208/FileDownload.aspx?file=%@",_fileName];
//    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    
//    //后台会话
//    _downloadTask=[[self backgroundSession] downloadTaskWithRequest:request];
//    
//    [_downloadTask resume];
//}
//#pragma mark - 下载任务代理
//#pragma mark 下载中(会多次调用，可以记录下载进度)
//-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
////    [NSThread sleepForTimeInterval:0.5];
////    NSLog(@"%.2f",(double)totalBytesWritten/totalBytesExpectedToWrite);
//}
//
//#pragma mark 下载完成
//-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
//    NSError *error;
//    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *savePath=[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSDate date]]];
//    NSLog(@"%@",savePath);
//    NSURL *saveUrl=[NSURL fileURLWithPath:savePath];
//    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&error];
//    if (error) {
//        NSLog(@"didFinishDownloadingToURL:Error is %@",error.localizedDescription);
//    }
//}
//
//#pragma mark 任务完成，不管是否下载成功
//-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
//    if (error) {
//        NSLog(@"DidCompleteWithError:Error is %@",error.localizedDescription);
//    }
//}
//@end
