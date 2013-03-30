//
//  ShowData.m
//  bandRides
//
//  Created by Kevin Strong on 2/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "ShowData.h"

@implementation ShowData
-(id) initWithDictionary:(NSDictionary*)dict{
    if (self = [super init]){
        
        self.bandName = dict[@"bandName"];
        self.bandImage = dict[@"bandImage"];
        self.bandScheduleID = dict[@"bandScheduleID"];
        self.Date = dict[@"Date"];
        self.Location_Address = dict[@"Location_Address"];
        self.Location_City = dict[@"Location_City"];
        self.Location_GPS_Lat = dict[@"Location_GPS_Lat"];
        self.Location_GPS_Lng = dict[@"Location_GPS_Lng"];
        self.bandID = dict[@"bandID"];
        self.venueName = dict[@"Location_Name"];
        self.imageUrl = dict[@"image_URL"];
    }
    return self;
}

@end
