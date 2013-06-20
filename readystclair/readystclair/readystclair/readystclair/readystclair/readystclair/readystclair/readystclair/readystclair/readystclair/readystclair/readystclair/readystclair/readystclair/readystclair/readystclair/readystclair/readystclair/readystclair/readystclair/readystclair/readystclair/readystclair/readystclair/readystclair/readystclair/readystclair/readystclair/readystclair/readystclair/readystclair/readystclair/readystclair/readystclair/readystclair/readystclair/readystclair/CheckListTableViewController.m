//
//  CheckListTableViewController.m
//
//  Created by Sascha Marc Paulus on 01.10.10.
//  Copyright 2010 paulusWebMedia. All rights reserved.
//


#import "CheckListTableViewController.h"
#import "CustomButton.h"

@implementation CheckListTableViewController

@synthesize dataList;
@synthesize checkPoints;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    dataList = [[NSMutableArray alloc] init];
	checkPoints = [[NSMutableArray alloc] init];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fillupDataList];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    
	[checkPoints release];
    [dataList release];
    [super dealloc];
}


#pragma mark -
#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return [dataList count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [[dataList objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"CheckListTableViewController_Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Clean cell.contentView
	for (id subView in cell.contentView.subviews) {
		[subView removeFromSuperview];
	}
	
	// Get Value form dataList
	NSString *textValue = (NSString*)[[dataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	// Some static vars for good object alignment (check images are 25x25)
	static CGFloat imagePuffer = 10;
	static CGFloat imageMargin = 5;
	static CGFloat textLabelSize = 260;
	
	// Create an UITextLabel for the content
	UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(25+imagePuffer+imageMargin, 0, textLabelSize-imagePuffer-imageMargin, 44)];
	[textLabel setBackgroundColor:[UIColor clearColor]];
	[textLabel setHighlightedTextColor:[UIColor whiteColor]];
	[textLabel setFont:[UIFont boldSystemFontOfSize:20]];
	[textLabel setText:textValue];
	// Add Label to cell.contentView
	[cell.contentView addSubview:textLabel];
	[textLabel release];
	
	// Images for checked and unchecked tasks
	UIImage *checked = [UIImage imageNamed:@"check_on.png"];
	UIImage *unchecked = [UIImage imageNamed:@"check_off.png"];
	
	// Create custom Button  
	CustomButton *checkbox = [[CustomButton alloc] init];
	// Important: Set @property indexPath to current indexPath
	[checkbox setIndexPath:indexPath];
	[checkbox addTarget:self action:@selector(hitCheckbox:) forControlEvents:UIControlEventTouchUpInside];
	[checkbox setFrame:CGRectMake(5, 22-12.5, 25, 25)];
	// Value is in checkPoints? Fine, show checked Task Image No? Show unchecked Task Image
	if ([self.checkPoints containsObject:textValue]) 
	{
		[checkbox setImage:checked forState:UIControlStateNormal];
	}
	else 
	{
		[checkbox setImage:unchecked forState:UIControlStateNormal];
	}
	// Add CustomButton to cell.contentView
	[cell.contentView addSubview:checkbox];
	[checkbox release];
	
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{  
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{ }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
{
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
}

#pragma mark -
#pragma mark Others

- (void) fillupDataList
{
	[dataList removeAllObjects];
	
	[dataList addObject:[NSArray arrayWithObjects:@"Sascha",@"Anna",@"Lisa",nil]];
	
}

- (void) hitCheckbox:(CustomButton*)sender
{
	// get value from dataList by indexPath from customButton (set in cellForRowAtIndexPath)
	NSString *object = [[dataList objectAtIndex:sender.indexPath.section] objectAtIndex:sender.indexPath.row];
	
	// if value is in checkPoints remove the value else add the value
	if ([self.checkPoints containsObject:object]) 
	{
		[self.checkPoints removeObject:object];
	}	
	else 
	{
		[self.checkPoints addObject:object];
	}
	
	// relaod tableView	
	[self.tableView reloadData];
}

@end

