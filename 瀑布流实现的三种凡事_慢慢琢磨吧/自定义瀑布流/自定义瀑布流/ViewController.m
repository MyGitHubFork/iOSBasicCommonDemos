//
//  ViewController.m
//  WaterFlowView
//
//  Created by hanwei on 15/7/27.
//  Copyright (c) 2015年 hanwei. All rights reserved.
//

#import "ViewController.h"
#import "MyWaterflowView.h"
#import "MyWaterflowViewCell.h"
//RGB颜色
#define HDWColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//随机色
#define HDWRandomColor HDWColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
@interface ViewController ()<MyWaterflowViewDateSource,MyWaterflowViewDelegate>
{
    MyWaterflowView* myWater;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myWater=[[MyWaterflowView alloc]init];
    myWater.frame=self.view.bounds;
    myWater.delegate=self;
    myWater.dateSource=self;
    [self.view addSubview:myWater];
    
    //[myWater reloadData];
}

- (IBAction)refresh:(id)sender {
    [myWater reloadData];
}

#pragma mark 实现数据源方法

-(NSInteger)numberOfCellsWatersFlowView:(MyWaterflowView *)waterFlowView
{
    return 1000;
}


-(NSInteger)numberOfColimnsInWaterFlowView:(MyWaterflowView *)waterFlowView
{
    return 3;
}

-(MyWaterflowViewCell *)waterFlowView:(MyWaterflowView *)waterFlowView cellAtIndex:(NSUInteger)index
{
    static NSString* Identifier=@"cell";
    MyWaterflowViewCell* cell=[waterFlowView dequeueReusableCellWithIdentifier:Identifier];
    if (cell==nil) {
    cell=[[MyWaterflowViewCell alloc]init];
    cell.backgroundColor=HDWRandomColor;
    cell.identifier=Identifier;
    }
    cell.tag = 110;
    return cell;
}

#pragma mark 实现代理方法
//1.选中单元格
-(void)waterFlowView:(MyWaterflowView*)waterFlowView didSelectRowAtIndexPath:(NSUInteger)index
{
    NSLog(@"点中了第%lu个cell",(unsigned long)index);
    
}

//2.指定indexPath单元格的行高
-(CGFloat)waterFlowView:(MyWaterflowView*)waterFlowView heightForRowAtIndexPath:(NSUInteger)index
{
    switch (index%3) {
        case 0:
            return 70;
        case 1:
            return 100;
        case 2:
            return 90;
        default:
            return 110;
    }
    
}


//3.刷新数据
-(void)waterFlowViewRefreshDate:(MyWaterflowView*)waterView
{}

//4.返回间距
-(CGFloat)waterFlowView:(MyWaterflowView*)waterFlowView magrnFortype:(waterFlowViewMarginType)type
{
    switch (type) {
        case waterFlowViewMarginTop:
        case waterFlowViewMarginBottom:
        case waterFlowViewMarginLeft:
        case waterFlowViewMarginRight:
        //case waterFlowViewMarginColumn:
        //case waterFlowViewMarginRow:
            return 10;
            default:
            return 5;
    }
   
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
