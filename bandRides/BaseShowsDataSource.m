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

    //[self.vc performSegueWithIdentifier:@"viewRidesList" sender:indexPath];
    self.path = indexPath;
    [tableView reloadData];
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
    // cell.tag = (NSInteger)show.bandScheduleID;

    
    if (self.path.row == indexPath.row) {
        
    }
    
    UILabel *BandName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 20)];
    BandName.text = show.bandName;
    
    UILabel *ShowDate = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, 20)];
    ShowDate.text = show.Date;
    [ShowDate setFont:[UIFont systemFontOfSize:12]];
    
    // To Do: Replace hard coded venue value with real data
    UILabel *ShowVenue = [ [UILabel alloc] initWithFrame:CGRectMake(200, 25, 150, 20)];
    ShowVenue.text = @"Venue";
    [ShowVenue setFont:[UIFont systemFontOfSize:12]];
    
    UILabel *LocationAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 320, 20)];
    LocationAddress.text = show.Location_Address;
    [LocationAddress setFont:[UIFont systemFontOfSize:12]];
    
    
    
    [cell addSubview:BandName];
    [cell addSubview:ShowDate];
    [cell addSubview:ShowVenue];
    
    if (self.path.row == indexPath.row) {
        [cell addSubview:LocationAddress];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.path.row == indexPath.row) {
        return 200;
    } else {
        return 50;
    }
}



@end
