//
//  PIDetailController.m
//  readystclair
//
//  Created by james whetsell on 2/22/12.
//  Copyright 2012 src. All rights reserved.
//

#import "PIDetailController.h"
#import "PITableViewCell.h"
#import "DataElement.h"
#import "TextBoxViewController.h"
#import "SQLManager.h"

@implementation PIDetailController
@synthesize saveButton;
@synthesize tableViewOutlet;
@synthesize headers, fields, _textField, fieldHeaders;

int currentRow = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
   // tableView = [[UITableView init] alloc];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    

    NSLog(@"View Loaded");
}

- (void)viewDidUnload {


  //  [self setTableViewOutlet:nil];
    [self setSaveButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   // [tableView reloadData];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [fields count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"Header %@", [headers objectAtIndex:section]);
    return [headers objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataElement *de = [fields objectAtIndex: indexPath.row];
    
    if (de.fieldType == 1) return 60 ;
    else return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    PITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
        cell = [[[PITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
        
        DataElement *de = [fields objectAtIndex: indexPath.row];
        
        if (de.fieldType == 1) [cell setSelectionStyle:UITableViewCellAccessoryNone];
        else [cell setSelectionStyle:UITableViewCellStateDefaultMask];
        
	} 
    
    DataElement *data = [fields objectAtIndex:indexPath.row];
   
    CGRect bound2 = [cell.contentView bounds];
    bound2.origin.y = bound2.origin.y - 5;
    CGRect rect2 = CGRectInset(bound2, 10.0, 10.0);
    rect2.size.width=220;
    rect2.size.height=20;

    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = rect2;
    label.text = data.fieldName;
    [cell.contentView addSubview:label];

    if (data.fieldType == 1) {
        CGRect bounds = [cell.contentView bounds];
        bounds.origin.y = bounds.origin.y + 20;
        CGRect rect = CGRectInset(bounds, 10.0, 10.0);
        NSString *tag = @"13234"; //[NSString stringWithFormat:@"%d%d%d",DCallSection+1,indexPath.row+1,3];
        int _tag = indexPath.row; [tag intValue];
        UITextField *txt = [self setTextField:rect setTag:_tag];
        // txt.text = @"other"; //[mutdict objectForKey:@"tollfree"];
        if (data.fieldName == data.value) txt.placeholder= data.fieldName;
        else txt.text = data.value; // [fields objectAtIndex:indexPath.row + indexPath.section];
        txt.returnKeyType = UIReturnKeyDone;
        [cell.contentView addSubview:txt];
        
    } else {
        CGRect bound3 = [cell.contentView bounds];
        bound3.origin.y = bound3.origin.y + 20;
        CGRect rect3 = CGRectInset(bound3, 10.0, 10.0);
        rect3.size.width=220;
        rect3.size.height=20;
        
        
        UILabel *label2 = [[[UILabel alloc] init] autorelease];
        label2.frame = rect3;
        label2.text = data.value;
        [cell.contentView addSubview:label2];
        
    }

    return cell;
}

-(UITextField*)setTextField:(CGRect)rect setTag:(int)_tag{
	UITextField *txtcell = [[[UITextField alloc] init]autorelease];
	rect.size.width=220;
    rect.size.height=20;
	txtcell.frame = rect;
	txtcell.tag = _tag;
    NSLog(@"tag == %d", _tag);
  //  txtcell.enabled = FALSE;
   // [txtcell setEnabled:YES];
	[txtcell setReturnKeyType:UIReturnKeyDone];
	[txtcell setDelegate:self];
	[txtcell setBackgroundColor:[UIColor whiteColor]];
	[txtcell setOpaque:YES];	
	return txtcell;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSLog(@"text: %@", text);
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    DataElement *de = [fields objectAtIndex: indexPath.row];
    
    if (de.fieldType == 2) return UITableViewCellAccessoryDetailDisclosureButton ;
    else return UITableViewCellAccessoryNone;
    //return UITableViewCellAccessoryDisclosureIndicator;
}

- (void) tableView: (UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *) indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   NSLog(@"select: %d", indexPath.row);
    
    DataElement *de = [fields objectAtIndex: indexPath.row];
    
    if (de == Nil) NSLog(@"it's nil");  
    
    @try {
        NSLog(@"select: %d", de.groupKey);
    } @catch (NSException *e) {
        NSLog(@"select: %@", e);
    }


    if (!viewController) viewController = [[TextBoxViewController alloc] initWithNibName:@"TextBoxViewController" bundle:Nil];
    
    
    if (viewController) [self presentModalViewController:viewController animated:YES];
    viewController.fieldTitle.text = de.fieldName;
    viewController.fieldValue.text = de.value;
    viewController.row = indexPath.row;
    
  //  [de release];
//    
//    NSLog(@"row %d", indexPath.row);
}

-(void)textFieldDidBeginEditing:(UITextField *)sender {
   // NSLog(@"text field editing begins here");
    
    _textField = sender;

   // if ([sender isEqual:_textField]) {
        NSLog(@"text field editing should begins here %d ", sender.tag);
        //move the main view, so that the keyboard does not hide it.
        NSLog(@"orgin y %f", self.view.frame.origin.y);
        if  (self.view.frame.origin.y >= 0) {
            currentRow = sender.tag;
            [self setViewMovedUp:YES];
        }
   // }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    DataElement *de = [fields objectAtIndex:textField.tag];
    
    de.value = textField.text; 
    NSLog(@"update the value text feild %d value %@", textField.tag, textField.text);
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  //  if ([textField.t isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textField resignFirstResponder];
       [self setViewMovedUp:NO];

        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
//    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    float moveAmount = currentRow * 80.0; 
    
    if (moveAmount > 450) moveAmount = 450;
    
    CGRect rect = self.view.frame;
    if (movedUp) {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= moveAmount;
        rect.size.height += moveAmount;
        
    } else {
        // revert back to the normal state.
        rect.origin.y += moveAmount;
        rect.size.height -=  moveAmount;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    
    if ([_textField isFirstResponder] && self.view.frame.origin.y >= 0) {
       [self setViewMovedUp:YES];
    } else if (![_textField isFirstResponder] && self.view.frame.origin.y < 0) {
      //  [self setViewMovedUp:NO];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                          name:UIKeyboardWillShowNotification object:self.view.window]; 
    
    if (viewController) { 
        NSLog(@"the view controller is real %d", viewController.row);
        DataElement *de = [fields objectAtIndex:viewController.row];
        
        de.value = (NSString *)viewController.fieldValue.text;
   
        [self.tableViewOutlet reloadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}

- (IBAction)closeDataWindow:(id)sender {
    NSLog(@"HERE HER EHERE");
    [viewController dismissModalViewControllerAnimated:YES];

}

- (IBAction)closeWindow:(id)sender {
    [self dismissModalViewControllerAnimated:YES];

}

- (IBAction)saveData:(id)sender {

    if (_textField.text != nil) [self textFieldDidEndEditing:_textField]; 
    
    SQLManager *sqlManager = [[SQLManager alloc] init];
    NSLog(@"Calling Save Data");
    [sqlManager saveData:fields];
    NSLog(@"After Save Data Called");
    
    [sqlManager release];
    // [sqlManager dealloc];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    
    NSLog(@"de alloc called");
   // [tableView release];
    [viewController dealloc];

   // [tableView dealloc];
    [tableViewOutlet release];
    [saveButton release];
    [super dealloc];
}


@end
