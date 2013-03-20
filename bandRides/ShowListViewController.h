//
//  ShowListViewController.h
//  bandRides
//
//  Created by Kevin Strong on 2/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseShowsDataSource;

@interface ShowListViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BaseShowsDataSource *dataSource;

@end
