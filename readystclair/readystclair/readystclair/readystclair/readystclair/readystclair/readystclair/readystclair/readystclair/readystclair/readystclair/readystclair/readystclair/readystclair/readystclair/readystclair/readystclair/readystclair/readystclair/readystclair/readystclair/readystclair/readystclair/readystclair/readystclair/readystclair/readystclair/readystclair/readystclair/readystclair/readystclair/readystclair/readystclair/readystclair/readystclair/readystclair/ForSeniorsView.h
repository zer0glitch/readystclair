//
//  ForSeniorsView.h
//  readystclair
//
//  Created by james whetsell on 2/19/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForSeniorsView : UIViewController <UIWebViewDelegate> {
    UIWebView *webView;
}


@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
