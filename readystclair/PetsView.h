//
//  PetsView.h
//  readystclair
//
//  Created by james whetsell on 2/19/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PetsView : UIViewController {
    UIWebView *webView;
}

- (IBAction)closeWindow:(id)sender;
@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
