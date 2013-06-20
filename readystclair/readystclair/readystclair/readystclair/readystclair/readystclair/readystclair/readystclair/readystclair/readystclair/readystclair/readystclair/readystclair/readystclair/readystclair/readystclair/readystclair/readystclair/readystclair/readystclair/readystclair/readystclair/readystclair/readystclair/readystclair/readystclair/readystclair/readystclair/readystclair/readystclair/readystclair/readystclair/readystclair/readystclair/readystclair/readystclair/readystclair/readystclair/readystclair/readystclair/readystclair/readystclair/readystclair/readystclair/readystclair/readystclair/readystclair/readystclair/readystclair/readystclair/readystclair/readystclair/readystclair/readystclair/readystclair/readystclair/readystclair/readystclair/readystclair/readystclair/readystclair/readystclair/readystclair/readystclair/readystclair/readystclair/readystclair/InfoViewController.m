//
//  InfoViewController.m
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import "InfoViewController.h"
#import "PersonalInfoController.h"

@implementation InfoViewController
@synthesize tableView;

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
    
    [values addObject:[NSString stringWithFormat:@"Drought"]];
    [values addObject:[NSString stringWithFormat:@"Earthquakes"]];
    [values addObject:[NSString stringWithFormat:@"Explosions"]];
    [values addObject:[NSString stringWithFormat:@"Extreme Heat"]];
    [values addObject:[NSString stringWithFormat:@"Floods and Flash Floods"]];
    [values addObject:[NSString stringWithFormat:@"House Fires"]];
    [values addObject:[NSString stringWithFormat:@"Hurricanes"]];
    [values addObject:[NSString stringWithFormat:@"Influenza Pandemic"]];
    [values addObject:[NSString stringWithFormat:@"Public Health Disasters"]];
    [values addObject:[NSString stringWithFormat:@"Terrorism"]];
    [values addObject:[NSString stringWithFormat:@"Thunderstorms and Lightning"]];
    [values addObject:[NSString stringWithFormat:@"Tornadoes"]];
    [values addObject:[NSString stringWithFormat:@"Wildfires"]];
    [values addObject:[NSString stringWithFormat:@"Winter Advisories & Ice Storms"]];
    
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            fileName = @"drought";
//        } else if (indexPath.row == 1) {
//            fileName = @"earthquakes";
//        } else if (indexPath.row == 2) {
//            fileName = @"explosions";
//        } else if (indexPath.row == 3) {
//            fileName = @"floods";
//        } else if (indexPath.row == 4) {
//            fileName = @"heat";
//        } else if (indexPath.row == 5) {
//            fileName = @"floods";
//        } else if (indexPath.row == 6) {
//            fileName = @"house_fires";
//        } else if (indexPath.row == 7) {
//            fileName = @"hurricanes";
//        } else if (indexPath.row == 8) {
//            fileName = @"pandemic";
//        } else if (indexPath.row == 9) {
//            fileName = @"health_disasters";
//        } else if (indexPath.row == 10) {
//            fileName = @"terrorism";
//        } else if (indexPath.row == 11) {
//            fileName = @"storms";
//        } else if (indexPath.row == 12) {
//            fileName = @"tornado";
//        } else if (indexPath.row == 13) {
//            fileName = @"wildfire";
//        } else if (indexPath.row == 14) {
//            fileName = @"winter";
//        }
        PersonalInfoController *viewController =[[PersonalInfoController alloc] initWithNibName:@"PersonalInfoController" bundle:Nil];
        
       // viewController.file = fileName;
        
        if (viewController) [self presentModalViewController:viewController animated:YES];
        [viewController release];
    }




- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    
}
- (void)dealloc {
    [values release];
    [labels release];
    [tableView release];
    [super dealloc];
}
@end
