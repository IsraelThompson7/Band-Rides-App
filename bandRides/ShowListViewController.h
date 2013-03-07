//
//  ShowListViewController.h
//  bandRides
//
//  Created by Marc Kluver on 3/6/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseShowsDataSource;

@interface ShowListViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) BaseShowsDataSource *dataSource;


@end
