//
//  BandDetailsViewController.h
//  bandRides
//
//  Created by Kevin Strong on 2/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BandData.h"


@interface BandDetailsViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) BandData *band;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)showsClicked:(UIButton *)sender;
- (IBAction)musicClicked:(id)sender;

- (IBAction)videoClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
