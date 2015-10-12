//
//  ViewController.m
//  CoreHttp
//
//  Created by muxi on 15/3/2.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "ViewController.h"
#import "CoreHttp.h"
#import "UploadFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}






- (IBAction)get:(id)sender {
    
    NSString *url=@"http://www.jsszzx.net/wapwb.asmx/LoadNews_KSTZ";
    
    [CoreHttp getUrl:url params:nil success:^(id obj) {
        NSLog(@"%@",obj);
        NSLog(@"正确");
    } errorBlock:^(CoreHttpErrorType errorType) {
        NSLog(@"出错");
    }];
}

- (IBAction)upload:(id)sender {

    UIImage *img=[UIImage imageNamed:@"1.jpg"];
    
    NSDateFormatter *formage=[[NSDateFormatter alloc] init];
    [formage setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [formage stringFromDate:[NSDate date]];
    
    //转data
    NSData *data=UIImageJPEGRepresentation(img, .8f);
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    parametersDic[@"path"] = @"img";
    parametersDic[@"file"] = @"file";
    parametersDic[@"clientkey"] = @"5";
    parametersDic[@"time"] = destDateString;
    parametersDic[@"sign"] = @"1";
    
    UploadFile *file = [UploadFile fileWithKey:@"file" data:data name:@"file.png"];
    
    
    [CoreHttp uploadUrl:@"http://112.124.115.135:8080/haoxinren/file/upload1" params:parametersDic files:@[file] success:^(id obj) {
        NSLog(@"%@",obj);
    } errorBlock:^(CoreHttpErrorType errorType) {
        NSLog(@"%u",errorType);
    }];
    
}





@end
