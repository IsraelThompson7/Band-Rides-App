//
//  ShowDetailsViewController.m
//  bandRides
//
//  Created by Marc Kluver on 3/6/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import "BandDetailsViewController.h"

@interface BandDetailsViewController ()

@end

@implementation BandDetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Band Schedule" style:UIBarButtonItemStyleBordered target:self action:@selector(bandScheduleClicked)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)bandScheduleClicked
{
    NSLog(@"aww yiss");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
