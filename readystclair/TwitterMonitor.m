//
//  TwitterMonitor.m
//  readystclair
//
//  Created by james whetsell on 2/18/13.
//  Copyright (c) 2013 src. All rights reserved.
//

#import "TwitterMonitor.h"
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Alert.h"

@implementation TwitterMonitor



@synthesize alertcount;

NSMutableString *currentElementValue;
Alert *alert;
NSString *lastPost;

@synthesize twitterString;




- (void) checkAlerts{
    

    NSString *path = [[NSBundle mainBundle] pathForResource: @"ReadyStClair" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    lastPost = [dict objectForKey: @"lastPost"];
    
    NSLog(@"lastPost... %@", lastPost);
    
    alertcount = 0;
	//NSString *exeName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"deviceId"];
    
	twitterString = [[NSMutableString alloc] init];
    twitterAlerts = [[NSMutableArray alloc] init];
	//NSString *values = [NSString stringWithFormat:@" values %f", [location speed]];
	
	NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/user_timeline.rss?screen_name=BeReadyStClair"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	//[request addPostValue:values forKey:@"data"];
	
	[request startSynchronous];
	NSError *error = [request error];
	
	int responseCode = [request responseStatusCode];
	if (responseCode <= 200 && responseCode >= 300) {
		//NSString *response = [request responseString];
		NSLog(@"Error trasmitting Data %@..", error);
		//	statusLabel.text = [NSString stringWithFormat:@"Error Sending Information %s", error];
	} else {
		//statusLabel.text = [NSString stringWithFormat:@"Success Sending Information"];
	}
	
	//NSLog(@"%@", [request responseString]);
    
    
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
    
    [twitterString setString:@""];
    
    [twitterString setString:@"<body style='width:90%; align:center; background-color:#4C4C4C;' >"];
    
    NSString *oldAlertString = [[NSString alloc] initWithString:twitterString];
    for (Alert *a in twitterAlerts) {
        NSLog(@"....1");
        
        // Wed, 13 Feb 2013 08:06:36 +0000
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, d MMM yyyy HH:mm:ss Z"];
        NSDate *alertDate = [dateFormat dateFromString:a.date];
        NSDate *lastPostDate = [dateFormat dateFromString:lastPost];
    
        NSLog(@"Alert Date: %@", alertDate);
        NSLog(@"lastPost Date: %@", lastPostDate);
        
        
        if (a.summary == nil) {
            NSLog(@"....2");
            
            [twitterString appendString:@"<Strong>No Alerts</Strong>"];
            break;
        } else {
            NSLog(@"....3");
            
           
            
            NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
            NSArray *matches = [linkDetector matchesInString:a.summary options:0 range:NSMakeRange(0, [a.summary length])];
            
            for (NSTextCheckingResult *match in matches) {
                
                if ([match resultType] == NSTextCheckingTypeLink) {
                    NSString *matchingString = match.URL.description;
                    
                    NSString *text = [a.summary stringByReplacingOccurrencesOfString:matchingString
                            withString:[NSString stringWithFormat:@"<a href='%@'>%@</a>", matchingString, matchingString]];
                    
                    a.summary = text;
                    NSLog(@"found URL: %@", text);
                    
                }
            }
            
           // [twitterString appendString:@"<strong><font color='blue'>"];
           // [twitterString appendString:a.title];
           // [twitterString appendString:@"</font></strong>"];
            //[twitterString appendString:@"<br>For"];
           // [twitterString appendString:a.area];
           // [twitterString appendString:@"<br>"];
           // [twitterString appendString:a.summary];
           // [twitterString appendString:@"<br>"];
           // [twitterString appendString:@"<hr>"];
            
            [twitterString appendString:@"<center>"];
            [twitterString appendString:@"<div style='position:relative; width:95%; -webkit-border-top-left-radius:1em; border-top-left-radius:1em; -o-border-top-left-radius:1em; -ms-border-top-left-radius:1em; -moz-border-radius-topleft:1em; -webkit-border-top-right-radius:1em; border-top-right-radius:1em; -o-border-top-right-radius:1em; -ms-border-top-right-radius:1em; -moz-border-radius-topright:1em; -webkit-border-bottom-right-radius:1em; border-bottom-right-radius:1em; -o-border-bottom-right-radius:1em; -ms-border-bottom-right-radius:1em; -moz-border-radius-bottomright:1em; -webkit-border-bottom-left-radius:1em; border-bottom-left-radius:1em; -o-border-bottom-left-radius:1em; -ms-border-bottom-left-radius:1em; -moz-border-radius-bottomleft:1em; background-color:#D3D3D3; left:-3px; top:4px; border:2px solid #808080; ' >"];
             [twitterString appendString:@"<div style='margin:5px; padding:10px; text-align:left;' >"];
             
             [twitterString appendString:a.summary];
             [twitterString appendString:@"</div>"];
             [twitterString appendString:@"</div>"];
            [twitterString appendString:@"</center>"];
            [twitterString appendString:@"<br/>"];
        }
        
    }
     [twitterString appendString:@"</body>"];
    
    NSLog(@"Got this");
    
    if (twitterString == oldAlertString) {
        alertcount = 0;
    } else {
        alertcount = 1;
    }
    
    [oldAlertString release];
}

#pragma mark NSXMLParserDelegate

#define ELTYPE(typeName) (NSOrderedSame == [elementName caseInsensitiveCompare:@#typeName])

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    //  NSString *ident = [attributeDict objectForKey:@"id"];
    
    if([elementName isEqualToString:@"item"]) {
        //Initialize the array.
        //  appDelegate.books = [[NSMutableArray alloc] init];
        // NSLog(@"Found entry");
        
        alert = [[Alert alloc] init];
        
        
    } else if([elementName isEqualToString:@"title"]) {
    }
    
    
    
    // [aBook setValue:currentElementValue forKey:elementName];
    
    
    
    //Initialize the book.
    //  aBook = [[Book alloc] init];
    
    //Extract the attribute here.
    //   aBook.bookID = [[attributeDict objectForKey:@"id"] integerValue];
    
    //   NSLog(@"Reading id value :%i", aBook.bookID);
    //  }
    
    // NSLog(@"Processing Element: %@", elementName);
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    /*
     <title>BeReadyStClair: Winter Weather Warning and Safety Tips:
     http://t.co/S80fg6bw http://t.co/7rpSIlLQ</title>
     <description>BeReadyStClair: Winter Weather Warning and Safety Tips:
     http://t.co/S80fg6bw http://t.co/7rpSIlLQ</description>
     <pubDate>Thu, 07 Feb 2013 20:57:53 +0000</pubDate>
     */
    
    if([elementName isEqualToString:@"item"]) {
        [twitterAlerts addObject:alert];
        [alert release];
    }
    
    //There is nothing to do if we encounter the Books element here.
    //If we encounter the Book element howevere, we want to add the book object to the array
    // and release the object.
    if([elementName isEqualToString:@"title"]) {
        alert.title = currentElementValue;

    } else if([elementName isEqualToString:@"pubDate"]) {
        alert.date = currentElementValue;
        

        NSString *path = [[NSBundle mainBundle] pathForResource: @"ReadyStClair" ofType: @"plist"];

        
        NSString* plistPath = nil;
        NSFileManager* manager = [NSFileManager defaultManager];
        if (path) {
            if ([manager isWritableFileAtPath:plistPath]) {
                NSMutableDictionary* infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
            
                //[infoDict setObject:[alert.date ];// @forKey:@"lastPost"];
                [infoDict setObject:alert.date forKey:@"lastPost"];
                [infoDict writeToFile:plistPath atomically:NO];
                [manager changeFileAttributes:[NSDictionary dictionaryWithObject:[NSDate date] forKey:NSFileModificationDate] atPath: [[NSBundle mainBundle] bundlePath]];
            }
        }
        
        /*
         NSDate *date = [NSDate date];
         NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
         [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
         NSString *dateString = [dateFormat stringFromDate:date];
         [dateFormat release];
         */
        
    } else if([elementName isEqualToString:@"description"]) {
        alert.summary = currentElementValue;
        
        NSLog(@"TWITTER FEED %@", alert.summary);

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

- (NSArray*)readPlist
{
    
    NSString* docFolder = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [docFolder stringByAppendingPathComponent:@"ReadyStClair.plist"];
    NSArray *ArrayFromPlist = [NSArray arrayWithContentsOfFile:path] ;
    
    if([ArrayFromPlist count]==0)
    {
        [path release];
        [ArrayFromPlist release];
        path = [[NSBundle mainBundle] pathForResource:@"ReadyStClair.plist" ];
        ArrayFromPlist = [NSArray arrayWithContentsOfFile:path] ;
    }
    
    return ArrayFromPlist;
}

-(void)writePlist:(NSArray*)_myNewArray{
    
    NSString* docFolder = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [docFolder stringByAppendingPathComponent:@"ReadyStClair.plist"];
    
    if([_myNewArray writeToFile:path atomically: YES]){
        NSLog(@"write successful");
    }    else {
        NSLog(@"WriteFailed");
    }
    
}




@end
