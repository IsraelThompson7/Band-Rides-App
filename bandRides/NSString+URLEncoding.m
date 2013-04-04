//
//  NSString+URLEncoding.m
//  bandRides
//
//  Created by Kevin Strong on 3/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

-(NSString*)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    //I looked in to this and its safe to do the __bridge_transfer here. What would not be safe is to do the (__bridge CFStringRef)self and hold on to that pointer
    //for more than the length of this function call. Basically if you save the CFStringRef made from an NSString it may be deallocated when you come back for it.
    
    return (__bridge_transfer NSString *) //<-- So here you convert from a non refferance counted string to a refferance counted string 
                                            CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (__bridge CFStringRef)self, //<-- Here we convert our refferance counted string to a non refferance counted pointer
                                            NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(encoding));

}

@end
