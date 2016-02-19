//
//  LocalViewController.m
//  readystclair
//
//  Created by james whetsell on 2/25/12.
//  Copyright 2012 src. All rights reserved.
//

#import "LocalViewController.h"
#import "URLData.h"
#import "JKMLParser.h"
#import "LayerSelectViewController.h"

@implementation LocalViewController

@synthesize urlData;

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    displayLayer1 = YES;
    displayLayer2 = YES;
    displayLayer3 = YES;


	// Mapping Methods
	
	// Locate the path to the route.kml file in the application's bundle
    // and parse it with the KMLParser.
    //  NSString *path = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"kml"];
//	NSURL *url = [NSURL URLWithString:@"http://192.168.75.96:7070/peatrackerserver-0.1/jaxrs/devicelocation"];
    
	// Hospital Data
	
	//NSURL *url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/1/query?where=1%3D1%26f=kmz"];	
	//[self loadLayer:url];
	
	// 2nd set of data
    //	url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/2/query?where=1%3D1%26f=kmz"];	
    //	//[self loadLayer:url];
    //	NSArray *overlays = [kml overlays];
    //    [map addOverlays:overlays];
    //    
    //    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    //    NSArray *annotations = [kml points];
    //    [map addAnnotations:annotations];
	
    
    // This is real, going to use test data first...
    //[self loadDataSet];
    
    @try {
        [self loadDisplayLayers];
    } @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
        }
        @finally {
            // Added to show finally works as well
        }
	
}

- (void) loadDisplayLayers {
    
    [map removeAnnotations:map.annotations];
    [map removeOverlays:map.overlays];

    
    // Locate the path to the route.kml file in the application's bundle
    // and parse it with the KMLParser.
    NSURL *url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/Cad/MapServer/kml/mapImage.kmz"];
    

    NSArray *overlays = nil;
    NSArray *annotations = nil;
    kmlParser = [[JKMLParser alloc] initWithURL:url imageName:@"ems.operations.lawEnforcement.policeStation.png"];
    
    
    if (displayLayer1) {
        NSLog(@"display layer 1");
        //kmlParser = [[JKMLParser parseKMLAtURL:url imageName:@"ems.operations.lawEnforcement.policeStation.png"] retain];
        kmlParser.image = @"ems.operations.lawEnforcement.policeStation.png";
        NSLog(@"display layer 11");
        [kmlParser parseKML];
        NSLog(@"display layer 12");
        // Add all of the MKOverlay objects parsed from the KML file to the map.
         overlays = [kmlParser overlays];
        NSLog(@"display layer 13");
        [map addOverlays:overlays];
        NSLog(@"display layer 14");
        
        // Add all of the MKAnnotation objects parsed from the KML file to the map.
        NSArray *annotations = [kmlParser points];
        NSLog(@"display layer 14");
        [map addAnnotations:annotations];
        NSLog(@"display layer 15");
        //[kmlParser release];
    }
    
    url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/Cad/MapServer/kml/mapImage.kmz"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ret=%@", ret);
    
    //[url release];

    NSLog(@"display layer 16");
    
    if (displayLayer2) {

    // Set Two
        url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/5/query?where=1%3D1%26f=kmz"];
        [kmlParser setNewUrl:url imageName:@"ems.operations.emergencyMedical.hospital.png"];
        kmlParser.image = @"ems.operations.emergencyMedical.hospital.png";
        [kmlParser parseKML];
        
        
        // Add all of the MKOverlay objects parsed from the KML file to the map.
        overlays = [kmlParser overlays];
        [map addOverlays:overlays];
        
        // Add all of the MKAnnotation objects parsed from the KML file to the map.
        annotations = [kmlParser points];
        [map addAnnotations:annotations];
     //   [url release];
    }
    NSLog(@"display layer 17");
    
    if (displayLayer3) {
        // Set 3
        url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/4/query?where=1%3D1%26f=kmz"];
        [kmlParser setNewUrl:url imageName:@"ems.operations.emergency.emergencyOperationsCenter.png"];
        kmlParser.image = @"ems.operations.emergency.emergencyOperationsCenter.png";
        [kmlParser parseKML];
        
        
        // Add all of the MKOverlay objects parsed from the KML file to the map.
        overlays = [kmlParser overlays];
        [map addOverlays:overlays];
        
        // Add all of the MKAnnotation objects parsed from the KML file to the map.
        annotations = [kmlParser points];
        [map addAnnotations:annotations];
       // [url release];
    }
    
    NSLog(@"display layer 18");
    
    // end 3
    
    // Walk the list of overlays and annotations and create a MKMapRect that
    // bounds all of them and store it into flyTo.
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKOverlay> overlay in overlays) {
        if (MKMapRectIsNull(flyTo)) {
            flyTo = [overlay boundingMapRect];
        } else {
            flyTo = MKMapRectUnion(flyTo, [overlay boundingMapRect]);
        }
    }
    
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    NSLog(@"display layer 19");
    
    // Position the map so that all overlays and annotations are visible on screen.
    map.visibleMapRect = flyTo;
    NSLog(@"display layer 20");
}

- (void)loadLayer:(URLData *)data {
	
	NSURL *url = data.url;
	
	NSLog(@"url: %@", url);
	
	if (data.kml == NULL) {
	} else {
		NSLog(@"don't reload");
		return;
	}
    
    [[JKMLParser parseKMLAtURL:url imageName:data.imageName] retain];
	//kmlParser.image = data.imageName;
	
//	kmlParser = [[JKMLParser alloc] initWithURL:url];
//    kmlParser.image = data.imageName;
//    [kmlParser parseKML];
 
    // Add all of the MKOverlay objects parsed from the KML file to the map.
	NSLog(@"number of overlays %d points %d", [[kmlParser overlays] count], [[kmlParser points] count]);
    NSArray *overlays = [kmlParser overlays];
    [map addOverlays:overlays];
    
    // Add all of the MKAnnotation objects parsed from the KML file to the map.
    NSArray *annotations = [kmlParser points];

    [map addAnnotations:annotations];
	
	
	// Walk the list of overlays and annotations and create a MKMapRect that
    // bounds all of them and store it into flyTo.
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKOverlay> overlay in overlays) {
        if (MKMapRectIsNull(flyTo)) {
            flyTo = [overlay boundingMapRect];
        } else {
            flyTo = MKMapRectUnion(flyTo, [overlay boundingMapRect]);
        }
    }
    
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    // Position the map so that all overlays and annotations are visible on screen.
    map.visibleMapRect = flyTo;
	data.kml = kmlParser;
//    
    
	NSLog(@"loadLayer: kml annotations count %d", [data.kml.points count]);
    
}

-(void)setUrlDataArray:(NSMutableArray *) newData {
	self.urlData = newData;
}
//**  Mapping Methods

//#pragma mark MKMapViewDelegate
//
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    return [kmlParser viewForOverlay:overlay];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    
//    MKAnnotationView *annotationView = [kmlParser viewForAnnotation:annotation];
//
//    annotationView.canShowCallout = YES;
//    annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ems.operations.emergencyMedical.hospital.png"]];
//    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    [rightButton addTarget:self action:@selector(writeSomething:) forControlEvents:UIControlEventTouchUpInside];
//    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
//    annotationView.rightCalloutAccessoryView = rightButton;
//    annotationView.canShowCallout = YES;
//    annotationView.draggable = YES;
//    
//    
//    return annotationView; //[kmlParser viewForAnnotation:annotation];
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    //static NSString *AnnotationViewID = @"annotationViewID";
    
    static NSString *AnnotationViewID = @"annotationViewID";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//    
    MKAnnotationView *pointView = [kmlParser viewForAnnotation:annotation];
    
    if (annotationView == nil) {
        annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
    }
    
    annotationView.image = pointView.image;
    annotationView.canShowCallout = YES;
    annotationView.image = pointView.image;
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self action:@selector(writeSomething:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    UIImageView *sfIconView = [[UIImageView alloc] initWithImage:pointView.image];
    annotationView.leftCalloutAccessoryView = sfIconView;
   // annotationView.rightCalloutAccessoryView = rightButton;
    annotationView.canShowCallout = YES;
    annotationView.draggable = YES;

    
    
    annotationView.annotation = annotation;
    
    return annotationView;
}


//**  End Mapping Methods


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


//***  Locaiton Methods ***
- (void)locationUpdate:(CLLocation *)location {
    
    //LocationPost *post = [LocationPost alloc];
	NSLog(@"FirstViewController.locationUpdate");
    
	//[self submitData:location];
    
}	

- (void)locationError:(NSError *)error {
	NSLog(@"%@", [error description]);
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
	
	
    NSLog(@" FirewViewController.Location: %@, old %@", [newLocation description], [oldLocation description]);
}

-(void) loadDataSet {
	//urlData = [NSMutableArray init];
	URLData *data = [URLData alloc];
    
    self.urlData = [NSMutableArray new];
	
	data.url =  [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/1/query?where=1%3D1%26f=kmz"];	
    
	data.labelName = @"Hospitals";
	data.displayed = NO;//[NSNumber numberWithBool:YES];
	data.imageName = @"ems.operations.emergencyMedical.hospital.png";
	[self.urlData addObject:data];
	//[data release];
    
    
	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/2/query?where=1%3D1%26f=kmz"];
	data.labelName = @"Schools";
	data.displayed = NO;
	data.imageName = @"ems.infrastructure.education.school.png";
	[self.urlData addObject:data];
	//[data release];
//    
//		
//	data = [URLData alloc];
//	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/4/query?where=1%3D1%26f=kmz"];
//	data.labelName = @"EMS";
//	data.displayed = NO;
//	data.imageName = @"ems.operations.emergency.emergencyOperationsCenter.png";
//	[self.urlData addObject:data];
//	[data release];
//	
	data = [URLData alloc];
	data.url = [NSURL URLWithString:@"http://www.zeroglitch.org:9090/PEATrackerServer/KMZProxy?url=http://gis.stclaircounty.org/ArcGIS/rest/services/VF_Layers/MapServer/5/query?where=1%3D1%26f=kmz"];
	data.labelName = @"Police";
	data.displayed = NO;
	data.imageName = @"ems.operations.lawEnforcement.policeStation.png";
	[self.urlData addObject:data];
	//[data release];
    
    NSLog(@"url data count: %d", [self.urlData count]);

	
}

//** end location methods

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


//- (void)submitData:(CLLocation *)location{
//	
//	NSString *exeName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"deviceId"];
//	deviceId = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceId"];
//	
//	// deviceId, latitude, longitude, altitude, bearing, speed, vehicletype
//	NSString *values = [NSString stringWithFormat:@"iOS %@,%f,%f,%f,%f,%f,1", 
//						deviceId, location.coordinate.longitude, 
//						location.coordinate.latitude,[location altitude],
//						[location course], [location speed] ];
//	
//	//NSString *values = [NSString stringWithFormat:@" values %f", [location speed]];
//	
//	NSURL *url = [NSURL URLWithString:@"http://192.168.75.96:7070/peatrackerserver-0.1/jaxrs/devicelocation"];
//	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//	[request addPostValue:values forKey:@"data"];
//	
//	[request startSynchronous];
//	NSError *error = [request error];
//	
//	int responseCode = [request responseStatusCode];
//	if (responseCode <= 200 && responseCode >= 300) {
//		//NSString *response = [request responseString];
//		NSLog(@"Error trasmitting Data %@..", error);
//		//	statusLabel.text = [NSString stringWithFormat:@"Error Sending Information %s", error];
//	} else {
//		//statusLabel.text = [NSString stringWithFormat:@"Success Sending Information"];
//	}
//	
//	NSLog([request responseString]);
//}	

- (IBAction)layerViewButtonPressed:(id)sender {
    LayerSelectViewController *viewController =[[LayerSelectViewController alloc] initWithNibName:@"LayerSelectViewController" bundle:Nil];
    
    viewController.localView = self;
    
    viewController.layer1 = displayLayer1;
    viewController.layer2 = displayLayer2;
    viewController.layer3 = displayLayer3;
        
    if (viewController) [self presentModalViewController:viewController animated:YES];
   // [viewController release];
}

- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void) updateLayer:(int)layer state:(BOOL)state {
    NSLog(@"layer %d, state %d", layer, state);
    if (layer == 1) displayLayer1 = state;
    if (layer == 2) displayLayer2 = state;
    if (layer == 3) displayLayer3 = state;

    [self loadDisplayLayers];

}

@end
