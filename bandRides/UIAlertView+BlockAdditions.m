//
//  UIAlertView+BlockAdditions.m
//  MindBodyPOS
//
//  Created by Dan Twyman on 2/22/13.
//  Copyright (c) 2013 MindBody Online. All rights reserved.
//

#import "UIAlertView+BlockAdditions.h"
#import <objc/runtime.h>

static	char	kTitleBlockKey;
static	char	kIndexBlockKey;

@implementation UIAlertView (BlockAdditions)
+ (void) showAlertWithTitle: (NSString*) title
					message: (NSString*) message
		  cancelButtonTitle: (NSString*) cancelButtonTitle
		  otherButtonTitles: (NSArray*) otherButtonTitles
			completionBlock: (void (^)( UIAlertView* alert, NSUInteger buttonIndex )) completion
{
	UIAlertView*	alert;

	alert = [[UIAlertView alloc] initWithTitle: title
									   message: message
							 cancelButtonTitle: cancelButtonTitle
							 otherButtonTitles: otherButtonTitles
							   completionBlock: completion];
	[alert show];
}

+ (void) showAlertWithTitle: (NSString*) title
					message: (NSString*) message
		  cancelButtonTitle: (NSString*) cancelButtonTitle
		  otherButtonTitles: (NSArray*) otherButtonTitles
	   titleCompletionBlock: (void (^)( UIAlertView* alert, NSString* title )) completion
{
	UIAlertView*	alert;

	alert = [[UIAlertView alloc] initWithTitle: title
									   message: message
							 cancelButtonTitle: cancelButtonTitle
							 otherButtonTitles: otherButtonTitles
						  titleCompletionBlock: completion];
	[alert show];
}

- (id) initWithTitle: (NSString*) title
			 message: (NSString*) message
   cancelButtonTitle: (NSString*) cancelButtonTitle
   otherButtonTitles: (NSArray*) otherButtonTitles
	 completionBlock: (void (^)( UIAlertView* alert, NSUInteger buttonIndex )) completion
{
	self = [self initWithTitle: title
					   message: message
					  delegate: self
			 cancelButtonTitle: cancelButtonTitle
			 otherButtonTitles: nil];

	if ( self )
	{
		objc_setAssociatedObject( self, &kIndexBlockKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC );

		if ( otherButtonTitles )
		{
			for( NSString* title in otherButtonTitles)
			{
				[self addButtonWithTitle: title];
			}
		}
	}

	return( self );
}

- (id) initWithTitle: (NSString*) title
			 message: (NSString*) message
   cancelButtonTitle: (NSString*) cancelButtonTitle
   otherButtonTitles: (NSArray*) otherButtonTitles
titleCompletionBlock: (void (^)( UIAlertView* alert, NSString* title )) completion
{
	self = [self initWithTitle: title
					   message: message
					  delegate: self
			 cancelButtonTitle: cancelButtonTitle
			 otherButtonTitles: nil];

	if ( self )
	{
		objc_setAssociatedObject( self, &kTitleBlockKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC );

		if ( otherButtonTitles )
		{
			for( NSString* title in otherButtonTitles)
			{
				[self addButtonWithTitle: title];
			}
		}
	}

	return( self );
}

- (void)			alertView: (UIAlertView*) alertView
	didDismissWithButtonIndex: (NSInteger) buttonIndex
{
	if ( objc_getAssociatedObject( self, &kIndexBlockKey ) )
	{
		void (^completion)( UIAlertView* alert, NSUInteger buttonIndex) = objc_getAssociatedObject( self, &kIndexBlockKey );

		completion( self, buttonIndex );

		objc_setAssociatedObject( self, &kIndexBlockKey, nil, OBJC_ASSOCIATION_ASSIGN );
	}
	else if ( objc_getAssociatedObject( self, &kTitleBlockKey ) )
	{
		void (^completion)( UIAlertView* alert, NSString* buttonTitle) = objc_getAssociatedObject( self, &kTitleBlockKey );

		completion( self, [self buttonTitleAtIndex: buttonIndex] );

		objc_setAssociatedObject( self, &kTitleBlockKey, nil, OBJC_ASSOCIATION_ASSIGN );
	}
}
@end
