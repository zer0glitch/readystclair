//
//  ThreatsDetailController.h
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreatsDetailController : UIViewController <UIWebViewDelegate> {
    NSString *file;
    UIWebView *webView;
    NSString *threatData;
}

@property (nonatomic, retain) NSString * threatData;

@property (nonatomic, retain) NSString * file;
@property (nonatomic, retain) NSString * titleText;
@property (nonatomic, retain) IBOutlet UIWebView *webView;



@end
