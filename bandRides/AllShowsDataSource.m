//
//  AllShowsDataSource.m
//  bandRides
//
//  Created by Kevin Strong on 3/6/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "AllShowsDataSource.h"
#import "AFNetworking.h"
#import "ShowData.h"

@implementation AllShowsDataSource

- (id)init
{
    if (self = [super init]) {
        self.showsArray = nil;
        
        NSString *urlString = @"http://kluver.homeunix.com:8080/~marc/shows.php?json";
        
        AFJSONRequestOperation *networkOp = [[AFJSONRequestOperation alloc]
                                             initWithRequest:[[NSURLRequest alloc] initWithURL:
                                                              [NSURL URLWithString:urlString]]];
        
        [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@", responseObject);
            
            self.showsArray = [NSMutableArray new];
            
            for (NSDictionary *dict in responseObject[@"shows"]) {
                ShowData *show = [[ShowData alloc] initWithDictionary:dict];
                
                [self.showsArray addObject:show];
            }
            
            [self.vc.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
        
        [networkOp start];
    }
    
    return self;
}

@end
