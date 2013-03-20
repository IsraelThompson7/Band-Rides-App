//
//  RidesListViewController.h
//  bandRides
//
//  Created by Kevin Strong on 3/13/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowData.h"

@interface RidesListViewController : UITableViewController

@property (nonatomic, strong) ShowData *show;
@property (nonatomic, strong) NSArray *ridesArray;

@end
