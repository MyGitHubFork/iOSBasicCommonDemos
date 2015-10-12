

#import <UIKit/UIKit.h>


@protocol RadioButtonDelegate;



@interface RadioButton : UIButton

@property (assign,nonatomic) id<RadioButtonDelegate> delegate;
//初始化
- (id)initWithFrame:(CGRect)frame typeCheck:(NSString *)type_check;
//点击按钮
-(void) checkBoxClicked;
- (void)resultReponse;
@end

//代理
@protocol RadioButtonDelegate
- (void)radioButtonChange:(RadioButton *)radiobutton;
@end