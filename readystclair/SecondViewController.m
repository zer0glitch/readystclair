//
//  SecondViewController.m
//  readystclair
//
//  Created by james whetsell on 1/16/12.
//  Copyright 2012 src. All rights reserved.
//

#import "SecondViewController.h"
#import "ForSeniorsView.h"
#import "SpeicalNeedsView.h"
#import "PetsView.h"
#import "CheckListView.h"
#import "ThreatViewController.h"
#import "LocalViewController.h"
#import "AlertMonitor.h"
#import "ThreatsDetailController.h"

@implementation SecondViewController
@synthesize alertButton;
@synthesize tableViewOutlet;
@synthesize monitor, timer;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    labels = nil;
	values = nil;
	
	labels = [NSMutableArray new];
	values = [NSMutableArray new];
    
    [labels addObject:[NSString stringWithFormat:@"Special Consideration"]]; 
    
    [values addObject:[NSString stringWithFormat:@"How to prepare"]]; 
    [values addObject:[NSString stringWithFormat:@"For seniors"]]; 
    [values addObject:[NSString stringWithFormat:@"For special needs"]]; 
    [values addObject:[NSString stringWithFormat:@"For pets"]]; 
    

    
    monitor = [[AlertMonitor alloc] init];
    [self checkAlerts];
    timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(checkAlerts) userInfo:nil repeats:YES];
    

    
}


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
    [self setTableViewOutlet:nil];
    [self setAlertButton:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [labels release];
    [values release];
    [tableViewOutlet release];
    [alertButton release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) return 3;
    else return 1;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
	if (section == 1) {
      return [labels objectAtIndex:0];  
    } else return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [values objectAtIndex:indexPath.row + indexPath.section];
    
    return cell;
    
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    //return UITableViewCellAccessoryDetailDisclosureButton;
    return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"row %d", indexPath.row);
    
    if ((indexPath.section == 0) && (indexPath.row == 0)) {
        ThreatsDetailController *viewController =[[ThreatsDetailController alloc] initWithNibName:@"ThreatsDetailController" bundle:Nil];
        
        //viewController.titleText = @"How to Prepare";
        
        viewController.file = @"get_ready";
        
        if (viewController) [self presentModalViewController:viewController animated:YES];
        [viewController release];
        
    }
    if ((indexPath.section == 1) && (indexPath.row == 0)) {
        ForSeniorsView *viewController =[[ForSeniorsView alloc] initWithNibName:@"ForSeniorsView" bundle:Nil];
        
        if (viewController) [self presentModalViewController:viewController animated:YES];
        [viewController release];
    }
    if ((indexPath.section == 1) && (indexPath.row == 1)) {
        SpeicalNeedsView *viewController =[[SpeicalNeedsView alloc] initWithNibName:@"SpeicalNeedsView" bundle:Nil];
        
        if (viewController) [self presentModalViewController:viewController animated:YES];
        [viewController release];
    }
    if ((indexPath.section == 1) && (indexPath.row == 2)) {
        PetsView *viewController =[[PetsView alloc] initWithNibName:@"PetsView" bundle:Nil];
        
        if (viewController) [self presentModalViewController:viewController animated:YES];
        [viewController release];
    }
    
    
//    BATTrailsViewController *trailsController = [[BATTrailsViewController alloc] initWithStyle:UITableViewStylePlain];
//    trailsController.selectedRegion = [regions objectAtIndex:indexPath.row];
//    [[self navigationController] pushViewController:trailsController animated:YES];
//    [trailsController release];
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

- (IBAction)threatButtonPressed:(id)sender {
    NSLog(@"threat button");
//    ThreatViewController *viewController =[[ThreatViewController alloc] initWithNibName:@"ThreatViewController" bundle:Nil];
//    
//    if (viewController) [self presentModalViewController:viewController animated:YES];
//    [viewController release];
    
    self.tabBarController.selectedIndex= 4;
    [self.tabBarController.selectedViewController viewDidAppear:YES];
}

- (IBAction)mapButtonPressed:(id)sender {
    NSLog(@"threat button");
    LocalViewController *viewController =[[LocalViewController alloc] initWithNibName:@"LocalViewController" bundle:Nil];
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
}

- (IBAction)alertButtonPressed:(id)sender {
    
    ThreatsDetailController *viewController =[[ThreatsDetailController alloc] initWithNibName:@"ThreatsDetailController" bundle:Nil];
    
    viewController.threatData = monitor.alertString;
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
     [viewController release];
}

- (void) checkAlerts{
    
    
    //NSMutableString *alertString =
    NSLog(@"checking alerts");
    [monitor checkAlerts];
    NSLog(@"alerts checked");
    
    NSLog(@"alertsString: %@", monitor.alertString);
    
    if (monitor.alertcount > 0) {
        UIImage *img = [UIImage imageNamed:@"ActiveAlert.png"];
        [alertButton setImage:img forState:UIControlStateNormal];
        // [img release];
    } else {
        UIImage *img = [UIImage imageNamed:@"NoAlert.png"];
        [alertButton setImage:img forState:UIControlStateNormal]; 
    }
    
    
}

@end
