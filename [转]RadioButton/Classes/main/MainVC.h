//
//  MainVC.h
//  SetLoss
//
//  Created by sunlg on 10-12-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"


@interface MainVC : UIViewController<RadioButtonDelegate> {
	
	RadioButton *radioB_cart;
	RadioButton *radioB_member;
	RadioButton *radioB_member1;
}
@end
