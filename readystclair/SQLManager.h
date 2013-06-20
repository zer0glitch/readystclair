//
//  SQLManager.h
//  readystclair
//
//  Created by james whetsell on 4/2/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "DataElement.h"


@interface SQLManager : NSObject {

NSString *databasePath;

sqlite3 *bereadyDB;

NSInteger *counter;

}

@property(nonatomic,retain) NSMutableArray *dataList;

// Retrieve next group key
-(int) getNextDataKey;
-(NSMutableArray *) getNamesForGroup:(int)groupKey;
-(NSMutableArray *) getDataDetails:(int)dataKey;
-(NSMutableArray *) getFields:(NSInteger *)groupKey;
-(void) deleteData:(DataElement *)data;
-(int) saveData:(NSMutableArray *)data;
@end
