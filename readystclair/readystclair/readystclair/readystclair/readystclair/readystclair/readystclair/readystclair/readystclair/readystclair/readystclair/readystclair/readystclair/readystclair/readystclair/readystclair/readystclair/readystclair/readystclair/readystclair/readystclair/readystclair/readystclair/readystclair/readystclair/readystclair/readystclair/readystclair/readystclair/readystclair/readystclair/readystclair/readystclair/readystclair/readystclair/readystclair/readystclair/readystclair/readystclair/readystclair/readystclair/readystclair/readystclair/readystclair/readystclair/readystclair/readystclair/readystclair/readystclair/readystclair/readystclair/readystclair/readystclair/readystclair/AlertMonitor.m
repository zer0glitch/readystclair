//
//  AlertMonitor.m
//  readystclair
//
//  Created by james whetsell on 3/4/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import "AlertMonitor.h"

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation AlertMonitor


- (NSString *) checkAlerts{
	//NSString *exeName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"deviceId"];

	
	//NSString *values = [NSString stringWithFormat:@" values %f", [location speed]];
	
	NSURL *url = [NSURL URLWithString:@"http://alerts.weather.gov/cap/mi.php?x=0"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
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
	
	NSLog(@"%@", [request responseString]);
    
    return [request responseString];
}

@end
