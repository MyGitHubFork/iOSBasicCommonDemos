
//
//  KCMainViewController.m
//  UIWebView
//
//  Created by Kenshin Cui on 14-3-22.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCMainViewController.h"

@interface KCMainViewController ()<UISearchBarDelegate,UIWebViewDelegate>{
    UIWebView *_webView;
}

@end

@implementation KCMainViewController
#pragma mark - 界面UI事件
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
    
    [self request];
}

#pragma mark - 私有方法
#pragma mark 界面布局
-(void)layoutUI{
    /*添加浏览器控件*/
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    _webView.dataDetectorTypes=UIDataDetectorTypeAll;//数据监测类型，例如内容中有邮件地址，点击之后可以打开邮件软件编写邮件
    _webView.delegate=self;
    [self.view addSubview:_webView];
}
#pragma mark 显示actionsheet
-(void)showSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitle{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitle, nil];
    [actionSheet showInView:self.view];
}
#pragma mark 浏览器请求
-(void)request{
    //加载html内容
    NSString *htmlStr=@"<html>\
            <head><title>Kenshin Cui's Blog</title></head>\
            <body style=\"color:#0092FF;\">\
                <h1 id=\"header\">I am Kenshin Cui</h1>\
                <p id=\"blog\">iOS 开发系列</p>\
            </body></html>";
    
    //加载请求页面
    [_webView loadHTMLString:htmlStr baseURL:nil];
    
}

#pragma mark - WebView 代理方法
#pragma mark 页面加载前(此方法返回false则页面不再请求)
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([request.URL.scheme isEqual:@"kcactionsheet"]) {
        NSString *paramStr=request.URL.query;
        NSArray *params= [[paramStr stringByRemovingPercentEncoding] componentsSeparatedByString:@"&"];
        id otherButton=nil;
        if (params.count>3) {
            otherButton=params[3];
        }
        [self showSheetWithTitle:params[0] cancelButtonTitle:params[1] destructiveButtonTitle:params[2] otherButtonTitles:otherButton];
        return false;
    }
    return true;
}

#pragma mark 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //显示网络请求加载
    [UIApplication sharedApplication].networkActivityIndicatorVisible=true;
}

#pragma mark 加载完毕
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //隐藏网络请求加载图标
    [UIApplication sharedApplication].networkActivityIndicatorVisible=false;

    //加载js文件
    NSString *path=[[NSBundle mainBundle] pathForResource:@"MyJs.js" ofType:nil];
    NSString *jsStr=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js文件到页面
    [_webView stringByEvaluatingJavaScriptFromString:jsStr];
}
#pragma mark 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error detail:%@",error.localizedDescription);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"系统提示" message:@"网络连接发生错误!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

@end
