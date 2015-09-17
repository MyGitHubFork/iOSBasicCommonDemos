//
//  ViewController.m
//  04-读取二维码
//
//  Created by aiteyuan on 14/11/24.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property(strong,nonatomic)AVCaptureSession *session;
@property(strong,nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self readQRCoder];
}

#pragma mark  读取二维码
-(void)readQRCoder
{
    //1 实例化摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2设置输入,把摄像头作为输入设备
    //因为模拟器是没有摄像头的，因此在此最好做个判断
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"没有摄像头%@", error.localizedDescription);
        return;
    }
    //3设置输出(Metadata元数据)
    AVCaptureMetadataOutput *outPut = [[AVCaptureMetadataOutput alloc] init];
    //3.1 设置输出的代理
    //使用主线程队列，相应比较同步，使用其他队列，相应不同步，容易让用户产生不好的体验。
    [outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //4拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    //添加session的输入和输出
    [session addInput:input];
    [session addOutput:outPut];
    //4.1设置输出的格式
    [outPut setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //5设置预览图层(用来让用户能够看到扫描情况)
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    //5.1设置preview图层的属性
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //5.2设置preview图层的大小
    [preview setFrame:self.view.bounds];
    //5.3将图层添加到视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
    self.previewLayer = preview;
    //6.启动会话
    [session startRunning];
    
    self.session = session;
}


#pragma mark 输出代理方法
//此方法是在识别到QRCode并且完成转换，如果QRCode的内容越大，转换需要的时间就越长。
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //会频繁的扫描，调用代理方法
    //1如果扫描完成，停止会话
    [self.session stopRunning];
    //2删除预览图层
    [self.previewLayer removeFromSuperlayer];
    NSLog(@"%@",metadataObjects);
    //设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        //提示：如果需要对url或者名片等信息上扫描，再次扩展就好了。
        _label.text = obj.stringValue;
    }
}
- (IBAction)capture {
    
    [self readQRCoder];
}

@end
