//
//  UPViewController.m
//  UPPayDemo
//
//  Created by liwang on 12-11-12.
//  Copyright (c) 2012年 liwang. All rights reserved.
//
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPViewController.h"
#import "UPPayPlugin.h"

#define KBtn_width        200
#define KBtn_height       80
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          80
#define kCellHeight_Normal  50
#define kCellHeight_Manual  145

#define kVCTitle          @"商户测试"
#define kBtnFirstTitle    @"获取订单，开始测试"
#define kWaiting          @"正在获取TN,请稍后..."
#define kNote             @"提示"         
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"


#define kMode_Development             @"01"
#define kURL_TN_Normal                @"http://202.101.25.178:8080/sim/gettn"
#define kURL_TN_Configure             @"http://202.101.25.178:8080/sim/app.jsp?user=123456789"

#define UPRelease(X) if (X !=nil) {[X release];X = nil;}

@interface UPViewController ()
{
    UIAlertView* _alertView;
    NSMutableData* _responseData;
    CGFloat _maxWidth;
    CGFloat _maxHeight;
    
    UITextField *_urlField;
    UITextField *_modeField;
    UITextField *_curField;
}

@property(nonatomic, copy)NSString *tnMode;

- (void)extendedLayout;

- (void)showAlertWait;
- (void)showAlertMessage:(NSString*)msg;
- (void)hideAlert;

- (void)startNetWithURL:(NSURL *)url;

- (UITextField *)textFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;

- (void)buttonAction;

@end

@implementation UPViewController
@synthesize contentTableView;
@synthesize tnMode;

- (void)dealloc
{
    self.contentTableView = nil;
    self.tnMode = nil;
    
    UPRelease(_responseData);
    UPRelease(_urlField);
    UPRelease(_modeField);
    
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = kVCTitle;
    
    [self extendedLayout];
    
    self.contentTableView = ({
        UITableView *tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, _maxWidth, _maxHeight) style:UITableViewStyleGrouped] autorelease];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    
    [self.view addSubview:self.contentTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)extendedLayout
{
    BOOL iOS7 = [UIDevice currentDevice].systemVersion.floatValue >= 7.0;
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    CGFloat offset = iOS7 ? 64 : 44;
    _maxWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    _maxHeight = CGRectGetHeight([UIScreen mainScreen].bounds)-offset;
    
    self.navigationController.navigationBar.translucent = NO;
}


- (void)startNetWithURL:(NSURL *)url
{
    [_curField resignFirstResponder];
    _curField = nil;
    [self showAlertWait];
    
    NSURLRequest * urlRequest=[NSURLRequest requestWithURL:url];
    NSURLConnection* urlConn = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] autorelease];
    [urlConn start];
}

- (UITextField *)textFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    UITextField *textField = [[[UITextField alloc] initWithFrame:frame] autorelease];
    textField.placeholder = placeHolder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor clearColor];
    textField.delegate = self;
    return textField;
}

#pragma mark - Alert

- (void)showAlertWait
{
    [self hideAlert];
    _alertView = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [_alertView show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(_alertView.frame.size.width / 2.0f - 15, _alertView.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [_alertView addSubview:aiv];
    [aiv release];
    [_alertView release];
}

- (void)showAlertMessage:(NSString*)msg
{
    [self hideAlert];
    _alertView = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:self cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [_alertView show];
    [_alertView release];
}
- (void)hideAlert
{
    if (_alertView != nil)
    {
        [_alertView dismissWithClickedButtonIndex:0 animated:NO];
        _alertView = nil;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _alertView = nil;
}

#pragma mark - connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    NSInteger code = [rsp statusCode];
    if (code != 200)
    {
        
        [self showAlertMessage:kErrorNet];
        [connection cancel];
    }
    else
    {
        UPRelease(_responseData);
        _responseData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self hideAlert];
    NSString* tn = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    if (tn != nil && tn.length > 0)
    {
        NSLog(@"tn=%@",tn);
        [UPPayPlugin startPay:tn mode:self.tnMode viewController:self delegate:self];
    }
    [tn release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self showAlertMessage:kErrorNet];
}


#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:kResult, result];
    [self showAlertMessage:msg];
}




#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            
            self.tnMode = kMode_Development;
            [self startNetWithURL:[NSURL URLWithString:kURL_TN_Normal]];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            break;
        case 1:
            self.tnMode = kMode_Development;
            [self startNetWithURL:[NSURL URLWithString:kURL_TN_Configure]];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case 2:
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 2) ? kCellHeight_Manual : kCellHeight_Normal;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    switch (indexPath.row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"普通订单";
            cell.detailTextLabel.text = @"mode=01";
        }
            
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"配置用户123456789";
            cell.detailTextLabel.text = @"mode=01";
        }
            break;
        case 2:
        {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            CGRect urlFrame = CGRectMake(10, 10, CGRectGetWidth(tableView.frame)-20, 35);
            _urlField = [self textFieldWithFrame:urlFrame placeHolder:@"获取TN地址"];
            [cell.contentView addSubview:_urlField];
            
            CGRect modeFrame = CGRectMake(10, 55, CGRectGetWidth(tableView.frame)-20, 35);
            _modeField = [self textFieldWithFrame:modeFrame placeHolder:@"mode"];
            [cell.contentView addSubview:_modeField];
            
            CGRect btnFrame = CGRectMake(50, 100, CGRectGetWidth(tableView.frame)-100, 35);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = btnFrame;
            [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"开  始  支  付" forState:UIControlStateNormal];
            [cell.contentView addSubview:button];
            
        }
            break;
        
            
        default:
            break;
    }
    
    
    
    return cell;
}

- (void)buttonAction
{
    self.tnMode = _modeField.text;
    [self startNetWithURL:[NSURL URLWithString:_urlField.text]];
}


#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _curField = textField;
}

@end
