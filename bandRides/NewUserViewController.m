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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    NSString *name    = self.name.text;
    NSString *phone   = self.phone.text;
    NSString *email   = self.email.text;
    NSString *address = self.address.text;
    NSString *city    = self.city.text;
    
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
@end
