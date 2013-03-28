//
//  UIActionSheet+BlockAdditions.h
//  MindBodyPOS
//
//  Created by Dan Twyman on 2/25/13.
//  Copyright (c) 2013 MindBody Online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (BlockAdditions) <UIActionSheetDelegate>
+ (void) showActionSheetWithTitle: (NSString*) title
				cancelButtonTitle: (NSString*) cancelButtonTitle
		   destructiveButtonTitle: (NSString*) destructiveButtonTitle
				otherButtonTitles: (NSArray*) otherButtonTitles
						   inView: (id) view
				  completionBlock: (void (^)( UIActionSheet* sheet, NSUInteger buttonIndex )) completion;

+ (void) showActionSheetWithTitle: (NSString*) title
				cancelButtonTitle: (NSString*) cancelButtonTitle
		   destructiveButtonTitle: (NSString*) destructiveButtonTitle
				otherButtonTitles: (NSArray*) otherButtonTitles
						   inView: (id) view
			 titleCompletionBlock: (void (^)( UIActionSheet* sheet, NSString* title )) completion;

- (id)   initWithTitle: (NSString*) title
     cancelButtonTitle: (NSString*) cancelButtonTitle
destructiveButtonTitle: (NSString*) destructiveButtonTitle
     otherButtonTitles: (NSArray*) otherButtonTitles
	   completionBlock: (void (^)( UIActionSheet* sheet, NSUInteger buttonIndex )) completion;

- (id)   initWithTitle: (NSString*) title
     cancelButtonTitle: (NSString*) cancelButtonTitle
destructiveButtonTitle: (NSString*) destructiveButtonTitle
     otherButtonTitles: (NSArray*) otherButtonTitles
  titleCompletionBlock: (void (^)( UIActionSheet* sheet, NSString* title )) completion;
@end
