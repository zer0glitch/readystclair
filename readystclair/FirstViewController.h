//
//  FirstViewController.h
//  readystclair
//
//  Created by james whetsell on 1/16/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertMonitor.h"
#import "TwitterMonitor.h"
#import "sqlite3.h"

@interface FirstViewController : UIViewController {
    UIView *mainPageMenuContainer;
    IBOutlet UIButton *alertButton;
   // IBOutlet UILabel *alertLabel;
    IBOutlet UIImageView *myPlanButton;
    
    IBOutlet UIButton *newsButton;
    AlertMonitor *monitor;
    TwitterMonitor *tMonitor;

    NSTimer *timer;
}
- (IBAction)planButtonPressed:(id)sender;

@property (nonatomic, retain) IBOutlet UIView *mainPageMenuContainer;
@property (nonatomic, retain) AlertMonitor *monitor;
@property (nonatomic, retain) TwitterMonitor *tMonitor;

@property (nonatomic, retain) NSTimer *timer;

- (IBAction)checklistButtonPressed:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)planButtonPressed:(id)sender;
- (IBAction)threathButtonPressed:(id)sender;
- (IBAction)mapButtonPressed:(id)sender;
- (IBAction)alertButtonPressed:(id)sender;
- (IBAction)reportButtonPressed:(id)sender;


- (int) createData ;
- (void) checkAlerts;
- (int) checkData;


@end
