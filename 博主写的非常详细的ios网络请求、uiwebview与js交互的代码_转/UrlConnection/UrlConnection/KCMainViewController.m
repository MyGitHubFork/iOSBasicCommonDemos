//
//  KCMainViewController.m
//  UrlConnection
//
//  Created by Kenshin Cui on 14-3-22.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCMainViewController.h"
#import "KCStatusTableViewCell.h"
#import "KCStatus.h"
#import "KCUser.h"
#define kURL @"http://192.168.1.152/ViewStatus.aspx"

@interface KCMainViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_status;
    NSMutableArray *_statusCells;//存储cell，用于计算高度
    NSString *_userName;
    NSString *_password;
}

@end

@implementation KCMainViewController

#pragma mark - UI方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userName=@"KenshinCui";
    _password=@"123";
    
    [self layoutUI];
    [NSThread sleepForTimeInterval:10];
    [self sendRequest];
    
}

#pragma mark - 私有方法
#pragma mark 界面布局
-(void)layoutUI{
    _tableView =[[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}
#pragma mark 加载数据
-(void)loadData:(NSData *)data{
    _status=[[NSMutableArray alloc]init];
    _statusCells=[[NSMutableArray alloc]init];
    /*json序列化
     options:序列化选项，枚举类型，但是可以指定为枚举以外的类型，例如指定为0则可以返回NSDictionary或者NSArray
         a.NSJSONReadingMutableContainers:返回NSMutableDictionary或NSMutableArray
         b.NSJSONReadingMutableLeaves：返回NSMutableString字符串
         c.NSJSONReadingAllowFragments：可以解析JSON字符串外层既不是字典类型（NSMutableDictionary、NSDictionary）又不是数组类型（NSMutableArray、NSArray）,但是必须是有效的JSON字符串
     error:错误信息
    */
    NSError *error;
    //将对象序列化为字典
    NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSArray *array= (NSArray *)dic[@"statuses"];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        KCStatus *status=[[KCStatus alloc]init];
        //通过KVC给对象赋值
        [status setValuesForKeysWithDictionary:obj];
        
        KCUser *user=[[KCUser alloc]init];
        [user setValuesForKeysWithDictionary:obj[@"user"]];
        status.user=user;
        
        [_status addObject:status];
        
        //存储tableViewCell
        KCStatusTableViewCell *cell=[[KCStatusTableViewCell alloc]init];
        [_statusCells addObject:cell];

    }];
}


#pragma mark 发送数据请求
-(void)sendRequest{
    NSString *urlStr=[NSString stringWithFormat:@"%@",kURL];
    //注意对于url中的中文是无法解析的，需要进行url编码(指定编码类型位utf-8)
    //另外注意url解码使用stringByRemovingPercentEncoding方法
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //创建url链接
    NSURL *url=[NSURL URLWithString:urlStr];
    
    /*创建可变请求*/
    NSMutableURLRequest *requestM=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:5.0f];
    [requestM setHTTPMethod:@"POST"];//设置位post请求
    //创建post参数
    NSString *bodyDataStr=[NSString stringWithFormat:@"userName=%@&password=%@",_userName,_password];
    NSData *bodyData=[bodyDataStr dataUsingEncoding:NSUTF8StringEncoding];
    [requestM setHTTPBody:bodyData];
    
    //发送一个异步请求
    [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
//            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"jsonStr:%@",jsonStr);
            //加载数据
            [self loadData:data];

            //刷新表格
            [_tableView reloadData];
        }else{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
            }];
        }
    }];
    
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _status.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    KCStatusTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[KCStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //在此设置微博，以便重新布局
    KCStatus *status=_status[indexPath.row];
    cell.status=status;
    return cell;
}


#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //KCStatusTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    KCStatusTableViewCell *cell= _statusCells[indexPath.row];
    cell.status=_status[indexPath.row];
    return cell.height;
}
@end






