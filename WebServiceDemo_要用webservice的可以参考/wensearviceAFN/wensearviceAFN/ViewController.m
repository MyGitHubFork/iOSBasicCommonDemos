//
//  ViewController.m
//  wensearviceAFN
//
//  Created by maiyun on 15/4/8.
//  Copyright (c) 2015年 yifan. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "GDataXMLNode.h"



@interface ViewController ()<NSXMLParserDelegate>
@property (strong, nonatomic) NSMutableString *elementString;
@property (strong, nonatomic) NSString *soapName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestWithName:@"Category" parameters:@{@"cId":@"1"}];
}

-(void)requestWithName:(NSString *)name parameters:(NSDictionary *)parameters{
    self.soapName = name;
    NSMutableString *soapMessage = [NSMutableString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<%@ xmlns=\"http://tempuri.org/\">\n"
                             ,name
                             ];
    NSArray *allKeys = [parameters allKeys];
    for (int index = 0; index < allKeys.count; index++) {
        [soapMessage appendString:[NSString stringWithFormat:@"<%@>%@</%@>\n",allKeys[index],parameters[allKeys[index]],allKeys[index]]];
    }
    [soapMessage appendString:[NSString stringWithFormat:@"</%@>\n",name]];
    [soapMessage appendString:@"</soap:Body>\n"];
    [soapMessage appendString:@"</soap:Envelope>\n"];
    //NSLog(@"%@",soapMessage);
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.188:8007/PC_API/ItemService.svc?wsdl"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    [request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request addValue: [NSString stringWithFormat:@"http://tempuri.org/IItemService/%@",name] forHTTPHeaderField:@"SOAPAction"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData: responseObject];
        [xmlParser setDelegate: self];//设置xml解析协议
        [xmlParser setShouldResolveExternalEntities: YES];
        [xmlParser parse];//这里调用协议方法开始解析xml数据
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [operation start];
}


#pragma mark NSXMLParserDelegate协议
//开始解析xml数据
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    //NSLog(@"-------------------start--------------");
    self.elementString = [NSMutableString string];
}
//开始解析节点，，这是一个树形结构，，
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    [self.elementString setString:@""];
}
//这里可以得到需要的数值。
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.elementString appendString:string];
    
}
//结束一个节点的解析，这是一个从内到外的反树形结构
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//    if ([elementName isEqualToString:]) {
//        NSLog(@"%@",self.elementString);
//    }
}

//解析出错
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了"
                                                    message:@"哦..出错了"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//结束xml数据解析
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"%@",self.elementString);
}


@end
