//
//  ViewController.m
//  weiboTail
//
//  Created by Colin on 14-9-7.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //背景颜色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"eyeBackground.jpg"]];
    
    //添加logo图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 70, 100, 100)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.image = [UIImage imageNamed:@"Icon-120.png"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 50.0;
#warning 设置边框的颜色
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.shouldRasterize = YES;
    imageView.clipsToBounds = YES;
    
    [self.view addSubview:imageView];
    
    
    //初始化数据
    //设置功能
    tableArr = [[NSArray alloc] initWithObjects:
                [NSArray arrayWithObjects:@"选尾巴,发微博", nil],
                [NSArray arrayWithObjects:@"版本更新", @"使用说明", @"关于我", @"意见建议", nil],
                nil];
    
    //图片数组
    picArr = [[NSArray alloc] initWithObjects:
              [NSArray arrayWithObjects:@"testIcon_3.png", nil],
              [NSArray arrayWithObjects:@"testIcon_1.png", @"testIcon_2.png", @"testIcon_5.png", @"testIcon_4.png", nil],
              nil];
    
    //添加列表
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 180, 320, 300)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    myTableView.backgroundColor = [UIColor clearColor];
#warning 禁止uitableview上下滑动
    myTableView.scrollEnabled = false;
    [self.view addSubview:myTableView];
    
    if (Screen_height == 568)
    {
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
    
    //读取沙盒数据
    NSUserDefaults * settings1 = [NSUserDefaults standardUserDefaults];
    NSString *key1 = [NSString stringWithFormat:@"isFirst"];
    NSString *value = [settings1 objectForKey:key1];
    if (!value)  //如果没有数据
    {
#warning 隐藏navigationbar
        self.navigationController.navigationBar.hidden = true;
#warning 设置引导页，具体查看github。
        [self showIntroWithCrossDissolve];
    }
    
}

#warning uitableview的全面用法。
#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tableArr objectAtIndex:section]count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tableArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 320, 30)];
    myLabel.text = @"微博";
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.textColor = [UIColor grayColor];
    myLabel.font = [UIFont boldSystemFontOfSize:20];
    myHeadView.backgroundColor = [UIColor clearColor];
    
    if (section == 1)
    {
        myLabel.text = @"关于";
    }
    [myHeadView addSubview:myLabel];
    
    return myHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIdentifier];
#warning 选中Cell的时候无色。
        cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时无色
    }
    cell.imageView.image = [UIImage imageNamed:[[picArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
    cell.textLabel.text = [[tableArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.detailTextLabel.text = @"已是最新版本";
    }
    else
    {
#warning 设置右边的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 && indexPath.row == 0)
    {
        [self showSortChooseView];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        self.navigationController.navigationBar.hidden = true;
        [self showIntroWithCrossDissolve];
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        [self showMyself];
    }
    else if (indexPath.section == 1 && indexPath.row == 3)
    {
        [self popupActionSheet];
    }
}
#pragma mark - 选择类型界面
- (void)showSortChooseView
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"类别选择" contentText:@"请选择你要添加的微博小尾巴类型" leftButtonTitle:@"手机型号" rightButtonTitle:@"个性文字"];
    [alert show];
    alert.leftBlock = ^()
    {
        [self performSegueWithIdentifier:@"phonePush" sender:self];
    };
    alert.rightBlock = ^()
    {
        [self performSegueWithIdentifier:@"wordPush" sender:self];
    };
    alert.dismissBlock = ^()
    {
    };
}
#pragma mark - 使用说明, 引导页
//引导页界面
#warning 快速的自定义新特性页面,初始化
- (void)showIntroWithCrossDissolve
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"intro_1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"intro_2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"intro_3"];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:@"intro_4"];
    

    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
#warning 通过代理方法introDidFinish来结束新特性页面
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}


//引导页结束
- (void)introDidFinish
{
    self.navigationController.navigationBar.hidden = false;
    
    //写入数据
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * key = [NSString stringWithFormat:@"isFirst"];
    [setting setObject:[NSString stringWithFormat:@"false"] forKey:key];
    [setting synchronize];
}

#pragma mark - 显示个人资料
- (void)showMyself
{
#warning 自定义AlterView视图
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Colin" contentText:@"QQ: 648654371\n邮箱: hitwhylz@163.com\n博客: blog.csdn.net/hitwhylz" leftButtonTitle:@"联系" rightButtonTitle:@"取消"];
    [alert show];
#warning 点击左按钮
    alert.leftBlock = ^()
    {
#warning 实现发送邮件的功能，需要添加MessageUI框架
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            
            //设置收件人，可以设置多人
            [picker setToRecipients:[NSArray arrayWithObjects:@"hitwhylz@163.com",nil]];
            //设置主题
            //设备相关信息的获取
            NSString *strName = [[UIDevice currentDevice] name];  //e.g. "My iPhone"
            NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];  // e.g. @"4.0"
            NSString *strModel = [[UIDevice currentDevice] model];  // e.g. @"iPhone", @"iPod touch"
            
            [self presentModalViewController:picker animated:YES];
        }
        
        else
        {
            NSString *msg = @"无法正常发送邮件，请重新设置。";
            [self alertWithTitle:nil msg:msg];
            
        }
    };
#warning 点击右按钮视图
    alert.rightBlock = ^()
    {
    };
    alert.dismissBlock = ^()
    {
    };
    
}


#pragma 邮件，短信功能的处理

//响应邮件发送完
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:
(NSError*)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
	[self dismissModalViewControllerAnimated:YES];
}

//响应短信发送完
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    
    NSString *msg;
    
    switch (result)
    {
        case MessageComposeResultCancelled:
            msg = @"短信发送取消";
            [self alertWithTitle:nil msg:msg];
            break;
        case MessageComposeResultSent:
            msg = @"短信发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MessageComposeResultFailed:
            msg = @"短信发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
	[self dismissModalViewControllerAnimated:YES];
    
}




//弹出选择界面。
-(void)popupActionSheet
{
	UIActionSheet *popupQuery = [[UIActionSheet alloc]
								 initWithTitle:nil
								 delegate:self
								 cancelButtonTitle:@"取消"
								 destructiveButtonTitle:nil
								 otherButtonTitles:@"邮件",@"短信",nil];
	
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
}


//响应选择。 跳出相应界面。
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    NSString *msg;
    //选中发送邮件形式
	if (buttonIndex == 0)
    {
		// mail note
        
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            
            //设置收件人，可以设置多人
            [picker setToRecipients:[NSArray arrayWithObjects:@"hitwhylz@163.com",nil]];
            //设置主题
            //设备相关信息的获取
            NSString *strName = [[UIDevice currentDevice] name];  //e.g. "My iPhone"
            NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];  // e.g. @"4.0"
            NSString *strModel = [[UIDevice currentDevice] model];  // e.g. @"iPhone", @"iPod touch"
            
            //手机型号。#include <sys/types.h>     #include <sys/sysctl.h>
            size_t size;
            sysctlbyname("hw.machine", NULL, &size, NULL, 0);
            char *machine = (char*)malloc(size);
            sysctlbyname("hw.machine", machine, &size, NULL, 0);
            NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
            
            //app应用相关信息的获取
            NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
            NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];  // 当前应用名称
            NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
            // 当前应用软件版本  比如：1.0.1
            
            [picker setSubject: @"微博小尾巴"];
            [picker setMessageBody:[NSString stringWithFormat:@"设备名称：%@ \n系统版本号：%@\n设备模式：%@\n手机型号: %@\nApp应用名称：%@\nApp应用版本：%@\n",strName,strSysVersion,strModel,platform,strAppName,strAppVersion] isHTML:NO];
            
            [self presentModalViewController:picker animated:YES];
        }
        
        else
        {
            msg = @"无法正常发送邮件，请重新设置。";
            [self alertWithTitle:nil msg:msg];
            
        }
	}
    
    //选中发送短信形式
    if (buttonIndex == 1) {
        
        Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
        
        if (messageClass != nil) {
            // Check whether the current device is configured for sending SMS messages
            if ([messageClass canSendText])
            {
                MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
                picker.messageComposeDelegate = self;
                
                //设置收件人号码
                [picker setRecipients:[NSArray arrayWithObjects:@"11111111111", nil]];
                //设置主题
                //设备相关信息的获取
                NSString *strName = [[UIDevice currentDevice] name];  //e.g. "My iPhone"
                NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];  // e.g. @"4.0"
                NSString *strModel = [[UIDevice currentDevice] model];  // e.g. @"iPhone", @"iPod touch"
                NSString* phoneModel = [[UIDevice currentDevice] model];   //手机型号
                //app应用相关信息的获取
                NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
                NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];  // 当前应用名称
                NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
                // 当前应用软件版本  比如：1.0.1
                
                picker.body = [NSString stringWithFormat:@"设备名称：%@ \n系统版本号：%@\n设备模式：%@\n设备型号: %@\nApp应用名称：%@\nApp应用版本：%@\n",strName,strSysVersion,strModel,phoneModel,strAppName,strAppVersion];
                [self presentModalViewController:picker animated:YES];
            }
            else {
                msg = @"设备上找不到SMS";
                [self alertWithTitle:nil msg:msg];
                
            }
        }
        else {
            msg = @"设备上找不到SMS";
            [self alertWithTitle:nil msg:msg];
        }
    }
    
}


//弹出UIAlertView 显示相关消息。
- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
