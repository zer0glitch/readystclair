//
//  CheckListTableViewController.h
//
//  Created by Sascha Marc Paulus on 01.10.10.
//  Copyright 2010 paulusWebMedia. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CheckListTableViewController : UITableViewController {
	
	NSMutableArray *dataList;
	NSMutableArray *checkPoints;
    
}

@property(nonatomic,retain) NSMutableArray *dataList;
@property(nonatomic,retain) NSMutableArray *checkPoints;


- (void) fillupDataList;

@end
