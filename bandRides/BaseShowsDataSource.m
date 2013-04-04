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
        
        UILabel *BandName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 320, 20)];
        BandName.text = show.bandName;
        [BandName setFont:[UIFont systemFontOfSize:26]];
        
        UILabel *ShowVenue = [ [UILabel alloc] initWithFrame:CGRectMake(380, 10, 200, 20)];
        ShowVenue.text = show.venueName;
        [ShowVenue setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *ShowDate = [[UILabel alloc] initWithFrame:CGRectMake(380, 25, 200, 20)];
        ShowDate.text = show.Date;
        [ShowDate setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *LocationAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 320, 20)];
        LocationAddress.text = show.Location_Address;
        [LocationAddress setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *LocationCity = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 320, 20)];
        LocationCity.text = show.Location_City;
        [LocationCity setFont:[UIFont systemFontOfSize:12]];
        
        [cell addSubview:BandName];
        [cell addSubview:ShowVenue];
        [cell addSubview:ShowDate];
        
        //If this is the row the user selected
        if (self.path.row == indexPath.row) {
            [cell addSubview:LocationAddress];
            [cell addSubview:LocationCity];
            
            [ShowVenue setFont:[UIFont systemFontOfSize:16]];
            
            ShowVenue.frame = CGRectMake(15, 50, 200, 20);
            ShowDate.frame = CGRectMake(15, 70, 200, 20);
            LocationAddress.frame = CGRectMake(15, 85, 200, 20);
            LocationCity.frame = CGRectMake(15, 100, 200, 20);
           
        } else {
            
        }
    } else {
        //Portrait only code
        UILabel *BandName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 20)];
        BandName.text = show.bandName;
        
        UILabel *ShowVenue = [ [UILabel alloc] initWithFrame:CGRectMake(10, 20, 150, 20)];
        ShowVenue.text = show.venueName;
        [ShowVenue setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *ShowDate = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, 20)];
        ShowDate.text = show.Date;
        [ShowDate setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *LocationAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 320, 20)];
        LocationAddress.text = show.Location_Address;
        [LocationAddress setFont:[UIFont systemFontOfSize:12]];
        
        UIImageView *BandImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        [BandImage setImageWithURL:[NSURL URLWithString:show.imageUrl]];
        
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
