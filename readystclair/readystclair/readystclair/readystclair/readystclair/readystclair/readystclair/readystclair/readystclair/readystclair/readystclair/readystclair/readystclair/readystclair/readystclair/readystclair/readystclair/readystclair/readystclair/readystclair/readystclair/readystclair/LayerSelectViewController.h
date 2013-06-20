//
//  LayerSelectViewController.h
//  readystclair
//
//  Created by james whetsell on 3/1/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalViewController.h"


@interface LayerSelectViewController : UIViewController {
    LocalViewController *localView;
    IBOutlet UISwitch *switch1;
    IBOutlet UISwitch *switch2;
    IBOutlet UISwitch *switch3;
    IBOutlet UISwitch *uiSwitch;
    
    BOOL layer1;
    BOOL layer2;
    BOOL layer3;
}

@property (nonatomic, retain) LocalViewController *localView;
@property (nonatomic) BOOL layer1;
@property (nonatomic) BOOL layer2;
@property (nonatomic) BOOL layer3;


- (IBAction)closeWindow:(id)sender;
- (IBAction)layer1StateChanged:(id)sender;
- (IBAction)layer2StateChanged:(id)sender;
- (IBAction)layer3StateChanged:(id)sender;

@end
