//
//  TextBoxViewController.h
//  readystclair
//
//  Created by james whetsell on 3/24/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextBoxViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *fieldTitle;
@property (retain, nonatomic) IBOutlet UITextView *fieldValue;
@property (nonatomic) int row;
- (IBAction)closeWindow:(id)sender;

@end
