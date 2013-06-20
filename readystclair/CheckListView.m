//
//  CheckListView.m
//  readystclair
//
//  Created by james whetsell on 2/20/12.
//  Copyright 2012 src. All rights reserved.
//

#import "CheckListView.h"
#import "CustomButton.h"


@implementation CheckListView

@synthesize dataList, checkPoints;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dataList = [[NSMutableArray alloc] init];
	checkPoints = [[NSMutableArray alloc] init];
    
    [self fillupDataList];

	
}

- (void)viewWillAppear:(BOOL)animated {
    dataList = [[NSMutableArray alloc] init];
	checkPoints = [[NSMutableArray alloc] init];
    [self fillupDataList];

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    
	[checkPoints release];
    [dataList release];
    [myTableView release];
    [super dealloc];
}


#pragma mark -
#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
    return [dataList count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return [dataList count];

    return [[dataList objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //for hight
    
    ChecklistData *clData = (ChecklistData*)[[dataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    int height = [clData.desc length];
    
    if (height == 0) {
        return 44;
    } else if (height <= 38) {
        return 64;
    }  else if (height <= 76) {
        return 84;
    } else if (height <= 114) {
        return 104;
    }
    
    return 44;
//    if (indexPath.row==0) {
//        return 63;
//    }else {
//        return 50;
//    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  NSLog(@"logging cell");
    
    static NSString *CellIdentifier = @"CheckListTableViewController_Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	
	// Clean cell.contentView
	for (id subView in cell.contentView.subviews) {
		[subView removeFromSuperview];
    //    NSLog(@"doing this");
	}
    
    
    /*
     NSString *htmlDefinition = [word.definition stringByReplacingOccurrencesOfString:@"\n"
     withString:@"<br />"];
     
     NSString  *htmlString = [NSString stringWithFormat:@"<h2>%@</h2><p>%@</p>",[word term],htmlDefinition];
     
     [htmlView loadHTMLString:htmlString baseURL:nil];
     
     scrollView.contentSize = [htmlView bounds].size;
     
     [scrollView addSubview:htmlView];
     
     [detailsViewController.view addSubview:htmlView];
     [htmlView release];
     htmlView = nil;
     */
	
	// Get Value form dataList
	ChecklistData *clData = (ChecklistData*)[[dataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	NSString *textValue =clData.name;
    NSString *descValue =clData.desc; 
    
    
    
   // NSString *textValue = (NSString*)[dataList objectAtIndex:indexPath.row ];

    
    // Some static vars for good object alignment (check images are 25x25)
	static CGFloat imagePuffer = 10;
	static CGFloat imageMargin = 5;
	static CGFloat textLabelSize = 200;
	
	// Create an UITextLabel for the content
	UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(25+imagePuffer+imageMargin, 0, textLabelSize-imagePuffer-imageMargin, 44)];
	[textLabel setBackgroundColor:[UIColor clearColor]];
	[textLabel setHighlightedTextColor:[UIColor whiteColor]];
	[textLabel setFont:[UIFont boldSystemFontOfSize:16]];
	[textLabel setText:textValue];
	// Add Label to cell.contentView
	[cell.contentView addSubview:textLabel];
	[textLabel release];
    
    int startHeight = 22;
    int numChars = [clData.desc length];
    
    if (numChars == 0) {
        startHeight = 10;
    } else if (numChars <= 38) {
        startHeight = 17;
    } else if (numChars <= 76) {
        startHeight = 30;
    } else if (numChars <= 114) {
        startHeight = 30;
    }
    
    if ([clData.desc length] > 0) {
        // Create an UITextLabel for the content
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(25+imagePuffer+imageMargin, startHeight, textLabelSize-imagePuffer-imageMargin, 44)];
        [descLabel setBackgroundColor:[UIColor clearColor]];
        [descLabel setHighlightedTextColor:[UIColor whiteColor]];
        [descLabel setFont:[UIFont fontWithName:@"Monaco" size:9]];
        [descLabel setText:descValue];
        descLabel.numberOfLines = 0;
        textLabel.lineBreakMode = UILineBreakModeWordWrap;
        
        CGSize labelSize = [descLabel.text sizeWithFont:descLabel.font 
                                      constrainedToSize:descLabel.frame.size 
                                          lineBreakMode:UILineBreakModeWordWrap];
        CGFloat labelHeight = labelSize.height;
        NSLog(@"labelHeight = %f", labelHeight);
        
 
        // Add Label to cell.contentView
        [cell.contentView addSubview:descLabel];
        [descLabel release];
        
        
        // cell.rowHeight = (CGFloat)60.0;
        NSString *trimmed =
        [clData.desc stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSLog(@"String length %d, %@", [trimmed length], trimmed);
        
        // myTableView.rowHeight = (CGFloat)60.0;
        
    }
    
  
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
//	if ([self.checkPoints containsObject:textValue]) 
//	{
//		[checkbox setImage:checked forState:UIControlStateNormal];
//	}
//	else 
//	{
//		[checkbox setImage:unchecked forState:UIControlStateNormal];
//	}
    
    if (clData.checked) {
        [checkbox setImage:checked forState:UIControlStateNormal];
    } else {
        [checkbox setImage:unchecked forState:UIControlStateNormal]; 
    }
	// Add CustomButton to cell.contentView
	[cell.contentView addSubview:checkbox];
	[checkbox release];
	
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {  
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{ }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
}

#pragma mark -
#pragma mark Others

- (void) fillupDataList {
    // Prep the database and then load data
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            char *errMsg;
            char *sql_stmt = "CREATE TABLE   CHECKLIST (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME, DESCRIPTION, CHECKED INTEGER)";
            
            int createResultCode = sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg);
            if (createResultCode != SQLITE_OK) {
                NSLog( @"Failed to create table %d", createResultCode);
            } else {
                
                
            }
            
            sqlite3_close(bereadyDB);
            
        } else {
            status.text = @"Failed to open/create database";
        }
    } else NSLog(@"Don't Know why this didn't work this time");
  //  [filemgr release];
    
    
    int dataCheck = [self checkData];
    
    if (dataCheck == 0) {
        [self createData];
    }
    

	[dataList removeAllObjects];
    
    NSMutableArray *dataSet;                        //simply defines a mutable Array
    
    dataSet = [[NSMutableArray alloc] init];  
    
    NSLog(@"loading data");
	// Get the data from the database
    sqlite3_stmt    *statement;
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSFileManager *queryFileManger = [NSFileManager defaultManager];
    
    if ([queryFileManger fileExistsAtPath: databasePath ] == YES) {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            
            NSString *querySQL = [NSString stringWithFormat: @"SELECT ID, NAME, DESCRIPTION, CHECKED from CHECKLIST"];
            
            //@"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
            
            const char *query_stmt = [querySQL UTF8String];
            int queryReturn = sqlite3_prepare_v2(bereadyDB, query_stmt, -1, &statement, NULL);
            
            if (queryReturn == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    NSString *description = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    int clId = sqlite3_column_int(statement, 0);
                    int checked = sqlite3_column_int(statement, 3);
                    
                    
                    // status.text = @"Match found";
                    
                    //ChecklistData clData = [[ChecklistData alloc] init];
                    ChecklistData *clData = [[ChecklistData alloc] init];  
                    
                    clData.name = name;
                    clData.desc = description;
                    clData.clID = clId;
                    clData.checked = checked;
     
                    
                    NSLog(@"name %@, descritpion %@", name, description);
                    
                    [dataSet addObject:clData];
                    
                    [clData release];
                    
                    [name release];
                    [description release];
                }
                sqlite3_finalize(statement);
            } else NSLog(@"Read failed %d", queryReturn);
        } else NSLog(@"Couldn't open the database");
        sqlite3_close(bereadyDB);
    } else NSLog(@"file path didn't exist");
    
    
    
 //   [queryFileManger release];
    
    [dataList addObject:dataSet];
    
    [dataSet release];
    
    // [dataList removeAllObjects];
    
    // [dataList addObject:[NSArray arrayWithObjects:@"Sascha",@"Anna",@"Lisa",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",@"33",nil]];
	
}

- (int) checkData {
    
    // Prep the database and then load data
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSLog(@"loading data");
	// Get the data from the database
    sqlite3_stmt    *statement;
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSFileManager *queryFileManger = [NSFileManager defaultManager];
    int count = 0;

    if ([queryFileManger fileExistsAtPath: databasePath ] == YES) {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            
            NSString *querySQL = [NSString stringWithFormat: @"SELECT NAME, DESCRIPTION, CHECKED from CHECKLIST"];
            
            //@"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
            
            const char *query_stmt = [querySQL UTF8String];
            int queryReturn = sqlite3_prepare_v2(bereadyDB, query_stmt, -1, &statement, NULL);
            
            if (queryReturn != 0) return 0;
            
            
            while( sqlite3_step(statement) == SQLITE_ROW )
                count++;
        }
  //      sqlite3_finalize(statement);
        
        sqlite3_close(bereadyDB);
    } 
    
    NSLog(@"return count %d", count);
    
   // [queryFileManger release];
    return count;
}

- (int) createData {
    
    // Prep the database and then load data
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSLog(@"loading data");
	// Get the data from the database
  //  sqlite3_stmt    *statement;
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSFileManager *queryFileManger = [NSFileManager defaultManager];
    int count = 0;
    
    if ([queryFileManger fileExistsAtPath: databasePath ] == YES) {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            
            char *errMsg;

            
            //  if ([self checkData ] == 0) {
            
            char *sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Water', 'At least 3 gallons per person for drinking and sanitation.', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Food', 'At least a 3-day supply of non-perishable food.', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Can opener', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Radio', 'Battery-powered or hand crank radio and a NOAA Weather Radio with tone alert.', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Flashlight', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Extra Batteries', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('First aid kit', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Whistle', 'To signal for help', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Face mask', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");            
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Moist towelettes, garbage bags, and plastic ties', 'For personal use.', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");            
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Wrench or pliers', 'To turn off utilities.', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Local map', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");            
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Prescription medications and glasses', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");            
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Instant formula and diapers', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");            
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Pet food and extra water', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");            
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Important family documents', 'Such as copies of insurance policies, identification and bank account records in a waterproof, portable container.', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Cash or traveler's checks and change', '', '0')";            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Emergency reference material', 'Such as first and book or informaiton from Ready.gov', '0')";
            
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");            
            
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Sleeping bag or warm blanket', 'for each person; consider adding bedding if you livein a coldweather climate.', '0')";         
            
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Complete change of clothing', 'Include a long sleeved shirt, long pants and shoes. Additoinal clothing for colder climates.', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");           
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Household chlorine bleach and medicine dropper', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Fire extinguisher', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Matches', 'Waterproof or stored in a waterproof container.', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Feminine supplies and personal hygiene items', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Mess kits, paper cups plates, plastic utensils, paper towels', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Paper and Pencil', '', '0')";
            if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('Books, games, puzzles or other activities for children', '', '0')";
             if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
        }        
        
    //    sqlite3_finalize(statement);
        
        sqlite3_close(bereadyDB);
    } 
    
    //NSLog(@"return count %d", count);
    
//    [queryFileManger release];
    return count;
}

- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void) hitCheckbox:(CustomButton*)sender
{
	//// get value from dataList by indexPath from customButton (set in cellForRowAtIndexPath)
//	NSString *object = [dataList objectAtIndex:sender.indexPath.row];
    
    
	ChecklistData *clData = [[dataList objectAtIndex:sender.indexPath.section] objectAtIndex:sender.indexPath.row];
    NSString *object = clData.name;
    
    if (clData.checked == 1) {
        clData.checked = 0;
    } else {
        clData.checked = 1;
    }
    
    [self updateState:clData];

    
	NSLog(@"Object: %@", object);
	// if value is in checkPoints remove the value else add the value
//	if ([self.checkPoints containsObject:object]) {
//		[self.checkPoints removeObject:object];
//	} else {
//		[self.checkPoints addObject:object];
//	}
	
	// relaod tableView	
	[myTableView reloadData];
}

- (void)viewDidUnload {
    [myTableView release];
    myTableView = nil;
    [super viewDidUnload];
}
- (void) updateState:(ChecklistData *)data{
    // Prep the database and then load data
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSLog(@"loading data");
	// Get the data from the database
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSFileManager *queryFileManger = [NSFileManager defaultManager];
    
    if ([queryFileManger fileExistsAtPath: databasePath ] == YES) {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            
            char *errMsg;
            
            
            //  if ([self checkData ] == 0) {
            
            NSString *updateSQL = [NSString stringWithFormat: @"UPDATE CHECKLIST set checked=%d where id=%d", data.checked, data.clID];
            
            const char *sql_stmt = [updateSQL UTF8String];
            
            NSLog(@"sql... %@", updateSQL);
            
            //char *sql_stmt = "INSERT INTO CHECKLIST set checked=%d where id=%d", clData;
             if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
            
          //  sqlite3_finalize(sql_stmt);
            
            sqlite3_close(bereadyDB);
        }
    
        
    } 
    
    //NSLog(@"return count %d", count);
    
  //  [queryFileManger release];
}

@end
