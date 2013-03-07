//
//  BaseShowsDataSource.h
//  bandRides
//
//  Created by Marc Kluver on 3/6/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowListViewController.h"

@interface BaseShowsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *showsArray;
@property (retain, nonatomic) ShowListViewController *vc;
@end
