//
//  BaseShowsDataSource.h
//  bandRides
//
//  Created by Kevin Strong on 3/6/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowListViewController.h"

@interface BaseShowsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *showsArray;
@property (strong, nonatomic) ShowListViewController *vc;

@end
