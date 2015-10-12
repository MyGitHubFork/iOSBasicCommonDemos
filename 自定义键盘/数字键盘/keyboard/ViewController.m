//
//  ViewController.m
//  keyboard
//
//  Created by zhaowang on 14-3-25.
//  Copyright (c) 2014年 anyfish. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIButton *doneButton;
    UIView *view;
    
    AFFNumericKeyboard *keyboard;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    keyboard = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    self.textField.inputView = keyboard;
    keyboard.delegate = self;
 
}

-(void)changeKeyboardType
{
    [self.textField resignFirstResponder];
    self.textField.inputView = nil;
    [self.textField becomeFirstResponder];
    self.textField.inputView = keyboard;
}

-(void)numberKeyboardBackspace
{
    if (self.textField.text.length != 0)
    {
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length -1];
    }
}

-(void)numberKeyboardInput:(NSInteger)number
{
    self.textField.text = [self.textField.text stringByAppendingString:[NSString stringWithFormat:@"%d",number]];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
    
//    [UIView animateWithDuration:0.2 animations:^{
//        CGRect rect = doneButton.frame;
//        rect.origin.y += 53*5;
//        doneButton.frame = rect;
//
//    }];
    NSLog(@"%@",self.textField.text);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
