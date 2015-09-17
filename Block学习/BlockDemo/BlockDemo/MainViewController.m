//
//  MainViewController.m
//  BlockDemo
//
//  Created by aiteyuan on 14/10/30.
//  Copyright (c) 2014年 黄. All rights reserved.
//

#import "MainViewController.h"

#warning 定义一个Block类型
typedef int (^MyBlock)(int);

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
//-------------------------------------------
#warning Block的声明
    //int(^myBlock)(int);
#warning 创建block，这里不会执行block
//    myBlock = ^(int a){
//        NSLog(@"参数：%d",a);
//        return 10;
//    };
#warning 调用block，这里会执行block
//    int ret = myBlock(20);
//    NSLog(@"返回结果是%d", ret);
 
//----------------------------------------------
#warning 申明一个MyBlock类型的对象
//    MyBlock test = ^(int a){
//        int result = a * a;
//        NSLog(@"%d",result);
//        return result;
//    };
//    test(10);
    
//----------------------block作为参数传递-------------------------
//    MyBlock myblock = ^(int a)
//    {
//        NSLog(@"这是block代码块a = %d",a);
//        return a*a;
//    };
//    
//    [self testBlock:myblock];
//------------------------block引用局部变量---------------------------------
//    int number = 20;
//    __block int number1 = 10;
//    MyBlock myblock2 = ^(int a){
#warning 局部变量在block中是不可以修改的，只能作为常量使用。__block修饰的局部变量可以修改
//        NSLog(@"局部变量值%d",number);
//        number1 = number1 + 5;
//        NSLog(@"可以修改的局部变量%d",number1);
//        return 10*a;
//    };
#warning block调用__block局部变量的值是此时局部变量中存的值。在block中对局部变量的修改在block以外也有用。指向的都是一个值。
//    number1 = 35;
//    number = 25; //没有__block修饰的局部变量的修改，对block中没有影响，相当于block复制了一份。
//    myblock2(5);
//----------------------------------block内存管理-----------------------------------
#warning 当block里面引用一个局部对象时，改对象会被retain，如果使用__block修饰，则不会被retain
    NSObject *obj = [[NSObject alloc]init];
    MyBlock myblock2 = ^(int a){
        NSLog(@"这里会增加引用计数%@",obj.class);
        int value = 4;
        NSLog(@"如果在block中引入一个实例变量时，该block会被retain",self.class);
        return 10;
    };
    

}


#warning block作为参数
-(void)testBlock:(MyBlock)myBlock{
#warning 这里就是block的回调，调用其他地方实现的代码。实际上是调用代码实现的首地址
   int  a = myBlock(10);
    NSLog(@"block返回值%d", a);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
