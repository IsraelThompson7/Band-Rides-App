//
//  NewUserViewController.h
//  bandRides
//
//  Created by Kevin Strong on 2/12/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+URLEncoding.h"

@interface NewUserViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *city;

@property (weak, nonatomic) UITextField *activeField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property int punched;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)submit:(id)sender;
- (IBAction)punch:(id)sender;
@end
