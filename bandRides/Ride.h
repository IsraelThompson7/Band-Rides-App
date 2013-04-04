//
//  Ride.h
//  bandRides
//
//  Created by Marc Kluver on 3/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ride : NSObject

@property (nonatomic,retain) NSString *usersName;
@property (nonatomic) int howMany;
@property (nonatomic,retain) NSString *userCell;
@property (nonatomic,retain) NSString *userEmail;
@property (nonatomic,retain) NSString *showAddress;
@property (nonatomic,retain) NSString *showCity;
@property (nonatomic,retain) NSString *comments;

@end
