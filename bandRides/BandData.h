//
//  BandData.h
//  bandRides
//
//  Created by Marc Kluver on 3/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BandData : NSObject
@property (nonatomic) int bandID;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString *imageURL;
@property (nonatomic,retain) NSString *html_contentForApp;
@property (nonatomic,retain) NSString *soundcloud;
@property (nonatomic,retain) NSString *youTube;
@end
