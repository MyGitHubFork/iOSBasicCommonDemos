//
//  MainViewController.m
//  MapDemo
//
//  Created by wei.chen on 13-1-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import "WXAnation.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //是否显示当前设备的位置
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    //地图的显示类型
    /*
    *MKMapTypeStandard 标准地图
     *MKMapTypeSatellite卫星地图
     *MKMapTypeHybrid   混合地图
    */
    self.mapView.mapType = MKMapTypeStandard;
    
    //坐标,这是地图初始化的时候显示的坐标
    CLLocationCoordinate2D coord = {39.904299,116.22169};
    //显示的返回，数值越大，范围就越大
    MKCoordinateSpan span = {0.1,0.1};
    
    MKCoordinateRegion region = {coord,span};
    //地图初始化的时候显示的区域
    [self.mapView setRegion:region];
    
    //是否允许缩放
//    self.mapView.zoomEnabled = NO;
//    self.mapView.scrollEnabled = NO;
    
    //创建anation对象
    CLLocationCoordinate2D showCoord = {39.904299,116.22169};
    WXAnation *anation1 = [[WXAnation alloc] initWithCoordinate2D:showCoord];
    anation1.title = @"万达电影院";
    anation1.subtitle = @"小标题";
    
    //创建anation对象
    CLLocationCoordinate2D showCoord2 = {39.804299,116.32169};
    WXAnation *anation2 = [[WXAnation alloc] initWithCoordinate2D:showCoord2];
    anation2.title = @"万达电影院2";
    anation2.subtitle = @"小标题2";
    
    
    [self.mapView addAnnotation:anation1];
    [self.mapView addAnnotation:anation2];
    
}

#pragma mark - MKAnnotationView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //判断是否为当前设备位置的annotation
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        //返回nil，就使用默认的标注视图
        return nil;
    }
    
    //-------------------创建大头针视图---------------------
    
    static NSString *identifier = @"Annotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
//        annotationView = [[MKAnnotationView alloc] initWithAnnotation:<#(id<MKAnnotation>)#> reuseIdentifier:<#(NSString *)#>];
        
        //MKPinAnnotationView 是大头针视图
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        //设置是否显示标题视图
        annotationView.canShowCallout = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        //标题右边视图
        annotationView.rightCalloutAccessoryView = button;
        //标题左边视图
//        annotationView.leftCalloutAccessoryView
    }
    
    annotationView.annotation = annotation;
    
    //设置大头针的颜色
    annotationView.pinColor = MKPinAnnotationColorRed;
    //从天上落下的动画
    annotationView.animatesDrop = YES;
    
    return annotationView;
    
    
    //-------------------使用图片作为标注视图---------------------
    /*
    static NSString *identifier = @"Annotation";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.image = [UIImage imageNamed:@"play"];
        //设置是否显示标题视图
        annotationView.canShowCallout = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        //标题右边视图
        annotationView.rightCalloutAccessoryView = button;
        
    }
    return annotationView;
     */
}

- (void)buttonAction {
    NSLog(@"显示电影院详情");
}

- (void)dealloc {
    [_mapView release];
    [super dealloc];
}
@end
