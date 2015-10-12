//
//  ViewController.h
//  PostCompress
//
//  Created by Jack Cox on 3/3/12.
//  
//

#import <UIKit/UIKit.h>
#import "CompressedRequest.h"

@interface ViewController : UIViewController {
    BOOL    keepRunning;
    double  timeTaken;
    double  iterations;
}
@property (retain, nonatomic) IBOutlet UITextField *urlField;
@property (retain, nonatomic) IBOutlet UISwitch *compressRequestSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *compressResponseSwitch;
@property (retain, nonatomic) IBOutlet UILabel *uncompPayloadSizeLabel;
@property (retain, nonatomic) IBOutlet UILabel *compPayloadSizeLabel;
@property (retain, nonatomic) IBOutlet UILabel *totalTimeConsumeLabel;
@property (retain, nonatomic) IBOutlet UILabel *avgRequestTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *iterationsLabel;


- (IBAction)startTest:(id)sender;
- (IBAction)stopTest:(id)sender;

@end
