

#import "RadioButton.h"


@implementation RadioButton

- (id)initWithFrame:(CGRect)frame typeCheck:(NSString *)type_check
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self setTitle:type_check forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:12];
		self.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
        [self setImage:[UIImage imageNamed:@"RadioButton_Not_check.png"] forState:UIControlStateNormal];
		[self addTarget:self action:@selector(checkBoxClicked) forControlEvents:UIControlEventTouchUpInside];
	}
    return self;
}

-(void) checkBoxClicked
{
    [self setImage:[UIImage imageNamed:@"RadioButton_check.png"] forState:UIControlStateNormal];
    [self resultReponse];
	
}
- (void)resultReponse{
	if (self.delegate) {
		[self.delegate radioButtonChange:self];
	}
	
}


@end
