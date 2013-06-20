//
//  GetReady.h
//  readystclair
//
//  Created by james whetsell on 2/19/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetReady : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
    
    NSMutableArray *labels;
    NSMutableArray *values;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
- (IBAction)homeButtonPressed:(id)sender;

@end
