//
//  ReportViewController.m
//  readystclair
//
//  Created by james whetsell on 3/5/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import "ReportViewController.h"
#import "AlertMonitor.h"
#import "ThreatsDetailController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

@synthesize imageView, lat, lon, activityIndicator, indicatorView, monitor, timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [reportInfo becomeFirstResponder];
    
    indicatorView.hidden = YES;

    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    [locationManager setDelegate:self];

    // Do any additional setup after loading the view from its nib.
    
    //Alerts
    monitor = [[AlertMonitor alloc] init];
    [self checkAlerts];
    timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(checkAlerts) userInfo:nil repeats:YES];
    

}

- (void)viewDidDisappear:(BOOL)animated {
    [locationManager stopUpdatingLocation];

    [super viewDidDisappear:animated];
}



- (void)viewDidUnload {
    
    [locationManager stopUpdatingLocation];

    [reportInfo release];
    reportInfo = nil;
    [imageView release];
    [cameraButton release];
    cameraButton = nil;
    [rollButton release];
    rollButton = nil;
    [activityIndicator release];
    activityIndicator = nil;
    [indicatorView release];
    indicatorView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
   // [imageView dealloc];
    
   // [reportInfo dealloc];
    [lat release];
    [lon release];
    [cameraButton release];
    [rollButton release];
    [activityIndicator release];
    [indicatorView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)hideKeyboard:(id)sender {
    imageView.hidden = YES;
    cameraButton.hidden = NO;
    rollButton.hidden = NO;
    [reportInfo resignFirstResponder];
}

- (void) useCamera {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = 
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
        newMedia = YES;
    }
}

- (void) useCameraRoll {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = 
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
        newMedia = NO;
    }
}

- (void) send {
    
    if ((reportInfo.text.length == 0) && (imageView.image == nil)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Description or Image" 
                                                        message:@"Please include a description or image." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
/*
     
     http://www.zeroglitch.org:9090/TiplineMobileServer/tip
     FormParam("description") String description,
     @FormParam("name") String name, @FormParam("email") String email,
     @FormParam("phoneNumber") String phoneNumber,
     @FormParam("tranId") String tranId,
     @FormParam("latitude") String latitude,
     @FormParam("longitude") String longitude,
     @FormParam("images") List<String> images,
     @FormParam("coord") List<String> coord,
     */
    
    // resize image
   // UIImage *small = [[UIImage imageWithCGImage:imageView.image.CGImage Scale:0.25]; // Orientation:imageView.image.imageOrientation];
    
    activityIndicator.hidden = NO;
    indicatorView.hidden = NO;

    
    UIImage *small = [UIImage imageWithCGImage:imageView.image.CGImage scale:0.01 orientation:imageView.image.imageOrientation];

    NSData *imgData = UIImageJPEGRepresentation(small, 1.0);
    
    NSString *base64 = [self base64forData:imgData];

    NSLog(@"finished encoding"); 
    
    
    // Initilize Queue
//    NSOperationQueue *networkQueue = [[NSOperationQueue alloc] init];
//   // [networkQueue setUploadProgressDelegate:statusProgressView];
//    [networkQueue setRequestDidFinishSelector:@selector(imageRequestDidFinish:)];
//    [networkQueue setQueueDidFinishSelector:@selector(imageQueueDidFinish:)];
//    [networkQueue setRequestDidFailSelector:@selector(requestDidFail:)];
//    [networkQueue setShowAccurateProgress:true];
//    [networkQueue setDelegate:self];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://emapps.stclaircounty.org:8088/TiplineMobileServer/jaxrs/tip"];
    int x = arc4random() % 1000;
    double time = [[NSDate date] timeIntervalSince1970];
    
    
    NSMutableString *tranId = [[NSMutableString alloc] initWithFormat:@"%d%f", x,time];
    
    NSString *post = [NSString stringWithFormat:@"description=%@,name=%@,phoneNumber=%@,tranId=%@,latitude=%@,longitude=%@,images=%@,base64=%@,coords=%@,%@", reportInfo.text,@"NA",@"555-555-5555", tranId, lat, lon,base64,lon,lat ];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:@"http://www.nowhere.com/sendFormHere.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    

    /*
    ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
   
    
    [request setPostValue:reportInfo.text forKey:@"description"];
    [request setPostValue:@"NA" forKey:@"name"];
    [request setPostValue:@"555-555-5555" forKey:@"phoneNumber"];
    [request setPostValue:tranId forKey:@"tranId"];
    [request setPostValue:lat forKey:@"latitude"];
    [request setPostValue:lon forKey:@"longitude"];
   // [request setPostValue:base64 forKey:@"images"];
    [request setPostValue:[NSString stringWithFormat:@"%@,%@",lon,lat] forKey:@"coords"];
     */
    
    
    /*
    
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        
        NSLog(@"response: %@", response);
    }
    
    request = [[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    [request setPostValue:reportInfo.text forKey:@"description"];
    [request setPostValue:@"NA" forKey:@"name"];
    [request setPostValue:@"555-555-5555" forKey:@"phoneNumber"];
    [request setPostValue:tranId forKey:@"tranId"];
    [request setPostValue:lat forKey:@"latitude"];
    [request setPostValue:lon forKey:@"longitude"];
    [request setPostValue:base64 forKey:@"images"];
    [request setPostValue:[NSString stringWithFormat:@"%@,%@",lon,lat] forKey:@"coords"];
    
    [request setDelegate:self];
    
   // [request startSynchronous];
    [request startAsynchronous];
      */
    
    /*
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //[activity setFrame:CGRectMake(0, 0, 20, 20)];
    [activity setFrame:CGRectMake(indicatorView.bounds.size.width / 2.0f - activity.frame.size.width /2.0f, indicatorView.bounds.size.height / 2.0f - activity.frame.size.height /2.0f, activity.frame.size.width, activity.frame.size.height)];
   
    
    //activity.center =CGPointMake(480/2.0, 320/2.0);
    [activity startAnimating];
    [indicatorView addSubview:activity];
    [activity release];
     */

}

/*

- (void)requestFinished:(ASIHTTPRequest *)request {
    // Use when fetching text data
   // NSString *responseString = [request responseString];
    
    indicatorView.hidden = YES;
    [self clearFields:self];
    
    NSLog(@"finished uploading photo");

    
   // // Use when fetching binary data
   // NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    indicatorView.hidden = YES;
    
    NSLog(@"AN ERROR: occured %@", error);


}
 */

-(IBAction)clearFields:(id)sender {
    imageView.image = nil;
    reportInfo.text = @"";
}

- (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    location = newLocation;
    
    lat = nil;
    [lat dealloc];
    lon= nil;
    [lon dealloc];
    
    lat = [[NSMutableString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
    lon = [[NSMutableString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];

    
    NSLog(@"did update location %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
//	if([self.delegate conformsToProtocol:@protocol(LocationControllerDelegate)]) {
//		[self.delegate locationUpdate:newLocation];
//	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//	if([self.delegate conformsToProtocol:@protocol(LocationControllerDelegate)]) {
//		[self.delegate locationError:error];
//	}
}

#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    [self dismissModalViewControllerAnimated:YES];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        imageView.image = image;
        
        imageView.hidden = NO;
        cameraButton.hidden = YES;
        rollButton.hidden = YES;

        
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image, 
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
        
      

    } else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
		// Code here to support video if enabled
	}
}

-(void)image:(UIImage *)image
       finishedSavingWithError:(NSError *)error 
       contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
    
	return YES;
    
}


- (IBAction)homeButtonPressed:(id)sender {
    self.tabBarController.selectedIndex= 0;
    [self.tabBarController.selectedViewController viewDidAppear:YES];
}

- (IBAction)alertButtonPressed:(id)sender {
    
    ThreatsDetailController *viewController =[[ThreatsDetailController alloc] initWithNibName:@"ThreatsDetailController" bundle:Nil];
    
    viewController.threatData = monitor.alertString;
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    // [viewController release];
}

- (void) checkAlerts{
    
    
    //NSMutableString *alertString =
    NSLog(@"checking alerts");
    [monitor checkAlerts];
    NSLog(@"alerts checked");
    
    NSLog(@"alertsString: %@", monitor.alertString);
    
    if (monitor.alertcount > 0) {
        UIImage *img = [UIImage imageNamed:@"ActiveAlert.png"];
        [alertButton setImage:img forState:UIControlStateNormal];
        // [img release];
    } else {
        UIImage *img = [UIImage imageNamed:@"NoAlert.png"];
        [alertButton setImage:img forState:UIControlStateNormal]; 
    }
    
    
}

@end
