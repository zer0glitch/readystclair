//
//  ReportViewController.h
//  readystclair
//
//  Created by james whetsell on 3/5/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <CoreLocation/CoreLocation.h>
#import "AlertMonitor.h"

//@protocol LocationControllerDelegate 
//@required
//- (void)locationUpdate:(CLLocation *)location; // Our location updates are sent here
//- (void)locationError:(NSError *)error; // Any errors are sent here
//@end


@interface ReportViewController  : UIViewController <UIImagePickerControllerDelegate,                                            UINavigationControllerDelegate, UITextFieldDelegate, CLLocationManagerDelegate> {
  
    UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextView *reportInfo;
    UIImageView *imageView;
    BOOL newMedia;
    IBOutlet UIButton *cameraButton;
    IBOutlet UIButton *rollButton;
    IBOutlet UIView *indicatorView;
    
    CLLocationManager *locationManager;
    CLLocation *location;
    
    NSMutableString *lat;
    NSMutableString *lon;
    
    //Alerts
    AlertMonitor *monitor;
    NSTimer *timer;
    IBOutlet UIButton *alertButton;
    
    
}
- (IBAction)homeButtonPressed:(id)sender;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIView *indicatorView;
@property (nonatomic, retain)  NSMutableString *lat;
@property (nonatomic, retain)  NSMutableString *lon;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)useCamera;
- (IBAction)useCameraRoll;
- (IBAction)closeWindow:(id)sender;
- (NSString*)base64forData:(NSData*)theData;
- (IBAction)send;
-(IBAction)clearFields:(id)sender;

// Alerts
- (void) checkAlerts;
@property (nonatomic, retain) AlertMonitor *monitor;
@property (nonatomic, retain) NSTimer *timer;
- (IBAction)alertButtonPressed:(id)sender;


@end
