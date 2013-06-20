//
//  AlertMonitor.h
//  readystclair
//
//  Created by james whetsell on 3/4/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertMonitor : NSObject <NSXMLParserDelegate> {
    
//    //XMLAppDelegate *appDelegate;
//  --  Book *aBook;
    
    NSMutableString *alertString;
    NSMutableArray *alerts;
    
    NSInteger *alertcount;

}

//- (XMLParser *) initXMLParser;

@property (nonatomic, retain) NSMutableString *alertString;
@property (nonatomic) NSInteger *alertcount;


-(void) checkAlerts;
-(void) buildAlertString;

@end
