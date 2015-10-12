//
//  ViewController.m
//  WebService测试
//
//  Created by maiyun on 15/4/8.
//  Copyright (c) 2015年 yifan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
{
    NSMutableData *webData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<Category xmlns=\"http://tempuri.org/\">\n"
                             "<cId>%@</cId>\n"
                             "</Category>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",@"1"
                             ];
    //NSLog(soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.188:8007/PC_API/ItemService.svc?wsdl"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/IItemService/Category" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    [theConnection start];

}


-(void)getrequest{
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<WapLoginObj xmlns=\"http://tnzx.jxehe.com/\">\n"
                             "<Username>%@</Username>\n"
                             "<Password>%@</Password>\n"
                             "</WapLoginObj>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",@"name",@"password"
                             ];
    //NSLog(soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://tnzx.jxehe.com/wapwb.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tnzx.jxehe.com/WapLoginObj" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    [theConnection start];

}

#pragma mark NSURLConnectionDataDelegate协议
//这个方法可用来判断请求是否成功
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    webData = [NSMutableData data];//初始化webData
    [webData setLength: 0];
    NSLog(@"请求成功了");
}
//得到请求成功的数据，这里可以用来存储请求到的数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    //MyLog(@"返回的数据是%@", data);
    NSLog(@"请求数据存储");
    
}
//如果电脑没有连接网络，则出现此信息（不是网络服务器不通）
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知"
                                                    message:@"登陆失败"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
//当请求成功结束以后，可以在这个方法里面实现对数据的处理。
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //MyLog(@"开始处理请求的数据: %d", [webData length]);
    NSLog(@"%@",[[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding]);
}


@end
