//
//  ViewController.m
//  exercise_图片加水印
//
//  Created by 弄潮者 on 15/8/6.
//  Copyright (c) 2015年 弄潮者. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"pushu.jpg"];
    UIImage *waterImage = [self waterMarkImage:image withText:@"黄成都你好"];
    
    UIImageWriteToSavedPhotosAlbum(waterImage, nil, nil, nil);  //保存图片至相册
    
//    展示图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = waterImage;
    [self.view addSubview:imageView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (UIImage *)waterMarkImage:(UIImage *)image withText:(NSString *)text {
//    建立图像上下文
    UIGraphicsBeginImageContext(image.size);
    
//    在画布中绘制内容
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
//    绘制文字
    [[UIColor darkGrayColor] set];
    CGRect rect = CGRectMake(70, 220, 200, 60);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:30],
                          NSObliquenessAttributeName:@1};       //这里设置了字体，和倾斜度，具体其他参数文章结尾有详细说明的文章链接
    [text drawInRect:rect withAttributes:dic];
   
    //在iOS7之前用下列方法比较方便
//    [text drawInRect:rect withFont:[UIFont systemFontOfSize:30] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
//    从画布中得到image
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return returnImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
