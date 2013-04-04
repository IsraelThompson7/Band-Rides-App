//
//  RidesListViewController.m
//  bandRides
//
//  Created by Kevin Strong on 3/13/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "RidesListViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "ShowData.h"
#import "UIAlertView+BlockAdditions.h"
#import "Ride.h"

@interface RidesListViewController ()

@end

@implementation RidesListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ridesArray = nil;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"%@", self.show);
    [self reloadData];
}

-(void)reloadData{
    NSString *urlString = [NSString stringWithFormat:@"http://kluver.homeunix.com:8080/~marc/rides.php?json&showID=%@", self.show.bandScheduleID];
    AFJSONRequestOperation *networkOp = [[AFJSONRequestOperation alloc]
                                         initWithRequest:[[NSURLRequest alloc] initWithURL:
                                                          [NSURL URLWithString:urlString]]];
    
    [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        self.ridesArray = [NSMutableArray new];
        
        for (NSDictionary *dict in responseObject[@"rides"]){
            Ride *r = [Ride new];
            r.howMany = [dict[@"howMany"] intValue];
            r.userCell = dict[@"userCell"];
            r.userEmail = dict[@"userEmail"];
            r.showAddress = dict[@"ShowAddress"];
            r.comments = dict[@"comments"];
            [self.ridesArray addObject:r];
        }
        
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [networkOp start];

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    view.backgroundColor = [UIColor grayColor];
    
    UIButton *haveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    haveButton.frame = CGRectMake(20, 20, 100, 100);
    [haveButton addTarget:self action:@selector(wantButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [haveButton setTitle:@"I want a ride" forState:UIControlStateNormal];
    [view addSubview:haveButton];
    
    UIButton *wantButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    wantButton.frame = CGRectMake(200, 20, 100, 100);
    [wantButton addTarget:self action:@selector(haveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [wantButton setTitle:@"I have a ride" forState:UIControlStateNormal];
    [view addSubview:wantButton];

    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130;
}

-(void)haveButtonPressed{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Seats Available" message:@"How many people do you have a ride for" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField *theTextField =  [alert textFieldAtIndex:0];
    theTextField.placeholder = @"Enter the number of empty seats";
    theTextField.keyboardType = UIKeyboardTypeNumberPad;    
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    int forHowMany = [[[alertView textFieldAtIndex:0] text] intValue];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://kluver.homeunix.com:8080/~marc/ride.php"]];
    
    AppDelegate *ad = [[UIApplication sharedApplication] delegate];
    NSString *postData = [NSString stringWithFormat:@"showID=%@&userID=%@&key=%@&howMany=%d",self.show.bandScheduleID,ad.userID,ad.key,forHowMany];
    [request setHTTPMethod: @"POST"];
    [request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody: [postData dataUsingEncoding: NSUTF8StringEncoding]];


    NSLog(@"%@",postData);
    
    AFHTTPRequestOperation *networkOp = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    
    [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding]);
        [self reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [networkOp start];

}

-(void)wantButtonPressed{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.ridesArray == nil) return 0;
    return [self.ridesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"rideCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Ride *ride = self.ridesArray[indexPath.row];
    cell.textLabel.text = ride.userCell;
    cell.detailTextLabel.text = ride.userEmail;

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIAlertView showAlertWithTitle: @"contact"
                            message: @"How to contact"
                  cancelButtonTitle: @"cancel"
                  otherButtonTitles: @[@"Email",@"SMS",@"Call"]
                    completionBlock: ^(UIAlertView* alert, NSUInteger buttonIndex ) {
                        if ( buttonIndex == alert.cancelButtonIndex )
                        {
                            
                        }
                        else
                        {
                            switch (buttonIndex) {
                                case 1:
                                    [self sendMail:self.ridesArray[indexPath.row]];
                                    break;
                                case 2:
                                    [self sendSMS:self.ridesArray[indexPath.row]];
                                    break;
                                case 3:
                                    [self call:self.ridesArray[indexPath.row]];
                                default:
                                    break;
                            }
                        }
                    }];    
}


-(void) sendMail:(NSDictionary*)ride {
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"I want a ride"];
    
    [controller setToRecipients:@[ride[@"userEmail"]]];
    NSString *message = [NSString stringWithFormat:@"I need a ride to %@ in %@", ride[@"ShowAddress"], ride[@"ShowCity"]];

    [controller setMessageBody:message isHTML:NO];
    if (controller) [self presentViewController:controller animated:YES completion:^{
        NSLog(@"completed");
    }];
}

-(void) sendSMS:(NSDictionary*)ride {
    MFMessageComposeViewController* controller = [[MFMessageComposeViewController alloc] init];
    controller.messageComposeDelegate = self;
    
    [controller setRecipients:@[ride[@"userCell"]]];
    NSString *message = [NSString stringWithFormat:@"I need a ride to %@ in %@", ride[@"ShowAddress"], ride[@"ShowCity"]];
    
    [controller setBody:message];
    
    if (controller) [self presentViewController:controller animated:YES completion:^{
        NSLog(@"completed");
    }];
}

-(void) call:(NSDictionary*)ride {
    NSString *telURL = [NSString stringWithFormat:@"tel:%@",ride[@"userCell"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telURL]];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Closed out the mail window");
    }];
}

@end
