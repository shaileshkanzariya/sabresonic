//
//  FlightDetailsWebViewController.m
//  sabresonic
//
//  Created by Shailesh Kanzariya on 5/1/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import "FlightDetailsWebViewController.h"

@interface FlightDetailsWebViewController ()

@end

@implementation FlightDetailsWebViewController
@synthesize flightDetailsWebView;

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
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sabre.com"]];
    [self.flightDetailsWebView loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
