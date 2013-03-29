//
//  BandListViewController.m
//  bandRides
//
//  Created by Kevin Strong on 2/20/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "BandListViewController.h"
#import "AFNetworking.h"
#import "BandDetailsViewController.h"
#import "BandData.h"


@interface BandListViewController ()

@end

@implementation BandListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bandArray = nil;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *urlString = @"http://kluver.homeunix.com:8080/~marc/bands.php?json";
    
    AFJSONRequestOperation *networkOp = [[AFJSONRequestOperation alloc]
                                         initWithRequest:[[NSURLRequest alloc] initWithURL:
                                                          [NSURL URLWithString:urlString]]];
    
    [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.bandArray = [NSMutableArray new];
        for (NSDictionary *dict in responseObject[@"results"]){
            BandData *band = [BandData new];
            band.bandID = [dict[@"bandID"] intValue];
            band.description = dict[@"description"];
            band.name = dict[@"name"];
            band.soundcloud = dict[@"soundcloud"];
            band.youTube = dict[@"YouTube"];
            band.html_contentForApp = dict[@"html_contentForApp"];
            [self.bandArray addObject:band];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [networkOp start];
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
    if (self.bandArray == nil) return 0;
    return [self.bandArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShowCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    BandData *band = self.bandArray[indexPath.row];
    cell.textLabel.text = band.name;
    cell.detailTextLabel.text = band.description;
    cell.tag = band.bandID;
    
    

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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    [self performSegueWithIdentifier:@"goToBandDetails" sender:indexPath];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToBandDetails"]) {
        BandDetailsViewController *vc = segue.destinationViewController;
        NSIndexPath *index = sender;
        vc.band = self.bandArray[index.row];
    }
}

@end
