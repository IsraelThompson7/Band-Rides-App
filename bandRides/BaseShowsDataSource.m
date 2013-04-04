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


    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
        //Landscape only code
        [cell addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"first.png"]]];//Added this image as a demo Hiram please replace with soemthing meaningful
        
        UILabel *BandName = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 320, 20)];
        BandName.text = show.bandName;
        
        UILabel *ShowVenue = [ [UILabel alloc] initWithFrame:CGRectMake(15, 30, 200, 20)];
        ShowVenue.text = show.venueName;
        [ShowVenue setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *ShowDate = [[UILabel alloc] initWithFrame:CGRectMake(200, 30, 200, 20)];
        ShowDate.text = show.Date;
        [ShowDate setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *LocationAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 320, 20)];
        LocationAddress.text = show.Location_Address;
        [LocationAddress setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *LocationCity = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 320, 20)];
        LocationCity.text = show.Location_Address;
        [LocationCity setFont:[UIFont systemFontOfSize:12]];
        
        [cell addSubview:BandName];
        [cell addSubview:ShowVenue];
        [cell addSubview:ShowDate];
        
        //If this is the row the user selected
        if (self.path.row == indexPath.row) {
            [cell addSubview:LocationAddress];
            [cell addSubview:LocationCity];
        }
    } else {
        //Portrait only code
        UILabel *BandName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 20)];
        BandName.text = show.bandName;
        
        UILabel *ShowDate = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, 20)];
        ShowDate.text = show.Date;
        [ShowDate setFont:[UIFont systemFontOfSize:12]];
        
        // To Do: Replace hard coded venue value with real data
        UILabel *ShowVenue = [ [UILabel alloc] initWithFrame:CGRectMake(200, 25, 150, 20)];
        ShowVenue.text = show.venueName;
        [ShowVenue setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *LocationAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 320, 20)];
        LocationAddress.text = show.Location_Address;
        [LocationAddress setFont:[UIFont systemFontOfSize:12]];
        
        [cell addSubview:BandName];
        [cell addSubview:ShowDate];
        [cell addSubview:ShowVenue];
        
        //If this is the row the user selected
        if (self.path.row == indexPath.row) {
            [cell addSubview:LocationAddress];
        }
        
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
