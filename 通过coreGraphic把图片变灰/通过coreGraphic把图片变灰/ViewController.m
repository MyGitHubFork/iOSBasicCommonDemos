//
//  ViewController.m
//  通过coreGraphic把图片变灰
//
//  Created by 黄成都 on 15/7/4.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+changeColor.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *originalImage;

@property (weak, nonatomic) IBOutlet UIImageView *grayImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.grayImage.image = [self.originalImage.image grayImage:self.originalImage.image];
    //self.grayImage.image = [self.originalImage.image imageWithColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
