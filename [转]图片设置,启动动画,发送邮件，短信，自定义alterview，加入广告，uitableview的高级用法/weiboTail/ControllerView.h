//
//  ManufactureView.h
//  DP1
//
//  Created by Umakanta on 11/11/13.
//  Copyright (c) 2013 THBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerView : UIView

@property(nonatomic,retain) UILabel *nameLabel;
@property(nonatomic,retain) UIButton *optionBtn,*dummyBtn;

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withCustomizationDict:(NSDictionary *)customizationDict;

@end
