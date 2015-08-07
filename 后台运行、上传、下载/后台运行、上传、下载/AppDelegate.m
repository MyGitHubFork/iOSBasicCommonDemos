//
//  AppDelegate.m
//  后台运行、上传、下载
//
//  Created by 黄成都 on 15/8/4.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#define Picture @"http://www.xf0573.com/attached/131702/qyxx/infrel/img/131702_20140929104216_7427.jpg"
#define Vedio @"http://221.228.249.82/youku/697A5CA0CEB3582FB91C4E3A88/03002001004E644FA2997704E9D2A7BA1E7B9D-6CAB-79A9-E635-3B92A92B3500.mp4"


typedef void(^CompletionHandlerType)();
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //告诉ios希望多久进行一次后台获取
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [[NSURL alloc]initWithString:Picture];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return ;
        }
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.frame = CGRectMake(20, 100, 100, 100);
        imageview.image = [UIImage imageWithData:data];
        [self.window addSubview:imageview];

    }];
    
    [self.window makeKeyAndVisible];
    
    [task resume];
    //判断应用是否是后台启动
    NSLog(@"Launched in background %d", UIApplicationStateBackground == application.applicationState);
    
    return YES;
}

#pragma mark 实现后台运行的委托方法
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [[NSURL alloc]initWithString:Picture];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completionHandler(UIBackgroundFetchResultFailed);
            return ;
        }
        if (data.length > 0) {
            completionHandler(UIBackgroundFetchResultNewData);
        }else{
            completionHandler(UIBackgroundFetchResultNoData);
        }
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.frame = CGRectMake(20, 200, 100, 100);
        imageview.image = [UIImage imageWithData:data];
        [self.window addSubview:imageview];
        
    }];
    
    [task resume];
}




#pragma mark 创建能后台运行的会话
-(NSURLSession *)backgroundURLSession{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *identifiere = @"io.objc.backgroundTransferExample";
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifiere];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    });
    return session;
}
#pragma mark 远程推送以后后台运行调用的方法
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"Received remote notification with userInfo %@", userInfo);
    
    NSNumber *contentID = userInfo[@"content-id"];
    NSString *downloadURLString = [NSString stringWithFormat:Vedio];
    NSURL* downloadURL = [NSURL URLWithString:downloadURLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    NSURLSessionDownloadTask *task = [[self backgroundURLSession] downloadTaskWithRequest:request];
    task.taskDescription = [NSString stringWithFormat:@"Podcast Episode %d", [contentID intValue]];
    [task resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
               downloadTask:(NSURLSessionDownloadTask *)downloadTask
  didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"downloadTask:%@ didFinishDownloadingToURL:%@", downloadTask.taskDescription, location);
    
    
    // Copy file to your app's storage with NSFileManager
    
    // ...
    
    
    // Notify your UI
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
   didResumeAtOffset:(int64_t)fileOffset
  expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten
  totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}

//===============================================
- (void)application:(UIApplication *)application
  handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    
    // You must re-establish a reference to the background session,
    
    // or NSURLSessionDownloadDelegate and NSURLSessionDelegate methods will not be called
    
    // as no delegate is attached to the session. See backgroundURLSession above.
    NSURLSession *backgroundSession = [self backgroundURLSession];
    
    NSLog(@"Rejoining session with identifier %@ %@", identifier, backgroundSession);
    
    
    // Store the completion handler to update your UI after processing session events
    [self addCompletionHandler:completionHandler forSession:identifier];
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    NSLog(@"Background URL session %@ finished events.\n", session);
    
    if (session.configuration.identifier) {
        
        // Call the handler we stored in -application:handleEventsForBackgroundURLSession:
        [self callCompletionHandlerForSession:session.configuration.identifier];
    }
}

- (void)addCompletionHandler:(CompletionHandlerType)handler forSession:(NSString *)identifier
{
//    if ([self.completionHandlerDictionary objectForKey:identifier]) {
//        NSLog(@"Error: Got multiple handlers for a single session identifier.  This should not happen.\n");
//    }
//    
//    [self.completionHandlerDictionary setObject:handler forKey:identifier];
}

- (void)callCompletionHandlerForSession: (NSString *)identifier
{
//    CompletionHandlerType handler = [self.completionHandlerDictionary objectForKey: identifier];
//    
//    if (handler) {
//        [self.completionHandlerDictionary removeObjectForKey: identifier];
//        NSLog(@"Calling completion handler for session %@", identifier);
//        
//        handler();
//    }
}






















- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
