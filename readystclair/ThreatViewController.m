//
//  ThreatViewController.m
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import "ThreatViewController.h"
#import "ThreatsDetailController.h"

@implementation ThreatViewController
@synthesize tableViewOutlet, monitor, timer;

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
    
    labels = nil;
	values = nil;
	
	labels = [NSMutableArray new];
	values = [NSMutableArray new];
    
    [labels addObject:[NSString stringWithFormat:@"Threats"]]; 
    
    [values addObject:[NSString stringWithFormat:@"Tornadoes"]];
    [values addObject:[NSString stringWithFormat:@"Exterme Heat"]];
    [values addObject:[NSString stringWithFormat:@"Thunderstorms & Lightning"]];
    [values addObject:[NSString stringWithFormat:@"Floods"]];
    [values addObject:[NSString stringWithFormat:@"Terrorist Hazards"]];
    [values addObject:[NSString stringWithFormat:@"Winter Storms and Extreme Cold"]];
    [values addObject:[NSString stringWithFormat:@"Hazardous Materials"]];
    [values addObject:[NSString stringWithFormat:@"Chemical"]];
//    [values addObject:[NSString stringWithFormat:@"Public Health Disasters"]];
//    [values addObject:[NSString stringWithFormat:@"Terrorism"]];
//    [values addObject:[NSString stringWithFormat:@"Thunderstorms and Lightning"]];
//    [values addObject:[NSString stringWithFormat:@"Tornadoes"]];
//    [values addObject:[NSString stringWithFormat:@"Wildfires"]];
//    [values addObject:[NSString stringWithFormat:@"Winter Advisories & Ice Storms"]];
    

    monitor = [[AlertMonitor alloc] init];
    [self checkAlerts];
    timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(checkAlerts) userInfo:nil repeats:YES];
    
  
    
}

- (void)viewDidUnload
{
    [self setTableViewOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [labels release];
    [values release];
    [tableViewOutlet release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [values count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
	//if (section == 1) {
        return [labels objectAtIndex:0];  
   // } else return @"";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"row %d", indexPath.row);
    
    NSString *fileName = @"";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            fileName = @"tornado";
        } else if (indexPath.row == 1) {
            fileName = @"heat";
        } else if (indexPath.row == 2) {
            fileName = @"storms";
        } else if (indexPath.row == 3) {
            fileName = @"floods";
        } else if (indexPath.row == 4) {
            fileName = @"terrorism";
        } else if (indexPath.row == 5) {
            fileName = @"winter";
        } else if (indexPath.row == 6) {
            fileName = @"chemical";
        } else if (indexPath.row == 7) {
            fileName = @"blackouts";
        } else if (indexPath.row == 8) {
            fileName = @"pandemic";
        } else if (indexPath.row == 9) {
            fileName = @"health_disasters";
        } else if (indexPath.row == 10) {
            fileName = @"terrorism";
        } else if (indexPath.row == 11) {
            fileName = @"storms";
        } else if (indexPath.row == 12) {
            fileName = @"tornado";
        } else if (indexPath.row == 13) {
            fileName = @"wildfire";
        } else if (indexPath.row == 14) {
            fileName = @"winter";
        }
        ThreatsDetailController *viewController =[[ThreatsDetailController alloc] initWithNibName:@"ThreatsDetailController" bundle:Nil];
        
        viewController.file = fileName;
        
        if (viewController) [self presentModalViewController:viewController animated:YES];
        [viewController release];
    }}

- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];

}

- (IBAction)homeButtonPressed:(id)sender {
    
    self.tabBarController.selectedIndex= 0;
    [self.tabBarController.selectedViewController viewDidAppear:YES];
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
