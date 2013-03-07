//
//  ShowListViewController.m
//  bandRides
//
//  Created by Marc Kluver on 3/6/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import "ShowListViewController.h"
#import "AFNetworking.h"
#import "ShowData.h"
#import "AllShowsDataSource.h"
#import "BaseShowsDataSource.h"

@interface ShowListViewController ()

@end

@implementation ShowListViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        self.dataSource = nil;
    }
    return self;
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (self.dataSource==nil){
        self.dataSource = [AllShowsDataSource new];
    }
    self.dataSource.vc = self;
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
