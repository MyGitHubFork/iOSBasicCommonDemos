

#import "MainVC.h"



@implementation MainVC


- (void)viewDidLoad {
    [super viewDidLoad];
	
	radioB_cart=[[RadioButton alloc] initWithFrame:CGRectMake(130, 200, 100, 25) typeCheck:@"A"];
	radioB_cart.delegate=self;
	[self.view addSubview:radioB_cart];
	
	radioB_member=[[RadioButton alloc] initWithFrame:CGRectMake(210, 200, 100, 25) typeCheck:@"B"];
	radioB_member.delegate=self;
	[self.view addSubview:radioB_member];
	
	radioB_member1=[[RadioButton alloc] initWithFrame:CGRectMake(240, 200, 100, 25) typeCheck:@"C"];
    radioB_member1.delegate=self;
	[self.view addSubview:radioB_member1];

	
}

//代理方法
- (void)radioButtonChange:(RadioButton *)radiobutton{
    
            for (UIView *myview in self.view.subviews)
            {
                if ([myview isKindOfClass:[RadioButton class]] && radiobutton != myview) {
                    [(RadioButton *)myview setImage:[UIImage imageNamed:@"RadioButton_Not_check.png"] forState:UIControlStateNormal];
                    
                }else if([myview isKindOfClass:[RadioButton class]] && radiobutton == myview){
                    [radiobutton setImage:[UIImage imageNamed:@"RadioButton_check.png"] forState:UIControlStateNormal];
#warning 这里可以得到选中的是哪一个按钮
                    NSLog(@"选中了%@", radiobutton.titleLabel.text);
                }
            }
}




@end
