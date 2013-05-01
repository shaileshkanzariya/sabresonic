//
//  FlightDetailsWebViewController.h
//  sabresonic
//
//  Created by Shailesh Kanzariya on 5/1/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightDetailsWebViewController : UIViewController
{
    IBOutlet UIWebView *flightDetailsWebView;
}
@property(nonatomic, strong) IBOutlet UIWebView *flightDetailsWebView;

@end
