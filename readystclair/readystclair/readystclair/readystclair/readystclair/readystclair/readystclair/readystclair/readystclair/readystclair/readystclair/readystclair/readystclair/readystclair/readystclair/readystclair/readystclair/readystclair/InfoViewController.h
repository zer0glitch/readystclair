//
//  InfoViewController.h
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController {
    UITableView *tableView;
    
    NSMutableArray *labels;
    NSMutableArray *values;
}

- (IBAction)closeWindow:(id)sender;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
