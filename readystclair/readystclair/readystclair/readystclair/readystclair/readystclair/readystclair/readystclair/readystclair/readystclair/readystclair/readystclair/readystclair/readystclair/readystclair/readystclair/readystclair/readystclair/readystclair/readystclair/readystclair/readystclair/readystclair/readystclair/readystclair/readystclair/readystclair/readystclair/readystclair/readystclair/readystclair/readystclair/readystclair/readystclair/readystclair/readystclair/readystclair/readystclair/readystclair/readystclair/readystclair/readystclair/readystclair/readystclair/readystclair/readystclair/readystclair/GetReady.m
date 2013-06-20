//
//  GetReady.m
//  readystclair
//
//  Created by james whetsell on 1/16/12.
//  Copyright 2012 src. All rights reserved.
//

#import "GetReady.h"
#import "PersonalInfoController.h"

@implementation GetReady
@synthesize tableView;


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
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
    [self setTableView:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [tableView release];
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
@end
