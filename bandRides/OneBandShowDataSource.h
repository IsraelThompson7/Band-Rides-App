//
//  OneBandShowDataSource.h
//  bandRides
//
//  Created by Kevin Strong on 3/6/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "BaseShowsDataSource.h"
#import "BandData.h"


@interface OneBandShowDataSource : BaseShowsDataSource

- (id)initWithBand:(BandData*)band;

@end
