//
//  MyCollectionViewCell.m
//  瀑布流
//
//  Created by 修斌 on 15/7/14.
//  Copyright (c) 2015年 handaowei. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "MyViewLayout.h"
#import "UIImageView+WebCache.h"
#import "MyMode.h"
@interface MyCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end

@implementation MyCollectionViewCell

-(void)setShop:(MyMode *)shop
{
    _shop=shop;
   [_imgV sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"Default"]];
    _imgV.backgroundColor=[UIColor redColor];
    _priceL.text=shop.price;
   
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(become:)];
    [self.imgV addGestureRecognizer:tap];
    self.imgV.userInteractionEnabled=YES;
   
}
-(void)become:(UIGestureRecognizer*)sender
{
   
    UIView* view=[[UIView alloc]init];

    view.frame=[UIScreen mainScreen].bounds;
    view.backgroundColor=[UIColor blackColor];
     [[UIApplication sharedApplication].keyWindow addSubview:view];
    UIImageView* imageview=[[UIImageView alloc]init];
   UIImageView* imageview1=(UIImageView*)sender.view;
    imageview.image=imageview1.image;
    
    imageview.frame=CGRectMake(0, 20, view.frame.size.width, 400);
    
    
    [view addSubview:imageview];
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [view addGestureRecognizer:tap];
   
}
-(void)back:(UIGestureRecognizer*)sender
{
    [sender.view removeFromSuperview];
    
}

@end
