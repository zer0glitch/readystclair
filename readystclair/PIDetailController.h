//
//  PIDetailController.h
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextBoxViewController.h"

#define kOFFSET_FOR_KEYBOARD 1.0;

@interface PIDetailController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate> {
    NSMutableArray *headers;
    NSMutableArray *fields;
    NSMutableArray *fieldHeaders;
    UITextField *_textField;
    TextBoxViewController *viewController;
}
@property (retain, nonatomic) IBOutlet UITableView *tableViewOutlet;

@property (retain, nonatomic) NSMutableArray *headers;
@property (retain, nonatomic) NSMutableArray *fields;
@property (retain, nonatomic) NSMutableArray *fieldHeaders;
@property (retain, nonatomic) UITextField *_textField;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (IBAction)closeWindow:(id)sender;
- (IBAction)closeDataWindow:(id)sender;

-(UITextField*)setTextField:(CGRect)rect setTag:(int)_tag;
-(void)setViewMovedUp:(BOOL)movedUp;
//- (void) loadAboutMeData;
- (IBAction)saveData:(id)sender;

@end
