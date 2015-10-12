//
//  mainViewController.m
//  截屏
//
//  Created by aiteyuan on 14-9-24.
//  Copyright (c) 2014年 黄成都. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()
{
UIImageView *myview;
}
@end

@implementation mainViewController

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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = CGPointMake(100, 200);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    myview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 300, 200)];
    [self.view addSubview:myview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 280, 30)];
    label.text = @"我是黄成都，这是我的截屏保存演练";
    [self.view addSubview:label];
}

-(void)btnClick
{
    UIImage *image = [self makeImageWithView:self.view];
    myview.image = image;
    
    [self saveImageToPhotos:image];
}

//截屏
- (UIImage *)makeImageWithView:(UIView *)view
{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    
//    float scale = [[UIScreenmainScreen] scale];//得到设备的分辨率
//    scale = 1; 的时候是代表当前设备是320*480的分辨率（就是iphone4之前的设备）
//    scale = 2; 的时候是代表分辨率为640*960的分辨率
    NSLog(@"%f",[UIScreen mainScreen].scale);
    //绘图
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    //渲染
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //生产图片
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//保存图片到相框
- (void)saveImageToPhotos:(UIImage *)savedImage

{
    
//    image
//    要保存到用户设备中的图片
//    completionTarget
//    当保存完成后，回调方法所在的对象
//    completionSelector
//    当保存完成后，所调用的回调方法。 形式如下：
//    - (void) image: (UIImage *) image
//didFinishSavingWithError: (NSError *) error
//contextInfo: (void *) contextInfo;
//    contextInfo
//    可选的参数，保存了一个指向context数据的指针，它将传递给回调方法。
    UIImageWriteToSavedPhotosAlbum(savedImage,self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
    
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    NSLog(@"%@", msg);
    
}
@end
