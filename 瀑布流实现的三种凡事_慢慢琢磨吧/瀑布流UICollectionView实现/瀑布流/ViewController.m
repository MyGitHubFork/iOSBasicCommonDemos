//
//  ViewController.m
//  瀑布流
//
//  Created by 修斌 on 15/7/14.
//  Copyright (c) 2015年 handaowei. All rights reserved.
//

#import "ViewController.h"
#import "MyViewLayout.h"
#import "MJExtension.h"

#import "MyCollectionViewCell.h"
#import "MyMode.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyViewLayoutDelegate>
@property(nonatomic,weak)UICollectionView* collectionView;
@property(nonatomic,strong)NSMutableArray* shops;
@end

@implementation ViewController
//懒加载
-(NSMutableArray *)shops
{
    if(!_shops)
    {
         _shops=[[NSMutableArray alloc]init];
    }
    return _shops;
}
static NSString *const ID=@"shop";
- (void)viewDidLoad {
    [super viewDidLoad];
  
        NSArray* array=[MyMode objectArrayWithFilename:@"123.plist"];
  
    
    MyViewLayout* layout=[[MyViewLayout alloc]init];
    layout.delegate=self;
    layout.columnsCount=3;
    
    [self.shops addObjectsFromArray:array];
    
    UICollectionView* collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
   
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView=collectionView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - <MyViewLayoutDelegate>
-(CGFloat)waterflowlayout:(MyViewLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexpath:(NSIndexPath *)indexpath
{
    MyMode* mode=self.shops[indexpath.item];
    return mode.h/mode.w*width;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop=self.shops[indexPath.item];
    return cell;
}

@end
