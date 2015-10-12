//
//  RootViewController.m
//  CollView
//
//  Created by the Hackintosh of XKD on 14-10-20.
//  Copyright (c) 2014年 ZHIYOUEDU. All rights reserved.
//

#import "RootViewController.h"
#import "MyViewController.h"
@interface RootViewController ()
{
    NSArray *image_array;
}
@end

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    

    //UICollectionView *collView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    UICollectionView *collView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, 320, 150) collectionViewLayout:layout];
    collView.backgroundColor=[UIColor greenColor];
    
    [collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [collView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    collView.delegate=self;
    collView.dataSource=self;
    [self.view addSubview:collView];
    
    image_array=[NSArray arrayWithObjects:@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",nil];
    
}
//返回区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
///每个区的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return image_array.count;
}
//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"cell";
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
 
    cell.backgroundColor=[UIColor cyanColor];
    
    UIButton *Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame=cell.bounds;
    [Btn setBackgroundImage:[UIImage imageNamed:[image_array objectAtIndex:indexPath.item]] forState:UIControlStateNormal];
    Btn.tag= indexPath.row;
    [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIImageView *imageView=[[UIImageView alloc]init];
//    imageView.image=[UIImage imageNamed:[image_array objectAtIndex:indexPath.item]];
//    [cell setBackgroundView:imageView];
    
    [cell addSubview:Btn];
    //cell.frame=CGRectMake(0, 60, 80, 80);
    //cell.bounds = CGRectMake(0, 0, 150, 50);
    return cell;
}

//设置头部的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size={100,60};
    return size;
}
//设置头区域的view显示
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    reuseView.backgroundColor=[UIColor redColor];
    //reuseView.frame=CGRectMake(0, 0, 260, 40);
    
    return reuseView;
}
//边界距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
     UIEdgeInsets edge={0,50,0,50}; //边界距离
     return edge;
}


//选择
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"adgkahfgih");
    
//    MyViewController *myVC=[[MyViewController alloc]init];
//    [self.navigationController pushViewController:myVC animated:YES];
    
    
}


-(void)BtnClick:(UIButton *)Btn
{
    if (Btn.tag || Btn.tag==0) {
        
        MyViewController *myVC=[[MyViewController alloc]init];
        [self.navigationController pushViewController:myVC animated:YES];
        
        NSLog(@"Btn.tag: %ld",(long)Btn.tag);
    }
    
}



@end
















