//
//  NewUserViewController.m
//  bandRides
//
//  Created by DJ on 2/12/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import "NewUserViewController.h"
#import "AFNetworking.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"Login";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    NSString *name = self.name.text;
    NSString *cell = self.cell.text;
    NSString *email = self.email.text;
    
    NSString *urlString = [NSString stringWithFormat:@"http://kluver.homeunix.com:8080/~marc/user.php?name=%@&cell=%@&email=%@", name, cell, email];
    NSLog(@"%@", urlString);
    
    AFJSONRequestOperation *networkOp = [[AFJSONRequestOperation alloc] initWithRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]]];
    
    [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:responseObject[@"userID"] forKey:@"userID"];
        [prefs setObject:responseObject[@"key"] forKey:@"key"];
        [prefs synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    [networkOp start];
}

@end
