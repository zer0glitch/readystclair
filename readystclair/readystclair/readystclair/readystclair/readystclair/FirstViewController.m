//
//  FirstViewController.m
//  readystclair
//
//  Created by james whetsell on 1/16/12.
//  Copyright 2012 src. All rights reserved.
//

#import "FirstViewController.h"
#import "readystclairAppDelegate.h"
#import "CheckListView.h"
#import "ThreatViewController.h"
#import "LocalViewController.h"

@implementation FirstViewController
@synthesize mainPageMenuContainer;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    [mainPageMenuContainer.layer setCornerRadius:30.0f];
//    [mainPageMenuContainer.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [mainPageMenuContainer.layer setBorderWidth:1.5f];
//    [mainPageMenuContainer.layer setShadowColor:[UIColor blackColor].CGColor];
//    [mainPageMenuContainer.layer setShadowOpacity:0.8];
//    [mainPageMenuContainer.layer setShadowRadius:3.0];
//    [mainPageMenuContainer.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    alertLabel.text = @"No Alerts";
    alertLabel.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:101.0/255.0 blue:102.0/255.0 alpha:1.0];
    
    NSLog(@"I DID IT!!");
}

// Custom Handlers

- (IBAction)planButtonPressed:(id)sender {
   // NSLog(@"dude");
    
 //   [[self.tabBarController.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:NO];
    self.tabBarController.selectedIndex= 1;
    [self.tabBarController.selectedViewController viewDidAppear:YES];

}

- (IBAction)threathButtonPressed:(id)sender {
    NSLog(@"threat button");
    ThreatViewController *viewController =[[ThreatViewController alloc] initWithNibName:@"ThreatViewController" bundle:Nil];
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
}

- (IBAction)mapButtonPressed:(id)sender {
    NSLog(@"threat button");
    LocalViewController *viewController =[[LocalViewController alloc] initWithNibName:@"LocalViewController" bundle:Nil];
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { 
    UITouch *touch = [touches anyObject]; 
    NSLog(@"tag me"); 
    if([touch view] == myPlanButton) { 
        NSLog(@"show it");
       // readystclairAppDelegate *delegate = (readystclairAppDelegate *)[UIApplication sharedApplication].delegate;

        [[self.tabBarController.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:NO];
        self.tabBarController.selectedIndex= 1;
        [self.tabBarController.selectedViewController viewDidAppear:YES];


        
        //delegate.tabBarController.selectedIndex = 2;
        
       // [delegate release];
        
        //self.tabBarController.selectedIndex = 1;
        
    } 
}

// End Custom Handlers

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [self setMainPageMenuContainer:nil];
    [alertLabel release];
    alertLabel = nil;
    [myPlanButton release];
    myPlanButton = nil;
    [myPlanButton release];
    myPlanButton = nil;
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [mainPageMenuContainer release];
    [alertLabel release];
    [myPlanButton release];
    [myPlanButton release];
    [super dealloc];
}

- (IBAction)checklistButtonPressed:(id)sender {
    // CheckListTableViewController
    CheckListView *viewController =[[CheckListView alloc] initWithNibName:@"CheckListView" bundle:Nil];
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
}

- (IBAction)homeButtonPressed:(id)sender {
    self.tabBarController.selectedIndex= 0;
    [self.tabBarController.selectedViewController viewDidAppear:YES];
}


@end
