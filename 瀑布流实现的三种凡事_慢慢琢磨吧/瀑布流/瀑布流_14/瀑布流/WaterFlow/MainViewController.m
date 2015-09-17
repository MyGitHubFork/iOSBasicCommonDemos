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
@property(strong,nonatomic)NSMutableArray *dataList;
//当前显示列数
@property(assign,nonatomic)NSInteger dataColumns;
#pragma 加载网络数据属性
//当前是否正在加载数据
@property(assign,nonatomic)BOOL isLoadingData;
//当前加载字符串数据的索引。
@property(assign,nonatomic) NSInteger dataIndex;
@end

@implementation MainViewController

#warning  私有方法
#pragma mark 加载蘑菇街数据
-(void)loadMGJData
{
    self.isLoadingData = YES;
    
    //0加载沙箱中的查询字符串
    NSURL *localUrl = [[NSBundle mainBundle]URLForResource:@"UrlList" withExtension:@"plist"];
    NSArray *strArray = [NSArray arrayWithContentsOfURL:localUrl];
    
    if (self.dataIndex == strArray.count) {
        NSLog(@"没有找到新数据，请稍后再试");
        self.isLoadingData = NO;
        return;
    }
    
    //1NSString
//    NSString *urlStr = [NSString stringWithFormat:@"http://www.mogujie.com/app_mgj_v511_book/clothing?_adid=5503509D-800B-45EF-B767-F6586FFF165E&_did=0f607264fc6318a92b9e13c65db7cd3c&_atype=iPhone&_source=NIMAppStore511&_fs=NIMAppStore511&_swidth=640&_network=2&_mgj=%@&title=最热&from=hot_element&login=false&fcid=6550&q=最热&track_id=1377824666&homeType=shopping", strArray[self.dataIndex]];
    NSString *urlStr = nil;
    if (self.dataList == 0) {
        urlStr = [NSString stringWithFormat:@"http://www.mogujie.com/app_mgj_v511_book/clothing?_adid=5503509D-800B-45EF-B767-F6586FFF165E&_did=0f607264fc6318a92b9e13c65db7cd3c&_atype=iPhone&_source=NIMAppStore511&_fs=NIMAppStore511&_swidth=640&_network=2&_mgj=%@&title=最热&from=hot_element&login=false&fcid=6550&q=最热&track_id=1377824666&homeType=shopping", strArray[self.dataIndex]];
    } else {
        urlStr = [NSString stringWithFormat:@"http://www.mogujie.com/app_mgj_v511_book/clothing?_adid=5503509D-800B-45EF-B767-F6586FFF165E&_did=0f607264fc6318a92b9e13c65db7cd3c&_atype=iPhone&_source=NIMAppStore511&_fs=NIMAppStore511&_swidth=640&_network=2&_mgj=%@&title=最热&mbook=eyJxIjoiXCJcdTY3MDBcdTcwZWRcIiIsInFfbmF0dXJhbCI6Ilx1NjcwMFx1NzBlZCIsInNvcnQiOiJob3Q3ZGF5IiwiY2Jvb2siOjEsImFjdGlvbiI6ImNsb3RoaW5nIiwicGFnZSI6NCwidHlwZSI6ImFsbCIsImNnb29kcyI6MSwidGltZV9mYWN0b3IiOiIxNV81IiwiZmNpZCI6IjY1NTAiLCJpc19hZF9uZXciOjAsImlzRmlsdGVyIjp0cnVlLCJwZXJwYWdlIjo1MH0%@3D&from=hot_element&login=false&fcid=6550&q=最热&track_id=1377824666&homeType=shopping", strArray[self.dataIndex], @"%"];
    }

    
    //2 修改属性
    self.dataIndex++;
    
    //2NSURL
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //3此时用同步还是异步？用同步可以让用户进入界面稍等几秒即可看到数据
    NSData *data = [NSData dataWithContentsOfURL:url];//这个方法是同步方法
    //4生成JSON
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSArray *array = dict[@"result"][@"list"];
    if (self.dataList == nil) {
        self.dataList = [NSMutableArray array];
    }
    //对self.dataList进行拼接。
    for (NSDictionary *dict in array) {
        NSDictionary *showDict = dict[@"show"];
        MGJData *data = [[MGJData alloc]init];
#warning 字典兑现转换为自定义对象的快捷方法。
        [data setValuesForKeysWithDictionary:showDict];
        [self.dataList addObject:data];
    }
    //重新刷新数据
    self.isLoadingData = NO;
    [self.waterFlowView reloadData];
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
    [cell.imageView sd_setImageWithURL:data.img placeholderImage:[UIImage imageNamed:@"123.jpg"] options:SDWebImageRetryFailed|SDWebImageProgressiveDownload];
    
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
#pragma mark 选中单元格
-(void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中单元格%@",indexPath);
    MGJData *data = self.dataList[indexPath.row];
    
}

#pragma mark 刷新网络数据
-(void)waterFlowViewRefreshData:(WaterFlowView *)waterFlowView{
    NSLog(@"加载数据");
    //1 如果当前正在刷新数据，则不执行后续方法
    if (self.isLoadingData) {
        return;
    }
    
    [self loadMGJData];
}
@end
