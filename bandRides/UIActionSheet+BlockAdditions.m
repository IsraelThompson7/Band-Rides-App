//
//  UIActionSheet+BlockAdditions.m
//  MindBodyPOS
//
//  Created by Dan Twyman on 2/25/13.
//  Copyright (c) 2013 MindBody Online. All rights reserved.
//

#import "UIActionSheet+BlockAdditions.h"
#import <objc/runtime.h>

static	char	kTitleBlockKey;
static	char	kIndexBlockKey;

@implementation UIActionSheet (BlockAdditions)
+ (void) showActionSheetWithTitle: (NSString*) title
				cancelButtonTitle: (NSString*) cancelButtonTitle
		   destructiveButtonTitle: (NSString*) destructiveButtonTitle
				otherButtonTitles: (NSArray*) otherButtonTitles
						   inView: (id) view
				  completionBlock: (void (^)( UIActionSheet* sheet, NSUInteger buttonIndex )) completion;
{
	UIActionSheet*	sheet;

	sheet = [[UIActionSheet alloc] initWithTitle: title
							   cancelButtonTitle: cancelButtonTitle
						  destructiveButtonTitle: destructiveButtonTitle
							   otherButtonTitles: otherButtonTitles
								 completionBlock: completion];
	[sheet showInView: view];
}

+ (void) showActionSheetWithTitle: (NSString*) title
				cancelButtonTitle: (NSString*) cancelButtonTitle
		   destructiveButtonTitle: (NSString*) destructiveButtonTitle
				otherButtonTitles: (NSArray*) otherButtonTitles
						   inView: (id) view
			 titleCompletionBlock: (void (^)( UIActionSheet* sheet, NSString* title )) completion
{
	UIActionSheet*	sheet;

	sheet = [[UIActionSheet alloc] initWithTitle: title
							   cancelButtonTitle: cancelButtonTitle
						  destructiveButtonTitle: destructiveButtonTitle
							   otherButtonTitles: otherButtonTitles
							titleCompletionBlock: completion];

	[sheet showInView: view];
}

- (id)   initWithTitle: (NSString*) title
     cancelButtonTitle: (NSString*) cancelButtonTitle
destructiveButtonTitle: (NSString*) destructiveButtonTitle
     otherButtonTitles: (NSArray*) otherButtonTitles
	   completionBlock: (void (^)( UIActionSheet* sheet, NSUInteger buttonIndex )) completion
{
	self = [self initWithTitle: title
					  delegate: (id) self
			 cancelButtonTitle: cancelButtonTitle
		destructiveButtonTitle: destructiveButtonTitle
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

- (id)   initWithTitle: (NSString*) title
     cancelButtonTitle: (NSString*) cancelButtonTitle
destructiveButtonTitle: (NSString*) destructiveButtonTitle
     otherButtonTitles: (NSArray*) otherButtonTitles
  titleCompletionBlock: (void (^)( UIActionSheet* sheet, NSString* title )) completion
{
	self = [self initWithTitle: title
					  delegate: (id) self
			 cancelButtonTitle: cancelButtonTitle
		destructiveButtonTitle: destructiveButtonTitle
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
- (void)		  actionSheet: (UIActionSheet*) actionSheet
	didDismissWithButtonIndex: (NSInteger) buttonIndex
{
	if ( objc_getAssociatedObject( self, &kIndexBlockKey ) )
	{
		void (^completion)( UIActionSheet* sheet, NSUInteger buttonIndex) = objc_getAssociatedObject( self, &kIndexBlockKey );

		completion( self, buttonIndex );

		objc_setAssociatedObject( self, &kIndexBlockKey, nil, OBJC_ASSOCIATION_ASSIGN );
	}
	else if ( objc_getAssociatedObject( self, &kTitleBlockKey ) )
	{
		void (^completion)( UIActionSheet* sheet, NSString* buttonTitle) = objc_getAssociatedObject( self, &kTitleBlockKey );

		completion( self, [self buttonTitleAtIndex: buttonIndex] );

		objc_setAssociatedObject( self, &kTitleBlockKey, nil, OBJC_ASSOCIATION_ASSIGN );
	}
}
@end
