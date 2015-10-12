//
//  ViewController.m
//  UIImage分类实现各种旋转
//
//  Created by 黄成都 on 15/7/5.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Rotate_Flip.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *originalImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rotate90ClockwiseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rotate90CounterClockwiseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rotate180ImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rotateImageToOrientationUpImageView;

@property (weak, nonatomic) IBOutlet UIImageView *flipHorizontalImageView;

@property (weak, nonatomic) IBOutlet UIImageView *flipVerticalImageView;


@property (weak, nonatomic) IBOutlet UIImageView *flipAllImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImage *originalImage = [UIImage imageNamed:@"icon.png"];
    
    self.originalImageView.image = originalImage;
    //顺时针旋转90度
    self.rotate90ClockwiseImageView.image = [originalImage rotate90Clockwise];
    //逆时针旋转90度
    self.rotate90CounterClockwiseImageView.image = [originalImage rotate90CounterClockwise];
    //旋转一百八十度
    self.rotate180ImageView.image = [originalImage rotate180];
    //翻转到原始样子
    self.rotateImageToOrientationUpImageView.image = [originalImage rotateImageToOrientationUp];
    //水平方向翻转
    self.flipHorizontalImageView.image = [originalImage flipHorizontal];
    //竖直方向翻转
    self.flipVerticalImageView.image = [originalImage flipVertical];
    //水平竖直方向翻转
    self.flipAllImageView.image = [originalImage flipAll];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
