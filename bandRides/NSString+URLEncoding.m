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
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertEncodingToNSStringEncoding(encoding));
}

@end
