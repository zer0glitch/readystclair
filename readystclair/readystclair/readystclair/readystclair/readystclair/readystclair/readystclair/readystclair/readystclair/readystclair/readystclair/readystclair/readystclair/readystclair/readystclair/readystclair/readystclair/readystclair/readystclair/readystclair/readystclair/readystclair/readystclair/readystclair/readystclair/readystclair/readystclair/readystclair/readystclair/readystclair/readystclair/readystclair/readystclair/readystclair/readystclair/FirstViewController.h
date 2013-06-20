//
//  FirstViewController.h
//  readystclair
//
//  Created by james whetsell on 1/16/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController {
    UIView *mainPageMenuContainer;
    IBOutlet UILabel *alertLabel;
    IBOutlet UIImageView *myPlanButton;
}
- (IBAction)planButtonPressed:(id)sender;

@property (nonatomic, retain) IBOutlet UIView *mainPageMenuContainer;
- (IBAction)checklistButtonPressed:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)planButtonPressed:(id)sender;
- (IBAction)threathButtonPressed:(id)sender;
- (IBAction)mapButtonPressed:(id)sender;

@end
