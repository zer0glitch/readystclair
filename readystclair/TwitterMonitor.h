//
//  TwitterMonitor.h
//  readystclair
//
//  Created by james whetsell on 2/18/13.
//  Copyright (c) 2013 src. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterMonitor: NSObject <NSXMLParserDelegate> {
    
    //    //XMLAppDelegate *appDelegate;
    //  --  Book *aBook;
    
    NSMutableString *twitterString;
    NSMutableArray *twitterAlerts;
    
    NSInteger *alertcount;
    
}

//- (XMLParser *) initXMLParser;

@property (nonatomic, retain) NSMutableString *twitterString;
@property (nonatomic) NSInteger *alertcount;


-(void) checkAlerts;
-(void) buildAlertString;

@end