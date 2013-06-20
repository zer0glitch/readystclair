//
//  GetReady.m
//  readystclair
//
//  Created by james whetsell on 1/16/12.
//  Copyright 2012 src. All rights reserved.
//

#import "GetReady.h"
#import "PersonalInfoController.h"
#import "ThreatsDetailController.h"
#import "AlertMonitor.h"

@implementation GetReady
@synthesize tableViewOutlet, monitor, timer;


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 
     labels = nil;
     values = nil;
     
     labels = [NSMutableArray new];
     values = [NSMutableArray new];
     
     [labels addObject:[NSString stringWithFormat:@"Personal Information"]]; 
     
     [values addObject:[NSString stringWithFormat:@"About Me"]];
     [values addObject:[NSString stringWithFormat:@"Family"]];
     [values addObject:[NSString stringWithFormat:@"Pets"]];
     [values addObject:[NSString stringWithFormat:@"Emergency Contacts"]];
     [values addObject:[NSString stringWithFormat:@"Work Information"]];
     [values addObject:[NSString stringWithFormat:@"School Information"]];
     [values addObject:[NSString stringWithFormat:@"Local Meeting Places"]];
     [values addObject:[NSString stringWithFormat:@"Out-of-Town Meeting Places"]];

     
     
     monitor = [[AlertMonitor alloc] init];
     [self checkAlerts];
     timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(checkAlerts) userInfo:nil repeats:YES];

 }
 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [self setTableViewOutlet:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [tableViewOutlet release];
    [values release];
    [labels release];
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
    
    PersonalInfoController *viewController =[[PersonalInfoController alloc] initWithNibName:@"PersonalInfoController" bundle:Nil];
    
    switch (indexPath.row) {
        case 0:
            viewController.infoType = AboutMe;
            break;
    }
    
    viewController.infoType = indexPath.row + 1;
    viewController.sections = values;
    
    // viewController.file = fileName;
    
    
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
    
    NSLog(@"row %d", indexPath.row);
}

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
