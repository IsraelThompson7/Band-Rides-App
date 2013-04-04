//
//  RidesListViewController.h
//  bandRides
//
//  Created by Kevin Strong on 3/13/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowData.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface RidesListViewController : UITableViewController <UIAlertViewDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) ShowData *show;
@property (nonatomic, strong) NSMutableArray *ridesArray;

@end
