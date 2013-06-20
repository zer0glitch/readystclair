//
//  PersonalInfoController.m
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import "PersonalInfoController.h"
#import "PIDetailController.h"

@implementation PersonalInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addPersonalInfoButtonPressed:(id)sender {
    PIDetailController *viewController =[[PIDetailController alloc] initWithNibName:@"PIDetailController" bundle:Nil];
    
    // viewController.file = fileName;
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
}
@end
