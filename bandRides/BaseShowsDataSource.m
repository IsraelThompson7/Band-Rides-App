//
//  BaseShowsDataSource.m
//  bandRides
//
//  Created by Marc Kluver on 3/6/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import "BaseShowsDataSource.h"
#import "ShowData.h"

@implementation BaseShowsDataSource



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
