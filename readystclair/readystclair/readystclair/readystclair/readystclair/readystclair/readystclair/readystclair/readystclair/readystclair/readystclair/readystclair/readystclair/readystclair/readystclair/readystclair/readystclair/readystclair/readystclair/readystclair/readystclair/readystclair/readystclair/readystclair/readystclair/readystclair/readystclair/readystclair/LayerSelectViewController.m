//
//  LayerSelectViewController.m
//  readystclair
//
//  Created by james whetsell on 3/1/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import "LayerSelectViewController.h"


//@interface LayerSelectViewController ()
//
//@end

@implementation LayerSelectViewController

@synthesize localView, layer1, layer2, layer3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (layer1) switch1.on = YES;
    else switch1.on = NO;
    
    if (layer2) switch2.on = YES;
    else switch2.on = NO;
    
    if (layer3) switch3.on = YES;
    else switch3.on = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [uiSwitch release];
    uiSwitch = nil;
    [switch1 release];
    switch1 = nil;
    [switch2 release];
    switch2 = nil;
    [switch3 release];
    switch3 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
  
}

- (IBAction)layer1StateChanged:(id)sender {
    NSLog(@"1");
    
    if([sender isKindOfClass:[UISwitch class]]) {
        UISwitch *theSwitch = (UISwitch *)sender;
        [localView updateLayer:1 state:theSwitch.on];
    }
}
- (IBAction)layer2StateChanged:(id)sender {
    NSLog(@"2");

    if([sender isKindOfClass:[UISwitch class]]) {
        UISwitch *theSwitch = (UISwitch *)sender;
        [localView updateLayer:2 state:theSwitch.on];
    }

}
- (IBAction)layer3StateChanged:(id)sender {
    NSLog(@"3");

    if([sender isKindOfClass:[UISwitch class]]) {
        UISwitch *theSwitch = (UISwitch *)sender;
        [localView updateLayer:3 state:theSwitch.on];
    }

}

- (void)dealloc {
    [uiSwitch release];
    [switch1 release];
    [switch2 release];
    [switch3 release];
    [super dealloc];
}
@end
