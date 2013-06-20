//
//  PersonalInfoController.m
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import "PersonalInfoController.h"
#import "PIDetailController.h"
#import "DataElement.h"
#import "PIHeaderDisplayData.h"

@implementation PersonalInfoController
@synthesize editButton;
@synthesize tableViewOutlet;

@synthesize infoType, fields, headerFields, aboutMeSections, sections;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aboutMeSections = [[NSMutableArray alloc] init ];
    [aboutMeSections addObject:@"About Me"];
    

    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadHeaderField:infoType];

}

- (void) loadHeaderField:(int)groupKey {
    if (sqlManager == nil) sqlManager = [[SQLManager alloc] init];
    
    if (headerFields == nil) headerFields = [[NSMutableArray alloc] init];
    
    [headerFields removeAllObjects];
    
    headerFields = [sqlManager getNamesForGroup:infoType];
    
    NSLog(@"table data reload");
    [tableViewOutlet reloadData];    
}

- (void)viewDidUnload {
    [self setTableViewOutlet:nil];
    [self setEditButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) loadAboutMeData:(int)groupKey {
    
    // @synthesize oid, groupKey, fieldName, fieldType, value;
    
    // @synthesize oid, groupKey, fieldName, fieldType, value;
    [fields release];
    
    fields = [[NSMutableArray alloc] init ];
    
    NSLog(@"calling sql amanger");
    
    NSInteger *val = (NSInteger *)groupKey;
    
    fields = [sqlManager getFields:val]; 
    
    NSLog(@"Fields Count %d", [fields count]);

}

- (IBAction)addPersonalInfoButtonPressed:(id)sender {
    PIDetailController *viewController =[[PIDetailController alloc] initWithNibName:@"PIDetailController" bundle:Nil];
    
    // viewController.file = fileName;
    /*
     AboutMe = 1,
     Family = 2,
     Pets = 3,
     Contacts = 4,
     employee = 5,
     student = 6,
     meetingPlaces = 7,
     outOfTown = 8
     */
    
    switch (infoType) { 
        case AboutMe: 
            [self loadAboutMeData:1]; 
            viewController.headers = aboutMeSections;
            viewController.fields = fields;
            break;
        case Family:
            [self loadAboutMeData:2]; 
            [aboutMeSections replaceObjectAtIndex:0 withObject:[sections objectAtIndex:infoType-1]];
            viewController.headers = aboutMeSections;
            viewController.fields = fields;
            break;
        case Pets:
            [self loadAboutMeData:3]; 
            [aboutMeSections replaceObjectAtIndex:0 withObject:[sections objectAtIndex:infoType-1]];

            viewController.headers = aboutMeSections;
            viewController.fields = fields;
            break;
        case Contacts:
            [self loadAboutMeData:4]; 
            [aboutMeSections replaceObjectAtIndex:0 withObject:[sections objectAtIndex:infoType-1]];

            viewController.headers = aboutMeSections;
            viewController.fields = fields;
            break;
        case employee:
            [self loadAboutMeData:5]; 
            [aboutMeSections replaceObjectAtIndex:0 withObject:[sections objectAtIndex:infoType-1]];

            viewController.headers = aboutMeSections;
            viewController.fields = fields;
            break;
        case student:
            [self loadAboutMeData:6];
            [aboutMeSections replaceObjectAtIndex:0 withObject:[sections objectAtIndex:infoType-1]];

            viewController.headers = aboutMeSections;
            viewController.fields = fields;
            break;
        case meetingPlaces:
            [self loadAboutMeData:7]; 
            [aboutMeSections replaceObjectAtIndex:0 withObject:[sections objectAtIndex:infoType-1]];

            viewController.headers = aboutMeSections;
            viewController.fields = fields;
            break;
        case outOfTown:
            [self loadAboutMeData:8]; 
            [aboutMeSections replaceObjectAtIndex:0 withObject:[sections objectAtIndex:infoType-1]];

            viewController.headers = aboutMeSections;
            viewController.fields = fields;
            break;
        
    }
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
}

// Tableview Tables
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [headerFields count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
    
    return [sections objectAtIndex:infoType-1];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    } 

    DataElement *de = [headerFields objectAtIndex: indexPath.row];
    
    cell.textLabel.text = de.value;
    
    return cell;
}



- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryDetailDisclosureButton ;
}

- (void) tableView: (UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *) indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    PIDetailController *viewController =[[PIDetailController alloc] initWithNibName:@"PIDetailController" bundle:Nil];
    
    NSLog(@"select: %d", indexPath.row);
    
    PIHeaderDisplayData *data = [headerFields objectAtIndex:indexPath.row];
    
    fields = [sqlManager getDataDetails:data.dataKey];
    viewController.headers = aboutMeSections;
    viewController.fields = fields;
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object at the given index path
//        NSManagedObject *eventToDelete = [eventsArray objectAtIndex:indexPath.row];
//        [managedObjectContext deleteObject:eventToDelete];
//        
//        // Update Event objects array and table view
//        [eventsArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
//        
//        // Commit the change
//        NSError *error;
//        if (![managedObjectContext save:&error]) {
//            // Handle the error
//        }
        NSLog(@"delete");
        DataElement *de = [headerFields objectAtIndex: indexPath.row];
        
        infoType = de.groupKey;
        
        [headerFields removeObjectAtIndex:indexPath.row];
        [tableViewOutlet setEditing:NO animated:YES];

        
        [sqlManager deleteData:de];
        
        [self loadHeaderField:infoType];

    
        [tableView reloadData];
    } 
}

- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
    
- (void)dealloc {
    [tableViewOutlet release];
    [editButton release];
    [super dealloc];
}
- (IBAction)editButtonPressed:(id)sender {
    [tableViewOutlet setEditing:YES animated:YES];
}
    
@end
