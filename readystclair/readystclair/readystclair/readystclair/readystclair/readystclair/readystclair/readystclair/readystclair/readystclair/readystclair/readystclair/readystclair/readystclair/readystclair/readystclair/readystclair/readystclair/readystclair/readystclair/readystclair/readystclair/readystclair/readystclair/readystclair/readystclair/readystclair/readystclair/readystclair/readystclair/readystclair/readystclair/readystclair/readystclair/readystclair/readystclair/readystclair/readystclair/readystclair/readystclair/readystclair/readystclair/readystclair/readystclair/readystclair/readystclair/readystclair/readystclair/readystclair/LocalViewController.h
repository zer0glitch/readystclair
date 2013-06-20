//
//  LocalViewController.h
//  readystclair
//
//  Created by james whetsell on 2/25/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationController.h"
#import "JKMLParser.h"
#import <MapKit/MapKit.h>
#import "URLData.h"
//#import "LayerSelectViewController.h"

@interface LocalViewController : UIViewController  {
	//LocationController *CLController;
	
	NSString *deviceId;
	
	IBOutlet MKMapView *map;
    JKMLParser *kmlParser;
	
	IBOutlet UILabel *bearingLabel;
	IBOutlet UILabel *altitudeLabel;
	
	NSMutableArray *urlData;
    
    NSString *image;
    
    BOOL displayLayer1;
    BOOL displayLayer2;
    BOOL displayLayer3;

    
   // LayerSelectViewController *viewController;

}

//@property (nonatomic, retain) LocationController *CLController;
@property (nonatomic, retain) NSMutableArray *urlData;
//@property (nonatomic, retain) LayerSelectViewController *viewController;

//@property (nonatomic, retain) MKMapView *map;

//-(void) setLabel:(NSString*)aString;
//-(void) loadLayer: (URLData *)data;
-(void) setUrlDataArray:(NSMutableArray *)newData;
-(void) updateLayer:(int)layer state:(BOOL)state;
-(void) loadDisplayLayers;
-(void)loadLayer:(URLData *)data;
-(void) loadDataSet;

- (IBAction)layerViewButtonPressed:(id)sender;
- (IBAction)closeWindow:(id)sender;

@end
