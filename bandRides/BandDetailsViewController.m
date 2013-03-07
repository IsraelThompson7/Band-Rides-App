//
//  ShowDetailsViewController.m
//  bandRides
//
//  Created by Marc Kluver on 3/6/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import "BandDetailsViewController.h"
#import "ShowListViewController.h"
#import "OneBandShowDataSource.h"

@interface BandDetailsViewController ()

@end

@implementation BandDetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Band Schedule" style:UIBarButtonItemStyleBordered
                                                              target:self action:@selector(bandScheduleClicked)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)bandScheduleClicked
{
    [self performSegueWithIdentifier:@"segueToShows" sender:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueToShows"]){
        ShowListViewController *vc = segue.destinationViewController;
        vc.dataSource = [[OneBandShowDataSource alloc] initWithBand:self.band];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
