//
//  ShowListViewController.m
//  bandRides
//
//  Created by Marc Kluver on 3/6/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import "ShowListViewController.h"
#import "AFNetworking.h"
#import "ShowData.h"

@interface ShowListViewController ()

@end

@implementation ShowListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.showsArray = nil;
    
    NSString *urlString = @"http://kluver.homeunix.com:8080/~marc/shows.php?json";
    
    AFJSONRequestOperation *networkOp = [[AFJSONRequestOperation alloc]
                                         initWithRequest:[[NSURLRequest alloc] initWithURL:
                                                          [NSURL URLWithString:urlString]]];
    
    [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        self.showsArray = [NSMutableArray new];
        
        for (NSDictionary *dict in responseObject[@"shows"]) {
            ShowData *show = [ShowData new];
            
            show.bandName = dict[@"bandName"];
            show.bandImage = dict[@"bandImage"];
            show.bandScheduleID = dict[@"bandScheduleID"];
            show.Date = dict[@"Date"];
            show.Location_Address = dict[@"Location_Address"];
            show.Location_City = dict[@"Location_City"];
            show.Location_GPS_Lat = dict[@"Location_GPS_Lat"];
            show.Location_GPS_Lng = dict[@"Location_GPS_Lng"];
            show.bandID = dict[@"bandID"];
            
            [self.showsArray addObject:show];
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
