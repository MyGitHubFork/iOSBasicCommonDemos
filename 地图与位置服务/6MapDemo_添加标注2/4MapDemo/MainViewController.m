//
//  MainViewController.m
//  4MapDemo
//
//  Created by aiteyuan on 14/11/13.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "MainViewController.h"
#import "WXAnation.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //是否显示当前设备位置，一个蓝色的小圆圈
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    //地图显示类型
    //MKMapTypeStandard = 0, 标准地图
    //MKMapTypeSatellite,卫星地图
    //MKMapTypeHybrid 混合地图
    self.mapView.mapType = MKMapTypeStandard;
    //设置显示区域
    //地图初始化的时候显示的坐标
    CLLocationCoordinate2D coord = { 30.76666666666,120.76666666666};
    //控制显示范围，以经度和纬度为单位
    MKCoordinateSpan span = {0.01, 0.01};
    //地图初始化的时候显示的区域
    MKCoordinateRegion region = {coord, span};
    [self.mapView setRegion:region];
    //self.mapView.zoomEnabled = NO;//地图缩放默认是YES
    //self.mapView.scrollEnabled = NO;//地图滚动,默认是YES
    
    //创建anation对象
    CLLocationCoordinate2D showcoord = { 30.76666666666,120.76666666666};
    WXAnation *anation = [[WXAnation alloc]initWithCoordinate2D:showcoord];
    anation.title = @"嘉兴艾特远";
    anation.subtitle = @"嘉兴软件园";
    //把标注添加到视图。
    [self.mapView addAnnotation:anation];
}

//添加标注步骤：
 //1 添加实现了MKAnnotation协议的类。需要有CLLocationCoordinate2D属性，存储位置信息。 NSString 标注的标题
 //2 创建自定义的Annotation，并将该实例添加到MapView中。
 //3 实现代理方法
#pragma mark - MKAnnotationView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *identifier = @"Annotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        //MKPinAnnotationView是大头针视图
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        //设置是否显示标题视图
        annotationView.canShowCallout = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button1 addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        //添加一个右侧视图
        annotationView.rightCalloutAccessoryView = button;
        //也可以在左边添加标题视图
        annotationView.leftCalloutAccessoryView = button1;
    }
    annotationView.pinColor = MKPinAnnotationColorRed;//设置大头针的颜色
    annotationView.animatesDrop = YES; //动画
    return annotationView;
}



-(void)buttonAction
{
    NSLog(@"显示嘉兴艾特远详情");
}
@end
