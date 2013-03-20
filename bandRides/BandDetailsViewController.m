//
//  BandDetailsViewController.m
//  bandRides
//
//  Created by Kevin Strong on 2/27/13.
//  Copyright (c) 2013 Kevin Strong. All rights reserved.
//

#import "BandDetailsViewController.h"
#import "ShowListViewController.h"
#import "OneBandShowDataSource.h"

@interface BandDetailsViewController ()

@end

@implementation BandDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Band Schedule" style:UIBarButtonItemStyleBordered target:self action:@selector(bandScheduleClicked)];
    self.navigationItem.rightBarButtonItem = button;
    
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:self.band[@"soundcloud"]]]];
    
    self.webView.delegate = self;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = request.URL.absoluteString;
    
    int location = [self.band[@"soundcloud"] rangeOfString:@".com/"].location;
    
    if (location != NSNotFound) {
        NSString *matchString = [self.band[@"soundcloud"] substringFromIndex:location];
        if ([urlString rangeOfString:matchString].location != NSNotFound) {
            return YES;
        }
    }
    [[UIApplication sharedApplication] openURL:request.URL];
    return NO;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y-45, self.webView.frame.size.width, self.webView.frame.size.height+45);
}

- (void)bandScheduleClicked
{
    [self performSegueWithIdentifier:@"segueToShows" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueToShows"]) {
        ShowListViewController *vc = segue.destinationViewController;
        vc.dataSource = [[OneBandShowDataSource alloc] initWithBand:self.band];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
