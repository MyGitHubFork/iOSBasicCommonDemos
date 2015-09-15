//
//  YADNewAddressViewController.m
//  mtNew
//
//  Created by yifan on 15/8/31.
//  Copyright (c) 2015年 MYun. All rights reserved.
//

#import "YADNewAddressViewController.h"
#import "MYAddressPickerView.h"

//屏幕尺寸
#define __kScreenBounds     [[UIScreen mainScreen]bounds]
#define __kScreenWidth      [[UIScreen mainScreen]bounds].size.width
#define __kScreenHeight     [[UIScreen mainScreen]bounds].size.
//以RGB的格式设置颜色
#define __kColorWithRGB(x,y,z,a)  [UIColor colorWithRed:x/255.0 green:y/255.0  blue:z/255.0  alpha:(a/1)]
@interface YADNewAddressViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,copy)NSDictionary *addressDic;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@property (weak, nonatomic) IBOutlet UITextView *detailAddressTextView;

@property (weak, nonatomic) IBOutlet UISwitch *morenswitch;
@property(nonatomic,strong)UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;

@property(nonatomic,strong)UILabel *placeLable;
@end

@implementation YADNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建收货地址";
    
    if (self.morenswitch.on) {
        self.morenswitch.thumbTintColor = __kColorWithRGB(21, 121, 198, 1);
    }else{
        self.morenswitch.thumbTintColor = __kColorWithRGB(199, 203, 208, 1);
    }
    [ self.morenswitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.morenswitch.tintColor = __kColorWithRGB(241, 241, 241, 1);
    self.morenswitch.onTintColor = __kColorWithRGB(241, 241, 241, 1);

    //=================================省市区用法开始===============
    //设置省市区拾取器
    MYAddressPickerView *addrPickView = [[MYAddressPickerView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 256)];
    //做数据初始化
    [addrPickView initData];
    //确定回调
    [addrPickView setAddressCallback:^(NSString *addressCode,NSString *address,NSDictionary *addressDict) {
        self.addressDic = addressDict;
        NSLog(@"选中的地址信息%@",self.addressDic);
        self.addressTextField.text = address;
        [self.addressTextField resignFirstResponder];
    }];
    //取消回调
    [addrPickView setCancelCallback:^{
        [self.addressTextField resignFirstResponder];
    }];
    self.addressTextField.inputView = addrPickView;
    //=================================省市区用法结束===============
    
    //登录按钮
    self.loginButton = [[UIButton alloc]init];
    self.loginButton.backgroundColor = [UIColor lightGrayColor];
    [self.loginButton setTitle:@"保存并使用" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.loginButton addTarget:self action:@selector(saveNewAddress:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.frame = CGRectMake(12, 210, __kScreenWidth - 24, 40);
    [self.view addSubview:self.loginButton];
    
    //给uitextview添加palcetext。。通过添加一个uilabel实现
    self.placeLable = [[UILabel alloc]init];
    self.placeLable.textColor = __kColorWithRGB(227, 227, 227, 1);
    self.placeLable.text = @"详细地址";
    self.placeLable.frame = CGRectMake(5, 0, 100, 30);
    if (self.detailAddressTextView.text.length == 0) {
        self.placeLable.hidden = NO;
    }else{
        self.placeLable.hidden = YES;
    }
    [self.detailAddressTextView addSubview:self.placeLable];
    self.detailAddressTextView.delegate = self;
    self.detailAddressTextView.returnKeyType = UIReturnKeyDone;
    
    //添加监听
    self.nameTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.addressTextField.delegate = self;
    //右侧按钮点击监听
    [self.addressButton addTarget:self action:@selector(clickAddressButton:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark textfield的代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self isAllInput];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self isAllInput];
    return YES;
}

#pragma textview的代理方法
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeLable.hidden = NO;
    }else{
        self.placeLable.hidden = YES;
    }
    [self isAllInput];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark 点击滑动按钮
- (void) switchValueChanged:(id)sender{
    UISwitch* control = (UISwitch*)sender;
    if(control == self.morenswitch){
        BOOL on = control.on;
        //添加自己要处理的事情代码
        if (on) {
            self.morenswitch.thumbTintColor = __kColorWithRGB(21, 121, 198, 1);
        }else{
            self.morenswitch.thumbTintColor = __kColorWithRGB(199, 203, 208, 1);
        }
    }
}
#pragma mark 点击省市区textview的右侧按钮时候改变状态
-(void)clickAddressButton:(UIButton *)sender{
    if ([self.addressTextField isFirstResponder]) {
        return;
    }else{
        [self.nameTextField resignFirstResponder];
        [self.phoneTextField resignFirstResponder];
        [self.addressTextField becomeFirstResponder];
        [self.detailAddressTextView resignFirstResponder];
    }
}
#pragma mark 点击登录按钮
-(void)saveNewAddress:(UIButton *)sender{
    NSLog(@"点击登录");
}
#pragma mark 判断当前是否可以登录
- (void)isAllInput
{
    if (_nameTextField.text.length && _addressTextField.text.length && _phoneTextField.text.length && _detailAddressTextView.text.length) {
        self.loginButton.userInteractionEnabled = YES;
        self.loginButton.backgroundColor = __kColorWithRGB(3, 102, 204, 1);
    }else{
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma marl 屏幕点击
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.detailAddressTextView resignFirstResponder];
}

@end
