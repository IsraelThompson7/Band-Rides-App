//
//  ShowData.h
//  bandRides
//
//  Created by Kevin Strong on 2/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowData : NSObject

@property (strong, nonatomic) NSString *bandName;
@property (strong, nonatomic) NSString *bandImage;
@property (strong, nonatomic) NSString *bandScheduleID;
@property (strong, nonatomic) NSString *Date;
@property (strong, nonatomic) NSString *Location_Address;
@property (strong, nonatomic) NSString *Location_City;
@property (strong, nonatomic) NSString *Location_GPS_Lat;
@property (strong, nonatomic) NSString *Location_GPS_Lng;
@property (strong, nonatomic) NSString *bandID;

@property (strong, nonatomic) NSString *venueName;
@property (strong, nonatomic) NSString *imageUrl;

-(id) initWithDictionary:(NSDictionary*)dict;
@end
