//
//  CheckListView.h
//  readystclair
//
//  Created by james whetsell on 2/20/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "ChecklistData.h"



@interface CheckListView : UIViewController <UITableViewDataSource, UITableViewDelegate> {

IBOutlet UITableView *myTableView;
NSMutableArray *dataList;
NSMutableArray *checkPoints;
    
    UILabel *status;
    NSString *databasePath;
    
    sqlite3 *bereadyDB;
    
    NSInteger *counter;

}

@property(nonatomic,retain) NSMutableArray *dataList;
@property(nonatomic,retain) NSMutableArray *checkPoints;


- (void) fillupDataList;
- (IBAction)closeWindow:(id)sender;
- (int) checkData;
- (int) createData;
- (void) updateState:(ChecklistData *)data;

@end
