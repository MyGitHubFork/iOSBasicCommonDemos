//
//  ViewController.m
//  03-二维码生成
//
//  Created by aiteyuan on 14/11/24.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Helper.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputText;

@property (weak, nonatomic) IBOutlet UIImageView *qrImage;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //关闭键盘
    [self.view endEditing:YES];
    //生成二维码
    _qrImage.image = [_inputText.text createQRCode];
    return  YES;
}
@end
