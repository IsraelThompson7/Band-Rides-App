//
//  BandDetailsViewController.h
//  bandRides
//
//  Created by Kevin Strong on 2/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BandDetailsViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSDictionary *band;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
