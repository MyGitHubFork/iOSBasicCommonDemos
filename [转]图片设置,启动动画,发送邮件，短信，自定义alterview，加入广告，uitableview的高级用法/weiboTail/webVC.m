//
//  webVC.m
//  weiboTail
//
//  Created by Colin on 14-9-7.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "webVC.h"

@interface webVC ()

@end

@implementation webVC
@synthesize webStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"%@", webStr);
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 320, Screen_height-64)];
    request =[NSURLRequest requestWithURL:[NSURL URLWithString:[webStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [webView setDelegate:self];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    
    [MBProgressHUD showHUDAddedTo:webView animated:YES];

    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//网页加载错误的时候调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:webView animated:YES];
    
}
//网页加载完成的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:webView animated:YES];
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];

    NSRange range=[currentURL rangeOfString:@"http://service.weibo.com/share/mobile.php?"];
    NSLog(@"%@///",currentURL);
    
    if ([currentURL isEqualToString:@"http://widget.weibo.com/public/loginProxy.html"])
    {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[webStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [webView loadRequest:request];
    }
    
    if (range.location!=NSNotFound)
    {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[[webStr stringByAppendingString:@"&mbweb=1" ] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [webView loadRequest:request];
        
        [MBProgressHUD showHUDAddedTo:webView animated:YES];
    }
    
    
}
//网页开始加载的时候调用
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

@end
