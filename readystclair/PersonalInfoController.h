//
//  PersonalInfoController.h
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLManager.h"

enum {
    AboutMe = 1,
    Family = 2,
    Pets = 3,
    Contacts = 4,
    employee = 5,
    student = 6,
    meetingPlaces = 7,
    outOfTown = 8
};
typedef int DisplayType;

@interface PersonalInfoController : UIViewController {
    DisplayType infoType;
    
    SQLManager *sqlManager;
}

@property (nonatomic) DisplayType infoType;
@property (nonatomic, retain) NSMutableArray *aboutMeSections;
@property (nonatomic, retain) NSMutableArray *headerFields;
@property (nonatomic, retain) NSMutableArray *fields;
@property (nonatomic, retain) NSMutableArray *sections;


@property (retain, nonatomic) IBOutlet UITableView *tableViewOutlet;

- (IBAction)addPersonalInfoButtonPressed:(id)sender;
- (IBAction)closeWindow:(id)sender;
- (void) loadAboutMeData:(int)groupKey;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)editButtonPressed:(id)sender;

- (void) loadHeaderField:(int)groupKey;

@end
