//
//  AlertMonitor.m
//  readystclair
//
//  Created by james whetsell on 3/4/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import "AlertMonitor.h"


#import "Alert.h"

@implementation AlertMonitor

@synthesize alertcount;

NSMutableString *currentElementValue;
Alert *alert;

@synthesize alertString;

- (void) checkAlerts{
    
    alertcount = 0;
	//NSString *exeName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"deviceId"];

	alertString = [[NSMutableString alloc] init];
    alerts = [[NSMutableArray alloc] init];
	//NSString *values = [NSString stringWithFormat:@" values %f", [location speed]];
	
	NSURL *url = [NSURL URLWithString:@"http://alerts.weather.gov/cap/mi.php?x=0"];

    
    NSXMLParser *xml = [[NSXMLParser alloc] initWithContentsOfURL:url];
   // JKMLParser *parser = [[JKMLParser alloc] init];
    [xml setDelegate:self];
    [xml parse];
    
    [self buildAlertString];
    //return [parser autorelease];
    
  //  [alertString appendString:@"test"];
   // return alertString;
}

-(void) buildAlertString {
    for (Alert *a in alerts) {
       // NSLog(@"....1");
        if ((a.title == nil) || (a.area == nil) || (a.summary == nil)) {
         //   NSLog(@"....2");

            [alertString appendString:@"<Strong>No Alerts</Strong>"];
            break;
        } else {
           // NSLog(@"....3");
            
            
        
            NSRange lapeer = [alert.countyCode rangeOfString:@"MIZ062"];
            NSRange macomb = [alert.countyCode rangeOfString:@"MIZ070"];
            NSRange stClair = [alert.countyCode rangeOfString:@"MIZ063"];
            NSRange sanilac = [alert.countyCode rangeOfString:@"MIZ055"];

        
            if (lapeer.location > -1 || macomb.location > -1 || stClair.location > -1 || sanilac.location > -1) {
                alertcount = alertcount + 1;
                [alertString appendString:@"<strong><font color='blue'>"];
                [alertString appendString:a.title];
                [alertString appendString:@"</font></strong>"];
                [alertString appendString:@"<br>For"];
                [alertString appendString:a.area];
                [alertString appendString:@"<br>"];
                [alertString appendString:a.summary];
                [alertString appendString:@"<br>"];
                [alertString appendString:@"<hr>"];
            }
        }

    }
    
   // NSLog(@"Got this");
    
}

#pragma mark NSXMLParserDelegate

#define ELTYPE(typeName) (NSOrderedSame == [elementName caseInsensitiveCompare:@#typeName])

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
  //  NSString *ident = [attributeDict objectForKey:@"id"];
    
    if([elementName isEqualToString:@"entry"]) {

        alert = [[Alert alloc] init];
        
        
    } else if([elementName isEqualToString:@"title"]) {
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
                                     namespaceURI:(NSString *)namespaceURI
                                     qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"entry"]) {
        
       
        [alerts addObject:alert];
        [alert release];
    }
    
    //There is nothing to do if we encounter the Books element here.
    //If we encounter the Book element howevere, we want to add the book object to the array
    // and release the object.
    if([elementName isEqualToString:@"title"]) {
        alert.title = currentElementValue;

//        [alertString appendString:@"<strong>"];
//        [alertString appendString:currentElementValue];
//        [alertString appendString:@"</strong><br>"];

    } else if([elementName isEqualToString:@"cap:areaDesc"]) { 
        alert.area = currentElementValue;
    } else if([elementName isEqualToString:@"cap:effictive"]) {  
//        [alertString appendString:@"<strong>Effective Date</strong>:"];
//        [alertString appendString:currentElementValue];
//        [alertString appendString:@"</strong><br>"];

    
    } else if([elementName isEqualToString:@"value"]) {
        NSLog(@"count code %@", currentElementValue);
        alert.countyCode = currentElementValue;

    } else if([elementName isEqualToString:@"summary"]) {  
        alert.summary = currentElementValue;
//        [alertString appendString:currentElementValue];
//        [alertString appendString:@"<br>"];
/*
 <summary>...LAKE EFFECT SNOW SHOWERS TO BRING ADDITIONAL SNOW ACCUMULATIONS OVERNIGHT... .OCCASIONAL SNOW SHOWERS ACROSS SOUTHWEST LOWER MICHIGAN SHOULD TEND TO WEAKEN TOWARD MIDNIGHT AS AN UPPER LEVEL DISTURBANCE TRACKS THROUGH THE AREA. HOWEVER...LAKE EFFECT SNOW SHOWERS WILL DEVELOP OVERNIGHT AND AFFECT BERRIEN AND POSSIBLY INTO FAR WESTERN</summary>
 <cap:event>Winter Weather Advisory</cap:event>
 <cap:effective>2012-03-04T22:06:00-05:00</cap:effective>
 <cap:expires>2012-03-05T06:15:00-05:00</cap:expires>
 */


//        [appDelegate.books addObject:aBook];
//        
//        [aBook release];
//        aBook = nil;
    } else {
       // NSLog(@"%@", elementName);
    }
    
    [currentElementValue release];
    currentElementValue = nil;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if(!currentElementValue) currentElementValue = [[NSMutableString alloc] initWithString:string];
    else {
        [currentElementValue appendString:string];
      //  NSLog(@"Processing Value: %@", currentElementValue);
    }
    
  //  NSLog(@"Processing Value: %@", currentElementValue);
    
}


@end
