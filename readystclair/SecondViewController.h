//
//  SecondViewController.h
//  readystclair
//
//  Created by james whetsell on 1/16/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertMonitor.h"

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableViewOutlet;
    
    
    NSMutableArray *labels;
    NSMutableArray *values;
    
    AlertMonitor *monitor;
    NSTimer *timer;
    IBOutlet UIButton *alertButton;

}

@property (nonatomic, retain) IBOutlet UITableView *tableViewOutlet;
- (IBAction)checklistButtonPressed:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)threatButtonPressed:(id)sender;
- (IBAction)mapButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *alertButton;

// Alerts
- (void) checkAlerts;
@property (nonatomic, retain) AlertMonitor *monitor;
@property (nonatomic, retain) NSTimer *timer;
- (IBAction)alertButtonPressed:(id)sender;


@end
