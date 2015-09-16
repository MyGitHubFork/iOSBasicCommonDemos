//
//  ViewController.m
//  strong retain copy nsstring区别
//
//  Created by maiyun on 15/6/10.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (retain,nonatomic) NSString *myRetainStr;
@property (copy, nonatomic) NSString *myCopyStr;
@property (strong, nonatomic) NSString *myStrongStr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self testNSMutableStringCopyRetain];
    //[self testNSStringCopyRetain];
    //[self testNSStringStrongRetain];
    [self testNSMutableStringStrongRetain];
    
    //结论
    //retain和strong对于nsstrong和nsmutablestring效果都一样。都是指向一个地址。
    //对于nstring,retain和copy效果也一样。都是指向同一个地址。
    //对于nsmutablestring，retain和copy效果不一样。retain添加一个引用计数。copy实现深复制。
    //所以，nstring和nsmutablestring在一般情况下用copy修饰符都是完全正确的。
    
}

//NSMutableString的retain和copy区别
-(void)testNSMutableStringCopyRetain{
    NSMutableString *mStr = [NSMutableString stringWithFormat:@"abc"];
    self.myRetainStr   = mStr;
    self.myCopyStr     = mStr;
    NSLog(@"mStr:%p,%p",  mStr,&mStr);
    NSLog(@"retainStr:%p,%p", _myRetainStr, &_myRetainStr);
    NSLog(@"copyStr:%p,%p",   _myCopyStr, &_myCopyStr);
    
    //    2015-06-10 14:49:38.757 strong retain copy nsstring区别[6812:359227] mStr:0x7fed98536cd0,0x7fff56a199b8
    //    2015-06-10 14:49:38.758 strong retain copy nsstring区别[6812:359227] retainStr:0x7fed98536cd0,0x7fed98541fd8
    //    2015-06-10 14:49:38.758 strong retain copy nsstring区别[6812:359227] copyStr:0x7fed9853db50,0x7fed98541fe0
    
    //从运行结果看出,对于NSMutableString retain是添加引用计数。 copy是深复制

}

//NSString的retain和copy区别
-(void)testNSStringCopyRetain{
    NSString *mStr = [NSString stringWithFormat:@"abc"];
    self.myRetainStr   = mStr;
    self.myCopyStr     = mStr;
    NSLog(@"mStr:%p,%p",  mStr,&mStr);
    NSLog(@"retainStr:%p,%p", _myRetainStr, &_myRetainStr);
    NSLog(@"copyStr:%p,%p",   _myCopyStr, &_myCopyStr);
    
//    2015-06-10 14:53:19.822 strong retain copy nsstring区别[6847:361075] mStr:0x7fbc00c44c30,0x7fff547b69b8
//    2015-06-10 14:53:19.822 strong retain copy nsstring区别[6847:361075] retainStr:0x7fbc00c44c30,0x7fbc00d12d58
//    2015-06-10 14:53:19.822 strong retain copy nsstring区别[6847:361075] copyStr:0x7fbc00c44c30,0x7fbc00d12d60
    
    //从运行结果看出,对于NSString来看 retain是添加引用计数。 copy是浅复制。他们之间没有区别
    
}


//NSString的retain和Strong区别
-(void)testNSStringStrongRetain{
    NSString *mStr = [NSString stringWithFormat:@"abc"];
    self.myRetainStr   = mStr;
    self.myStrongStr     = mStr;
    NSLog(@"mStr:%p,%p",  mStr,&mStr);
    NSLog(@"retainStr:%p,%p", _myRetainStr, &_myRetainStr);
    NSLog(@"StrongStr:%p,%p",   _myStrongStr, &_myStrongStr);
    
//    2015-06-10 14:57:41.983 strong retain copy nsstring区别[6919:363984] mStr:0x7f894a49db90,0x7fff5aaf69b8
//    2015-06-10 14:57:41.983 strong retain copy nsstring区别[6919:363984] retainStr:0x7f894a49db90,0x7f894a543db8
//    2015-06-10 14:57:41.983 strong retain copy nsstring区别[6919:363984] StrongStr:0x7f894a49db90,0x7f894a543dc8

    
    //从运行结果看出,对于NSString来看 retain是添加引用计数。 strong是浅复制。 效果都一样。指向同一个地址
    
}


//NSMutableString的retain和Strong区别
-(void)testNSMutableStringStrongRetain{
    NSMutableString *mStr = [NSMutableString stringWithFormat:@"abc"];
    self.myRetainStr   = mStr;
    self.myStrongStr     = mStr;
    NSLog(@"mStr:%p,%p",  mStr,&mStr);
    NSLog(@"retainStr:%p,%p", _myRetainStr, &_myRetainStr);
    NSLog(@"StrongStr:%p,%p",   _myStrongStr, &_myStrongStr);
    
//    2015-06-10 15:01:54.719 strong retain copy nsstring区别[6963:366057] mStr:0x7f9033715590,0x7fff58f749b8
//    2015-06-10 15:01:54.720 strong retain copy nsstring区别[6963:366057] retainStr:0x7f9033715590,0x7f9033617e28
//    2015-06-10 15:01:54.720 strong retain copy nsstring区别[6963:366057] StrongStr:0x7f9033715590,0x7f9033617e38
    
    
    //从运行结果看出,对于NSString来看 retain是添加引用计数。 strong是浅复制。 效果都一样。指向同一个地址
    
}


@end
