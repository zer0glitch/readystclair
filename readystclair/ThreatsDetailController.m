//
//  ThreatsDetailController.m
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import "ThreatsDetailController.h"

@implementation ThreatsDetailController

@synthesize file, threatData, titleText;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([file length] > 0) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:file ofType:@"html"]isDirectory:NO]]];
    } else {
        
        [self.webView loadHTMLString:threatData baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationItem.title = @"How to Prepare";
    //  [self.navigationController pushViewController:<#(UIViewController *)#> animated:<#(BOOL)#>]
    [self.navigationController pushViewController:self.navigationItem animated:NO];
    
      self.webView.delegate = self;
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    
}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

- (void)dealloc {
    [file release];
    [webView release];
    [super dealloc];
}

@end
