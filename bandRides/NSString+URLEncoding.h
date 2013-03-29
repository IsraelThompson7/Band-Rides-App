//
//  NSString+URLEncoding.h
//  bandRides
//
//  Created by Kevin Strong on 3/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
-(NSString*) urlEncodeUsingEncoding:(NSStringEncoding)encoding;
@end
