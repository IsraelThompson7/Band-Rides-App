//
//  BaseShowsDataSource.m
//  bandRides
//
//  Created by Kevin Strong on 3/6/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "BaseShowsDataSource.h"
#import "ShowData.h"

@implementation BaseShowsDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sup");
    [self.vc performSegueWithIdentifier:@"viewRidesList" sender:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.showsArray == nil) return 0;
    
    return [self.showsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"showCell"];
    
    ShowData *show = [self.showsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = show.bandName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", show.Location_Address, show.Location_City];
    // cell.tag = (NSInteger)show.bandScheduleID;
    
    return cell;
}

@end
