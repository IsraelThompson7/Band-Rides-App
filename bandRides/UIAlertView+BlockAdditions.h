//
//  UIAlertView+BlockAdditions.h
//  MindBodyPOS
//
//  Created by Dan Twyman on 2/22/13.
//  Copyright (c) 2013 MindBody Online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (BlockAdditions)
+ (void) showAlertWithTitle: (NSString*) title
					message: (NSString*) message
		  cancelButtonTitle: (NSString*) cancelButtonTitle
		  otherButtonTitles: (NSArray*) otherButtonTitles
			completionBlock: (void (^)( UIAlertView* alert, NSUInteger buttonIndex )) completion;

+ (void) showAlertWithTitle: (NSString*) title
					message: (NSString*) message
		  cancelButtonTitle: (NSString*) cancelButtonTitle
		  otherButtonTitles: (NSArray*) otherButtonTitles
	   titleCompletionBlock: (void (^)( UIAlertView* alert, NSString* title )) completion;

- (id) initWithTitle: (NSString*) title
			 message: (NSString*) message
   cancelButtonTitle: (NSString*) cancelButtonTitle
   otherButtonTitles: (NSArray*) otherButtonTitles
	 completionBlock: (void (^)( UIAlertView* alert, NSUInteger buttonIndex )) completion;

- (id) initWithTitle: (NSString*) title
			 message: (NSString*) message
   cancelButtonTitle: (NSString*) cancelButtonTitle
   otherButtonTitles: (NSArray*) otherButtonTitles
titleCompletionBlock: (void (^)( UIAlertView* alert, NSString* title )) completion;
@end
