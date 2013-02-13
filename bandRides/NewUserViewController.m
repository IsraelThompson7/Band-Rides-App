//
//  NewUserViewController.m
//  bandRides
//
//  Created by DJ on 2/12/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import "NewUserViewController.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
}

@end
