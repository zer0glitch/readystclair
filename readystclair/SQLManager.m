//
//  SQLManager.m
//  readystclair
//
//  Created by james whetsell on 4/2/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import "SQLManager.h"
#include "DataElement.h"
#import "PIHeaderDisplayData.h"

@implementation SQLManager

@synthesize dataList;


-(int) getNextDataKey {
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
            
    NSLog(@"loading data");
	// Get the data from the database
    sqlite3_stmt    *statement;
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSFileManager *queryFileManger = [NSFileManager defaultManager];
    int returnVal = 1;

    
    if ([queryFileManger fileExistsAtPath: databasePath ] == YES) {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            
            NSString *querySQL = [NSString stringWithFormat: @"select max(data_key) as data_key from pidata"];
            
            NSLog(@"executing %@", querySQL);
            
            //@"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
            
            
            const char *query_stmt = [querySQL UTF8String];
            int queryReturn = sqlite3_prepare_v2(bereadyDB, query_stmt, -1, &statement, NULL);
            
            if (queryReturn == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
        
                    returnVal =  sqlite3_column_int(statement, 0) + 1;

                }
                sqlite3_finalize(statement);
            } else NSLog(@"Read failed %d", queryReturn);
        } else NSLog(@"Couldn't open the database");
        sqlite3_close(bereadyDB);
    } else NSLog(@"file path didn't exist");
    
    
    
 //   [queryFileManger release];
        
    return returnVal;
}
-(NSMutableArray *) getNamesForGroup:(int)groupKey {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
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
            
            NSString *querySQL = [NSString stringWithFormat: @"select  group_key, field_name, value, data_key  from pidata where group_key=%d and headerField=1 order by data_key",groupKey];
            
            NSLog(@"executing %@", querySQL);
            
            //@"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
            
            const char *query_stmt = [querySQL UTF8String];
            //char *errMsg;
            int queryReturn = sqlite3_prepare_v2(bereadyDB, query_stmt, -1, &statement, NULL);
            
            //int dataKey = [self getNextDataKey];
            
           // NSLog(@"Execute update Return %s", errMsg);

            
            if (queryReturn == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                       
                    PIHeaderDisplayData *dataElement = [[PIHeaderDisplayData alloc] init];
                    
                    dataElement.groupKey = sqlite3_column_int(statement, 0);
                    dataElement.fieldName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    dataElement.value = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    dataElement.dataKey = sqlite3_column_int(statement, 3);
                    
                    NSLog(@"Name %@, value %@", dataElement.fieldName, dataElement.value);
                    
                    [dataSet addObject:dataElement];
                    
                }
                sqlite3_finalize(statement);
            } else NSLog(@"Read failed %d", queryReturn);
        } else NSLog(@"Couldn't open the database");
        sqlite3_close(bereadyDB);
    } else NSLog(@"file path didn't exist");
    
    
    
    [queryFileManger release];
    
    [dataList addObject:dataSet];
    
    return dataSet;
}
-(NSMutableArray *) getDataDetails:(int)dataKey {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
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
            
            
            // TODO: Fix this
            NSString *querySQL = [NSString stringWithFormat: @"select id, group_key, field_name, value, field_type from pidata where data_key=%d order by id;", dataKey];
            
            NSLog(@"executing %@", querySQL);
            
            //@"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
            
            const char *query_stmt = [querySQL UTF8String];
            int queryReturn = sqlite3_prepare_v2(bereadyDB, query_stmt, -1, &statement, NULL);
            
           // int dataKey = [self getNextDataKey];
            
            if (queryReturn == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    
                    DataElement *dataElement = [[DataElement alloc] init];
                    
                    dataElement.oid = sqlite3_column_int(statement, 0);
                    dataElement.groupKey = sqlite3_column_int(statement, 1);
                    dataElement.fieldName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    dataElement.value = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    dataElement.fieldType = sqlite3_column_int(statement, 4);
                    dataElement.dataKey = dataKey; 
                    
                    //   NSLog(@"Name %@, value %@", dataElement.fieldName, dataElement.value);
                    
                    [dataSet addObject:dataElement];
                    
                }
                sqlite3_finalize(statement);
            } else NSLog(@"Read failed %d", queryReturn);
        } else NSLog(@"Couldn't open the database");
        sqlite3_close(bereadyDB);
    } else NSLog(@"file path didn't exist");
    
    
    
    [queryFileManger release];
    
    [dataList addObject:dataSet];
    
    return dataSet;
}
-(NSMutableArray *) getFields:(NSInteger *)groupKey {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
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
            
            NSString *querySQL = [NSString stringWithFormat: @"select id, group_key, field_name, default_value, field_type from fields where group_key=%d order by id;",groupKey];
            
           NSLog(@"executing %@", querySQL);
            
            //@"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
            
            const char *query_stmt = [querySQL UTF8String];
            int queryReturn = sqlite3_prepare_v2(bereadyDB, query_stmt, -1, &statement, NULL);
            
            int dataKey = [self getNextDataKey];
            
            if (queryReturn == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {

                    
                    DataElement *dataElement = [[DataElement alloc] init];
                    
                    dataElement.oid = sqlite3_column_int(statement, 0);
                    dataElement.groupKey = sqlite3_column_int(statement, 1);
                    dataElement.fieldName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    dataElement.value = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    dataElement.fieldType = sqlite3_column_int(statement, 4);
                    dataElement.dataKey = dataKey; 
                    
                 //   NSLog(@"Name %@, value %@", dataElement.fieldName, dataElement.value);
                    
                    [dataSet addObject:dataElement];

                }
                sqlite3_finalize(statement);
            } else NSLog(@"Read failed %d", queryReturn);
        } else NSLog(@"Couldn't open the database");
        sqlite3_close(bereadyDB);
    } else NSLog(@"file path didn't exist");
    
    
    
 //   [queryFileManger release];
    
    [dataList addObject:dataSet];
    
    return dataSet;

}

-(int) saveData:(NSMutableArray *)data {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
//    NSMutableArray *dataSet;                        //simply defines a mutable Array
    
//    if (dataSet == nil) {
//        dataSet = [[NSMutableArray alloc] init];
//    }  else {
//        [dataSet removeAllObjects];
//    }
//    
    NSLog(@"loading data");
	// Get the data from the database
  //  sqlite3_stmt    *statement;
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSFileManager *queryFileManger = [NSFileManager defaultManager];
    
    int updateReturn= -1;
    int firstTime = 1;
    char *errMsg;

    
   // NSMutableArray *deData = [data objectAtIndex:0];

    if ([queryFileManger fileExistsAtPath: databasePath ] == YES) {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            
            int i = 1;
            for (DataElement *de in data) {
                
                if (firstTime == 1) {
                    NSString *udpateString = [NSString stringWithFormat: @"delete from PIDATA where data_key=%d", de.dataKey];
                 //   NSLog(@"executing %@", udpateString);

                    const char *sql_stmt = [udpateString UTF8String];
                    updateReturn = sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg);
                    firstTime = -1;
                }
                
                NSString *udpateString = [NSString stringWithFormat: @"insert into PIDATA (group_key,data_key,field_name,value,field_type, headerField) values (%d, %d, '%@', '%@', %d, %d)", de.groupKey, de.dataKey, de.fieldName, de.value, de.fieldType,i];
                
                NSLog(@"executing %@", udpateString);
                
                //@"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
                
                const char *sql_stmt = [udpateString UTF8String];
                updateReturn = sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg);
                NSLog(@"Execute update Return %s", errMsg);
                i = 0;
            }
            
        } else NSLog(@"Couldn't open the database");
        sqlite3_close(bereadyDB);
    } else NSLog(@"file path didn't exist");
    
    
    
    [queryFileManger release];

     
    return updateReturn;
    
}

-(void) deleteData:(DataElement *)data {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    //    NSMutableArray *dataSet;                        //simply defines a mutable Array
    
    //    if (dataSet == nil) {
    //        dataSet = [[NSMutableArray alloc] init];
    //    }  else {
    //        [dataSet removeAllObjects];
    //    }
    //    
    NSLog(@"loading data");
	// Get the data from the database
    //  sqlite3_stmt    *statement;
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"beready.db"]];
    
    NSFileManager *queryFileManger = [NSFileManager defaultManager];
    
    int updateReturn= -1;
    int firstTime = 1;
    char *errMsg;
    
    
    // NSMutableArray *deData = [data objectAtIndex:0];
    
    if ([queryFileManger fileExistsAtPath: databasePath ] == YES) {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bereadyDB) == SQLITE_OK) {
            

                    NSString *udpateString = [NSString stringWithFormat: @"delete from PIDATA where data_key=%d", data.dataKey];
                    NSLog(@"executing %@", udpateString);
                    
                    const char *sql_stmt = [udpateString UTF8String];
                    updateReturn = sqlite3_exec(bereadyDB, sql_stmt, NULL, NULL, &errMsg);
                    firstTime = -1;
            NSLog(@"delete item message: %@", errMsg);

            
        } else NSLog(@"Couldn't open the database");
        sqlite3_close(bereadyDB);
    } else NSLog(@"file path didn't exist");
    
    
    
    [queryFileManger release];
}



@end
