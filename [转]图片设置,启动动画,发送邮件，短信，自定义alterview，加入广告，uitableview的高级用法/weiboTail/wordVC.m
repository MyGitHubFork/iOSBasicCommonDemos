//
//  wordVC.m
//  weiboTail
//
//  Created by Colin on 14-9-7.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "wordVC.h"

#import "webVC.h"

@interface wordVC ()

@end

@implementation wordVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark
#pragma mark SearchBar Delegate

- (void) searchBarTextDidBeginEditing: (UISearchBar*) searchBar
{
    
    [searchBarReagion setShowsCancelButton: YES animated: YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    isSearchActiveDM = TRUE;
    [filteredArr removeAllObjects];
    
    for (int i=0; i<resultArr.count; i++)
    {
        NSDictionary *countryDictinary = [resultArr objectAtIndex:i];
        NSRange result=[[countryDictinary objectForKey:@"appName"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if(result.length>0)
        {
            
            [filteredArr addObject:countryDictinary];
        }
        
    }
    
    [myTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBarReagion resignFirstResponder];
    [searchBarReagion setShowsCancelButton: NO animated: YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    
    isSearchActiveDM = FALSE;
    searchBarReagion.text = @"";
    [searchBarReagion setShowsCancelButton: NO animated: YES];
    [searchBarReagion resignFirstResponder];
    
    [myTableView reloadData];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    //添加列表
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, 320, Screen_height - 154)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    //背景颜色
    myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"eyeBackground.jpg"]];
    [self.view addSubview:myTableView];
    
    //初始化搜索列表bar
    filteredArr = [[NSMutableArray alloc]init];
    searchBarReagion = [[UISearchBar alloc] initWithFrame:CGRectMake(0,64,320,44)];
    searchBarReagion.placeholder = @"搜索";
    searchBarReagion.delegate = self;
    [self.view addSubview:searchBarReagion];

    
    //获取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"];
    resultArr = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    // 创建广告条
    YouMiView *adView = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:nil];
    //设置文字广告的属性[可选]
    adView.indicateTranslucency = YES;
    adView.indicateRounded = NO;
    
    adView.frame = CGRectMake(0, Screen_height-50, 320, 50);
    
    // 开始请求广告
    [adView start];
    [self.view addSubview:adView];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearchActiveDM)
    {
        return [filteredArr count];
    }
    return [resultArr count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //此字符串充当表示 某种 表单元/cell 的键,即是cell一种标识符,也就是表示cell的某种特性
    //背景:每个UITableViewCell都是一个对象,都是需要资源开销的.如果数据有有一万条数据,那么系统也要为应用创建一万个cell么?这将要耗费巨大的资源,不现实
    //而SimpleTableIdentifier特性表示cell是可重用的(即当表视图滑动时从屏幕上面滚出去的cell会被放到一个可重用队列里,当屏幕底部继续绘制新行时,将优先使用这些cell而不是创建新的cell),这样不管数据源有多少条,程序都只创建有限数量的cell,当屏幕滑动时,那些cell还是以前的那些cell,只不过将显示的数据换了一批而已.大体思想是这样的,具体有点不同,可以自己度娘
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    //当表视图需要绘制一行时,会优先使用表视图里的可重用队列里的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    /*
     当可重用队列里没有多余的cell后(在程序刚开始运行时,肯定是没有的啦),就只能新建了,
     当然,新建的cell也是指定为SimpleTableIdentifier的,同时还要指定新建的cell的style属性
     当系统内存紧张时,表视图会删除这些可重用队列里的cell
     把新建的cell指定为自动释放
     
     cell的style包括图像 文本 和详细文本三种元素, style参数具体值的说明如下:
     UITableViewCellStyleDefault:只显示文本和图片
     UITableViewCellStyleValue1:显示文本 图片 和详细文本,详细文本在cell的右边,颜色为浅蓝色
     UITableViewCellStyleValue2:只显示文本和详细文本并局中显示,但文本颜色为浅蓝色,并且字体变小颜色为浅蓝色,使用于电话/联系人应用程序
     UITableViewCellStyleSubtitle:显示文本 图片 和详细文本,详细文本在文本的下面,颜色为浅灰色
     它们具体使用的场合有待度娘
     */
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:SimpleTableIdentifier];
    }
    
    //根据表视图的行数,从数组里获取对应索引的数据
    NSInteger mRow = [indexPath row];
    if (isSearchActiveDM)
    {
        cell.textLabel.text = [[filteredArr objectAtIndex:mRow]objectForKey:@"appName"];
    }
    else
    {
        cell.textLabel.text = [[resultArr objectAtIndex:mRow]objectForKey:@"appName"];
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (isSearchActiveDM)
    {
        appKey = [[filteredArr objectAtIndex:indexPath.row]objectForKey:@"appKey"];
        appName = [[filteredArr objectAtIndex:indexPath.row]objectForKey:@"appName"];
    }
    else
    {
        appKey = [[resultArr objectAtIndex:indexPath.row]objectForKey:@"appKey"];
        appName = [[resultArr objectAtIndex:indexPath.row]objectForKey:@"appName"];
    }
    
    [self performSegueWithIdentifier:@"wordPushToWeb" sender:self];

}


//modal跳转响应函数 PicBack 是modal的identify
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"wordPushToWeb"])
    {
        webVC *webView = segue.destinationViewController;
        
        webView.webStr = [NSString stringWithFormat:@"http://v.t.sina.com.cn/share/share.php?appkey=%@&;content=utf8", appKey];
    }
    
}
@end
