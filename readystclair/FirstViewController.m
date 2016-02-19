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
#import "AlertMonitor.h"
#import "TwitterMonitor.h"

#import "ReportViewController.h"
#import "ThreatsDetailController.h"

@implementation FirstViewController
@synthesize mainPageMenuContainer, monitor, timer, tMonitor;


//NSMutableString *alertString;

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
    
    // alertLabel.text = @"No Alerts";
    //  alertLabel.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:101.0/255.0 blue:102.0/255.0 alpha:1.0];
    
    [self createData];

    
    monitor = [[AlertMonitor alloc] init];
    //tMonitor = [[TwitterMonitor alloc] init];
    [self checkAlerts];
    
    [self checkData];
    
   timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(checkAlerts) userInfo:nil repeats:YES];
    
    NSLog(@"I DID IT!!");
}

// Custom Handlers

- (IBAction)planButtonPressed:(id)sender {
    // NSLog(@"dude");
    
    //   [[self.tabBarController.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:NO];
    self.tabBarController.selectedIndex= 2;
    [self.tabBarController.selectedViewController viewDidAppear:YES];
    
}

- (IBAction)threathButtonPressed:(id)sender {
    NSLog(@"threat button");
//    ThreatViewController *viewController =[[ThreatViewController alloc] initWithNibName:@"ThreatViewController" bundle:Nil];
//    
//    if (viewController) [self presentModalViewController:viewController animated:YES];
//   // [viewController release];
    
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

- (IBAction)reportButtonPressed:(id)sender {
 //   ReportViewController *viewController =[[ReportViewController alloc] initWithNibName:@"ReportViewController" bundle:Nil];
    
  //  if (viewController) [self presentModalViewController:viewController animated:YES];
   // [viewController release];
    
    self.tabBarController.selectedIndex= 1;
    [self.tabBarController.selectedViewController viewDidAppear:YES];
    
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setMainPageMenuContainer:nil];
    
//    [monitor release];
//    monitor = nil;
//    [myPlanButton release];
//    myPlanButton = nil;
//    [myPlanButton release];
//    myPlanButton = nil;
//    [alertButton release];
//    alertButton = nil;
    [newsButton release];
    newsButton = nil;
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
//    [monitor release];
//    
//    [mainPageMenuContainer release];
//    [myPlanButton release];
//    [myPlanButton release];
//    [alertButton release];
    [newsButton release];
    [super dealloc];
}

- (IBAction)checklistButtonPressed:(id)sender {
    // CheckListTableViewController
//    CheckListView *viewController =[[CheckListView alloc] initWithNibName:@"CheckListView" bundle:Nil];
//    
//    if (viewController) [self presentModalViewController:viewController animated:YES];
//    [viewController release];
    
    
    ThreatsDetailController *viewController =[[ThreatsDetailController alloc] initWithNibName:@"ThreatsDetailController" bundle:Nil];
    
   // viewController.threatData = tMonitor.twitterString;
    
    viewController.file = @"twitter";
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    [viewController release];
    
    
    
}

- (IBAction)homeButtonPressed:(id)sender {
    self.tabBarController.selectedIndex= 0;
    [self.tabBarController.selectedViewController viewDidAppear:YES];
}

// Creating Database

- (int) checkData {
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    //databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSLog(@"loading data");
	// Get the data from the database
    sqlite3_stmt    *statement;
    
    // Build the path to the database file
    NSString *databasePath; // = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    sqlite3 *bereadyDB;
    
    NSLog(@"loading data");
	// Get the data from the database
    
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
   //     sqlite3_finalize(statement);
        
        sqlite3_close(bereadyDB);
    } 
    
  //  NSLog(@"return count %d", count);
    
    // [queryFileManger release];
   // [docsDir dealloc];
    return count;
}

- (void) checkAlerts{
    
    
    //NSMutableString *alertString =
    NSLog(@"checking alerts");
    [monitor checkAlerts];
    [tMonitor checkAlerts];
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
    
    if (tMonitor.alertcount > 0) {
        UIImage *img = [UIImage imageNamed:@"twitter_d_color.png"];
        [newsButton setImage:img forState:UIControlStateNormal];
        // [img release];
    } else {
        UIImage *img = [UIImage imageNamed:@"twitter_d.png"];
        [newsButton setImage:img forState:UIControlStateNormal];
    }
    
    
}

- (int) createData {
    
    // Prep the database and then load data
    
    NSLog(@"here 1");
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    //databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSLog(@"loading data");
	// Get the data from the database
 //   sqlite3_stmt    *statement;
    NSLog(@"here 2");

    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    NSLog(@"here 3");

    sqlite3 *bereadyDB;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSLog(@"here 4");

    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
		const char *dbpath = [databasePath UTF8String];
        NSLog(@"here 5");

        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            NSLog(@"here 6");

            char *errMsg;
            char *sql_stmt = "CREATE TABLE   CHECKLIST (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME, DESCRIPTION, CHECKED INTEGER)";
            
            int createResultCode = sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg);
            if (createResultCode != SQLITE_OK) {
                NSLog( @"Failed to create table %d", createResultCode);
            } else {
                 
                NSLog(@"here 7");
       }
            NSLog(@"here 8");

            
            char *sql_stmt2 = "CREATE TABLE fields (ID INTEGER PRIMARY KEY AUTOINCREMENT, group_key INTEGER, field_name, default_value, field_type INTEGER)";
            NSLog(@"here 9");

            createResultCode = sqlite3_exec(bereadyDB, sql_stmt2, NULL, NULL, &errMsg);
            NSLog(@"here 10");

            if (createResultCode != SQLITE_OK) {
                NSLog( @"Failed to create table %d", createResultCode);
            } else {
                
            }
            NSLog(@"here 11");

            char *sql_stmt3 = "CREATE TABLE PIDATA (ID INTEGER PRIMARY KEY AUTOINCREMENT, group_key INTEGER, data_key INTEGER, field_name, value, field_type INTEGER, headerField INTEGER)";
            NSLog(@"here 12");

            createResultCode = sqlite3_exec(bereadyDB, sql_stmt3, NULL, NULL, &errMsg);
            if (createResultCode != SQLITE_OK) {
                NSLog( @"Failed to create table %d", createResultCode);
            } else {
                
            }
            NSLog(@"here 13");

            sqlite3_close(bereadyDB);
            
        } else {
            // status.text = @"Failed to open/create database";
        }
    } else NSLog(@"Don't Know why this didn't work this time");
  //  [filemgr release];
    NSLog(@"here 14");

    
    int dataCheck = [self checkData];
    
    if (dataCheck == 0) {

        NSFileManager *queryFileManger = [NSFileManager defaultManager];
        
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
                sql_stmt = "INSERT INTO CHECKLIST (NAME, DESCRIPTION, CHECKED) VALUES ('First AID kit', '', '0')";
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
                
                // Person Info
                
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Name', '', 1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Age', '', 1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Primary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Secondary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Email', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Address', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'City', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'State', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Zip', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Physician Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Physician Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Medications', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (1, 'Notes', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Age', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Relationship', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Primary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Secondary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Email', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Address', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'City', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'State', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Zip', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Physician Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Physician Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Medications', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (2, 'Notes', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (3, 'Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (3, 'Type of Animal', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (3, 'Breed', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (3, 'Veternarian Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (3, 'Veternarian Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (3, 'Medicates', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (3, 'Vaccinations', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (3, 'Notes', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Age', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Relationship', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Primary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Secondary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Email', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Address', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'City', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'State', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Zip', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Physician Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (4, 'Physician Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, '*Employee Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, '*Company Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, 'Primary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, 'Secondary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, 'Email', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, 'Address', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, 'City', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, 'State', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, 'Zip', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (5, 'Notes', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, '*Student Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, '*School Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, 'Primary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, 'Secondary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, 'Email', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, 'Address', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, 'City', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, 'State', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, 'Zip', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (6, 'Notes', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, '*Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, 'Primary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, 'Secondary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, 'Email', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, 'Address', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, 'City', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, 'State', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, 'Zip', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (7, 'Notes', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, '*Name', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, 'Primary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, 'Secondary Phone', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, 'Email', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, 'Address', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, 'City', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, 'State', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, 'Zip', '',1);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                sql_stmt = "insert into fields (group_key, field_name, default_value, field_type) values (8, 'Notes', '',2);";
                if (sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) NSLog( @"Failed to create table");
                
                
                
            }        
       //     sqlite3_finalize(statement);
            
            sqlite3_close(bereadyDB);
        } 
    //    [queryFileManger release];
        
    }
    
    //NSLog(@"return count %d", count);
    
    // return count;
    
    return 0;
}



@end
