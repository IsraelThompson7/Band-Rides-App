//
//  NewUserViewController.m
//  bandRides
//
//  Created by Kevin Strong on 2/12/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "NewUserViewController.h"
#import "AFNetworking.h"


@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.punched = 0;
    }
    return self;
}

- (void)shame {
    //UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"OH SNAP" message:@"IN YO FACE!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[msg show];
    
    self.punched++;
    NSString *pwned = [NSString stringWithFormat:@"%d punches delivered to surens face!", self.punched];
    
    UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"OH SNAP" message:pwned delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [msg show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = nil;
    self.punched = 0;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.scrollView addGestureRecognizer:tap];
    tap.delegate = self;
    
    [self registerForKeyboardNotifications];
    
    //I added this button to disable the back button unless they have already registered
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:@"userID"] == nil || [prefs objectForKey:@"key"] == nil) {
        //Disable the navigation back button
        self.navigationItem.hidesBackButton = YES;
    }
    
    self.addressAutocomplete.backgroundColor = [UIColor grayColor];
}

//This one is called when the screen rotates or when the view first loads
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight
        || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        //Landscape layout
    } else {
        //Portrait layout
    }
}

//This one is called when the screen rotates
-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];

}


-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard control, scroll so it's visible
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y - kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

-(void)textFieldDidBeginEditing:(UITextField*)textField
{
    self.activeField = textField;
    if (textField != self.address){
        self.addressAutocomplete.hidden = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField*)textField
{
    self.activeField = nil;
    if (textField == self.address){
        self.addressAutocomplete.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    NSString *name    = [self.name.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *phone   = [self.phone.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *email   = [self.email.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *address = [self.address.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *city    = [self.city.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlString = [NSString stringWithFormat:@"http://kluver.homeunix.com:8080/~marc/user.php?name=%@&cell=%@&email=%@&address=%@&city=%@", name, phone, email, address, city];
    NSLog(@"%@", urlString);
    
    AFJSONRequestOperation *networkOp = [[AFJSONRequestOperation alloc]
                                         initWithRequest:[[NSURLRequest alloc] initWithURL:
                                                          [NSURL URLWithString:urlString]]];
    
    [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:responseObject[@"userID"] forKey:@"userID"];
        [prefs setObject:responseObject[@"key"] forKey:@"key"];
        [prefs synchronize];
        
        [self.submitButton setEnabled:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [networkOp start];
    
    [self.submitButton setEnabled:NO];
}

- (IBAction)punch:(id)sender {
    [self shame];
}

- (IBAction)editAddressChanged:(UITextField*)sender forEvent:(UIEvent *)event {
    NSLog(@"%@",sender.text);
    NSString *geocodeURL = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",sender.text];
    
    AFJSONRequestOperation *networkOp = [[AFJSONRequestOperation alloc]
                                         initWithRequest:[[NSURLRequest alloc] initWithURL:
                                                          [NSURL URLWithString:geocodeURL]]];
    
    [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //JSONArray results = jsonResponse.getJSONArray("results");
        self.autocompleteData = [NSMutableArray new];
        NSArray *results = responseObject[@"results"];
        for (NSDictionary *d in results){
            [self.autocompleteData addObject:d[@"formatted_address"]];
        }
        self.addressAutocomplete.hidden = NO;
        [self.addressAutocomplete reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        
        
    }];
    
    [networkOp start];

    
}

-(void)dismissKeyboard
{
    [self.activeField resignFirstResponder];
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.autocompleteData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressCell"];
    cell.textLabel.text = self.autocompleteData[indexPath.row];
    cell.textLabel.backgroundColor = [UIColor grayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *a = self.autocompleteData[indexPath.row];
    self.address.text = a;
    self.addressAutocomplete.hidden=YES;
}

//What I found was that the tap gesture recognizer broke the table view's didSelectRowAtIndexPath
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.addressAutocomplete]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}
@end
