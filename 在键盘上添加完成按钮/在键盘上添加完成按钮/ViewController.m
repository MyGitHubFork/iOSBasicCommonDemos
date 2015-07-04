//
//  ViewController.m
//  在键盘上添加完成按钮
//
//  Created by 黄成都 on 15/7/4.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textfield.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self showKeyBoardTopView];
}


- (IBAction)clickButton:(id)sender {
    [self.textfield resignFirstResponder];
}


-(void)showKeyBoardTopView{
    UIToolbar * topKeyboardView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topKeyboardView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"Done",nil,nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topKeyboardView setItems:buttonsArray];
    //http://lqcjdx.blog.163.com/blog/static/20748924120138209730559/
    [self.textfield setInputAccessoryView:topKeyboardView];
}



-(void)dismissKeyBoard
{
    [self.textfield resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
