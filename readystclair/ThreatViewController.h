//
//  ThreatViewController.h
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertMonitor.h"

@interface ThreatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>  {
    UITableView *tableViewOutlet;
    
    NSMutableArray *labels;
    NSMutableArray *values;
    
    AlertMonitor *monitor;
    NSTimer *timer;
    IBOutlet UIButton *alertButton;
}

@property (nonatomic, retain) IBOutlet UITableView *tableViewOutlet;
- (IBAction)closeWindow:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;

// Alerts
- (void) checkAlerts;
@property (nonatomic, retain) AlertMonitor *monitor;
@property (nonatomic, retain) NSTimer *timer;
- (IBAction)alertButtonPressed:(id)sender;

@end
