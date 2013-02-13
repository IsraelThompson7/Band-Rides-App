//
//  NewUserViewController.h
//  bandRides
//
//  Created by DJ on 2/12/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *cell;
@property (weak, nonatomic) IBOutlet UITextField *email;

- (IBAction)submit:(id)sender;

@end
