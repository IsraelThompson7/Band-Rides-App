//
//  ShowListViewController.m
//  bandRides
//
//  Created by Kevin Strong on 2/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "ShowListViewController.h"
#import "AFNetworking.h"
#import "ShowData.h"
#import "AllShowsDataSource.h"
#import "RidesListViewController.h"

@interface ShowListViewController ()

@end

@implementation ShowListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.dataSource = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (self.dataSource == nil) {
        self.dataSource = [AllShowsDataSource new];
    }
    self.dataSource.vc = self;
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"viewRidesList"]) {
        NSIndexPath *index = sender;
        RidesListViewController *vc = segue.destinationViewController;
        vc.show = [self.dataSource.showsArray objectAtIndex:index.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
