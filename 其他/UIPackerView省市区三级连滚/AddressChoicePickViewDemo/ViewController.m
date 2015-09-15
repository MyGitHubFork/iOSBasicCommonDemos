//
//  ViewController.m
//  AddressChoicePickViewDemo
//
//  Created by zhengzeqin on 15/5/28.
//  Copyright (c) 2015年 zhengzeqin. All rights reserved.
//  make by 郑泽钦 分享

#import "ViewController.h"
#import "AddressChoicePickerView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)tapPress:(UITapGestureRecognizer *)sender {
    AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc]init];
    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
        self.addressLabel.text = [NSString stringWithFormat:@"%@",locate];
        self.addressLabel.textColor = [UIColor blackColor];
    };
    [addressPickerView show];

}


@end
