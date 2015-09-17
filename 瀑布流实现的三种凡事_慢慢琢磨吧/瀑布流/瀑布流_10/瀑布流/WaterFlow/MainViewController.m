//
//  MainViewController.m
//  瀑布流
//
//  Created by aiteyuan on 14-10-20.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#import "MainViewController.h"
#import "WaterFlowCellView.h"
#import "MGJData.h"
#import "UIImageView+WebCache.h"



@interface MainViewController ()
//数据列表
@property(strong,nonatomic)NSArray *dataList;
//当前显示列数
@property(assign,nonatomic)NSInteger dataColumns;
@end

@implementation MainViewController

#warning  私有方法
#pragma mark 加载蘑菇街数据
-(void)loadMGJData
{
    //1从沙盒中取出plist
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mogujie" withExtension:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:url];
    NSArray *array = dict[@"result"][@"list"];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        NSDictionary *showDict = dict[@"show"];
        MGJData *data = [[MGJData alloc]init];
#warning 字典兑现转换为自定义对象的快捷方法。
        [data setValuesForKeysWithDictionary:showDict];
        [arrayM addObject:data];
    }
    self.dataList = arrayM;
    //2强烈提醒：需要测试
    //NSLog(@"%@",self.dataList);
}

//-(void)loadView
//{
//   // self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
////    //测试单元格视图
////    UIImage *image = [UIImage imageNamed:@"123.jpg"];
////    WaterFlowCellView *cell = [[WaterFlowCellView alloc]initWithReuseIdentifier:@"a"];
////    [cell.imageView setImage:image];
////    [cell setFrame:CGRectMake(20, 20, 200, 200)];
////    [cell.textLable setText:@"暴风"];
////    [self.view addSubview:cell];
//    
//}

- (void)viewDidLoad
{
#warning 这里的viewDidLoad方法就是调用WaterFlowViewController的viewDidLoad方法
    [super viewDidLoad];
    [self loadMGJData];
    

    
}


#pragma mark 从某个方向旋转设备。
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //如果发生旋转，重新加载数据。
    [self.waterFlowView reloadData];
}

#pragma mark 数据源方法
#pragma mark 列数
-(NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView
{
    //可以根据当前设备的方向，设定要显示的数据列数
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        self.dataColumns = 4;
    }else{
        self.dataColumns = 3;
    }
    return self.dataColumns;
}
#pragma mark 行数
-(NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns
{
    return self.dataList.count;
}
-(WaterFlowCellView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MyCell";
    WaterFlowCellView *cell = [waterFlowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WaterFlowCellView alloc]initWithReuseIdentifier:ID];
    }
    //设置cell
    MGJData *data = self.dataList[indexPath.row];
    [cell.textLable setText:data.price];
#warning  使用SDWebImage可以指定缓存策略，包括内存缓存，并磁盘缓存。
    //[cell.imageView setImageWithURL:data.img];
    [cell.imageView setImageWithURL:data.img placeholderImage:[UIImage imageNamed:@"123.jpg"] options:SDWebImageRetryFailed|SDWebImageProgressiveDownload];
    
    return cell;
}


#pragma mark 代理协议方法

#pragma mark 每一个单元格的高度
-(CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGJData *data = self.dataList[indexPath.row];
    //计算图像的高度
    CGFloat colWidth = self.view.bounds.size.width/self.dataColumns;
    return (colWidth/data.w)*data.h;
}
@end
