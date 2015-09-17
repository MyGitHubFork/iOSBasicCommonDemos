//
//  MainViewController.m
//  4MapDemo
//
//  Created by aiteyuan on 14/11/13.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "MainViewController.h"

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
    
}


@end
