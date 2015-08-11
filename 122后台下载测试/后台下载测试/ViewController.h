//
//  ViewController.h
//  后台下载测试
//
//  Created by mac on 14-5-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController<NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate,UIDocumentInteractionControllerDelegate>{
    IBOutlet UIProgressView *progressView;
}
@property (nonatomic)NSURLSession *session;
@property (nonatomic)NSURLSessionDownloadTask *downloadTask;
@property (strong,nonatomic)UIDocumentInteractionController *documentInteractionController;
- (IBAction)StartDownLoad:(id)sender;

@end
