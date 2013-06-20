//
//  TextBoxViewController.m
//  readystclair
//
//  Created by james whetsell on 3/24/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import "TextBoxViewController.h"

@interface TextBoxViewController ()

@end

@implementation TextBoxViewController
@synthesize fieldTitle;
@synthesize fieldValue, row;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    fieldTitle.text = @"TEST";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [self setFieldTitle:nil];
    [self setFieldValue:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [fieldTitle release];
    [fieldValue release];
    [super dealloc];
}
- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];

}
@end
