//
//  KCMainViewController.m
//  URLSession
//
//  Created by Kenshin Cui on 14-03-23.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCMainViewController.h"

@interface KCMainViewController ()

@end

@implementation KCMainViewController

#pragma mark - UI方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self loadJsonData];
    
    [self uploadFile];
    
//    [self downloadFile];

}

//#pragma mark 请求数据
//-(void)loadJsonData{
//    //1.创建url
//    NSString *urlStr=[NSString stringWithFormat:@"http://192.168.1.208/ViewStatus.aspx?userName=%@&password=%@",@"KenshinCui",@"123"];
//    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    //2.创建请求
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    
//    //3.创建会话（这里使用了一个全局会话，也可以自己创建一个会话）并且启动任务
//    NSURLSession *session=[NSURLSession sharedSession];
//    //从会话创建任务
//    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (!error) {
//            NSString *dataStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",dataStr);
//        }else{
//            NSLog(@"error is :%@",error.localizedDescription);
//        }
//    }];
//    
//    [dataTask resume];//恢复线程，启动任务
//}

#pragma mark 取得mime types
-(NSString *)getMIMETypes:(NSString *)fileName{
    return @"image/jpg";
}
#pragma mark 取得数据体
-(NSData *)getHttpBody:(NSString *)fileName{
    NSString *boundary=@"KenshinCui";
    NSMutableData *dataM=[NSMutableData data];
    NSString *strTop=[NSString stringWithFormat:@"--%@\nContent-Disposition: form-data; name=\"file1\"; filename=\"%@\"\nContent-Type: %@\n\n",boundary,fileName,[self getMIMETypes:fileName]];
    NSString *strBottom=[NSString stringWithFormat:@"\n--%@--",boundary];
    NSString *filePath=[[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *fileData=[NSData dataWithContentsOfFile:filePath];
    [dataM appendData:[strTop dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:fileData];
    [dataM appendData:[strBottom dataUsingEncoding:NSUTF8StringEncoding]];
    return dataM;
}
//#pragma mark 上传文件
//-(void)uploadFile{
//    NSString *fileName=@"pic.jpg";
//    //1.创建url
//    NSString *urlStr=@"http://192.168.1.208/FileUpload.aspx";
//    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    //2.创建请求
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod=@"POST";
//    
//    //3.构建数据
//    NSString *path=[[NSBundle mainBundle] pathForResource:fileName ofType:nil];
//    NSData *data=[self getHttpBody:fileName];
//    request.HTTPBody=data;
//    
//    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
//    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"KenshinCui"] forHTTPHeaderField:@"Content-Type"];
//    
//    
//
//    //4.创建会话
//    NSURLSession *session=[NSURLSession sharedSession];
//    
//    NSURLSessionUploadTask *uploadTask=[session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (!error) {
//            NSString *dataStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",dataStr);
//        }else{
//            NSLog(@"error is :%@",error.localizedDescription);
//        }
//    }];
//    
//    [uploadTask resume];
//}

#pragma mark 上传文件2
-(void)uploadFile{
    NSString *fileName=@"pic.jpg";
    NSString *path=[[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:path];
    
    //1.创建url
    NSString *urlStr=@"http://192.168.1.208/FileUpload.aspx";//放到虚拟目录Upload下
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    //2.创建请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"PUT";//注意这里配置PUT方法
    
    
    
//    NSString *authStr = @"kenshincui:123456";
//    // 2> result = 对字符串进行BASE64编码(网络传输中常用的一种编码格式,NSData)
//    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *result = [authData base64EncodedStringWithOptions:0];
//    // 3> "Basic result" => 提交给服务器的验证字符串,用来验证身份
//    NSString *authString = [NSString stringWithFormat:@"Basic %@", result];
//    
//    // 设置HTTP请求头的数值,设置用户授权
//    [request setValue:authString forHTTPHeaderField:@"Authorization"];
    
    
    
    
    
    
    //3.创建会话
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask=[session uploadTaskWithRequest:request fromFile:fileUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSString *dataStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",dataStr);
        }else{
            NSLog(@"error is :%@",error.localizedDescription);
        }
    }];
    
    [uploadTask resume];
}


//#pragma mark 文件下载
//-(void)downloadFile{
//    //1.创建url
//    NSString *fileName=@"1.jpg";
//    NSString *urlStr=[NSString stringWithFormat: @"http://192.168.1.208/FileDownload.aspx?file=%@",fileName];
//    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    //2.创建请求
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    
//    //3.创建会话（这里使用了一个全局会话，也可以自己创建一个会话）并且启动任务
//    NSURLSession *session=[NSURLSession sharedSession];
//    
//    NSURLSessionDownloadTask *downloadTask=[session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        if (!error) {
//            //注意location是下载后的临时报错路径,需要将它移动到需要保存的位置
//            
//            NSError *saveError;
//            NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            NSString *savePath=[cachePath stringByAppendingPathComponent:fileName];
//            NSLog(@"%@",savePath);
//            NSURL *saveUrl=[NSURL fileURLWithPath:savePath];
//            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
//            if (!saveError) {
//                NSLog(@"save sucess.");
//            }else{
//                NSLog(@"error is :%@",saveError.localizedDescription);
//            }
//            
//        }else{
//            NSLog(@"error is :%@",error.localizedDescription);
//        }
//    }];
//    
//    [downloadTask resume];
//}
@end
