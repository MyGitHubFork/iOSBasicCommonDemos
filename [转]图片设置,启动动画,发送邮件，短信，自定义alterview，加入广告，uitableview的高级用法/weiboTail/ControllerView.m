//
//  ManufactureView.m
//  DP1
//
//  Created by Umakanta on 11/11/13.
//  Copyright (c) 2013 THBS. All rights reserved.
//

#import "ControllerView.h"

@implementation ControllerView
@synthesize nameLabel,dummyBtn,optionBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withCustomizationDict:(NSDictionary *)customizationDict {

    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        
        
        
        nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 160, 35)];
        nameLabel.backgroundColor=[UIColor clearColor];
        nameLabel.textColor = customizationDict[@"headerLabelColor"];
        nameLabel.textAlignment=NSTextAlignmentLeft;
        nameLabel.font= customizationDict[@"headerLabelFont"];
        nameLabel.minimumScaleFactor=0.75f;
        nameLabel.text = title;
        nameLabel.tag = 1;
        
        
        optionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        optionBtn.frame=CGRectMake(275, 12, 25, 25);
        optionBtn.backgroundColor=[UIColor clearColor];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"Menu.png"] forState:UIControlStateNormal];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"Menu.png"] forState:UIControlStateHighlighted];
        optionBtn.contentMode = UIViewContentModeScaleAspectFit;
        //optionBtn.layer.borderWidth = 0.5;
        optionBtn.tag = 4;
        
        
        
        
        dummyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        dummyBtn.frame=CGRectMake(5, 0, 250, 50);
        dummyBtn.backgroundColor=[UIColor clearColor];
        dummyBtn.tag= 6;
        
        
        [self addSubview:nameLabel];
        [self addSubview:optionBtn];
        [self addSubview:dummyBtn];
        
        optionBtn.hidden = YES;
        self.layer.borderWidth = 0.5;
        
        UIColor *bgCol = customizationDict[@"headerSeparatorColor"];
        self.layer.borderColor = bgCol.CGColor;
        self.backgroundColor = customizationDict[@"headerBackGroundColor"];

               
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
